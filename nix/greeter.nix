{
    lib,
    config,
    pkgs,
    dykwabiPkgs,
    ...
}: let
    inherit (lib) types;
    cfg = config.programs.buckMaterialShell.greeter;

    user = config.services.greetd.settings.default_session.user;

    greeterScript = pkgs.writeShellScriptBin "dykwabi-greeter" ''
        export PATH=$PATH:${lib.makeBinPath [ cfg.quickshell.package config.programs.${cfg.compositor.name}.package ]}
        ${lib.escapeShellArgs ([
            "sh"
            "${../Modules/Greetd/assets/dykwabi-greeter}"
            "--cache-dir"
            "/var/lib/dykwabigreeter"
            "--command"
            cfg.compositor.name
            "-p"
            "${dykwabiPkgs.buckMaterialShell}/etc/xdg/quickshell/dykwabi"
        ]
        ++ lib.optionals (cfg.compositor.customConfig != "") [
            "-C"
            "${pkgs.writeText "dykwabigreeter-compositor-config" cfg.compositor.customConfig}"
        ])} ${lib.optionalString cfg.logs.save "> ${cfg.logs.path} 2>&1"}
    '';
in {
    imports =
        let
            msg = "The option 'programs.buckMaterialShell.greeter.compositor.extraConfig' is deprecated. Please use 'programs.buckMaterialShell.greeter.compositor.customConfig' instead.";
        in
        [ (lib.mkRemovedOptionModule [ "programs" "buckMaterialShell" "greeter" "compositor" "extraConfig" ] msg) ];

    options.programs.buckMaterialShell.greeter = {
        enable = lib.mkEnableOption "BuckMaterialShell greeter";
        compositor.name = lib.mkOption {
            type = types.enum ["niri" "hyprland" "sway"];
            description = "Compositor to run greeter in";
        };
        compositor.customConfig = lib.mkOption {
            type = types.lines;
            default = "";
            description = "Custom compositor config";
        };
        configFiles = lib.mkOption {
            type = types.listOf types.path;
            default = [];
            description = "Config files to copy into data directory";
            example = [
                "/home/user/.config/BuckMaterialShell/settings.json"
            ];
        };
        configHome = lib.mkOption {
            type = types.nullOr types.str;
            default = null;
            example = "/home/user";
            description = ''
                User home directory to copy configurations for greeter
                If Dykwabi config files are in non-standard locations then use the configFiles option instead
            '';
        };
        quickshell = {
            package = lib.mkPackageOption pkgs "quickshell" {};
        };
        logs.save = lib.mkEnableOption "saving logs from Dykwabi greeter to file";
        logs.path = lib.mkOption {
            type = types.path;
            default = "/tmp/dykwabi-greeter.log";
            description = ''
                File path to save Dykwabi greeter logs to
            '';
        };
    };
    config = lib.mkIf cfg.enable {
        assertions = [
            {
                assertion = (config.users.users.${user} or { }) != { };
                message = ''
                    dykwabigreeter: user set for greetd default_session ${user} does not exist. Please create it before referencing it.
                '';
            }
        ];
        services.greetd = {
            enable = lib.mkDefault true;
            settings.default_session.command = lib.mkDefault (lib.getExe greeterScript);
        };
        fonts.packages = with pkgs; [
            fira-code
            inter
            material-symbols
        ];
        systemd.tmpfiles.settings."10-dykwabigreeter" = {
            "/var/lib/dykwabigreeter".d = {
                user = user;
                group = if config.users.users.${user}.group != ""
                    then config.users.users.${user}.group else "greeter";
                mode = "0755";
            };
        };
        systemd.services.greetd.preStart = ''
            cd /var/lib/dykwabigreeter
            ${lib.concatStringsSep "\n" (lib.map (f: ''
                if [ -f "${f}" ]; then
                    cp "${f}" .
                fi
            '') cfg.configFiles)}

            if [ -f session.json ]; then
                if cp "$(${lib.getExe pkgs.jq} -r '.wallpaperPath' session.json)" wallpaper.jpg; then
                    mv session.json session.orig.json
                    ${lib.getExe pkgs.jq} '.wallpaperPath = "/var/lib/dykwabigreeter/wallpaper.jpg"' session.orig.json > session.json
                fi
            fi

            mv dykwabi-colors.json colors.json || :
            chown ${user}: * || :
        '';
        programs.buckMaterialShell.greeter.configFiles = lib.mkIf (cfg.configHome != null) [
            "${cfg.configHome}/.config/BuckMaterialShell/settings.json"
            "${cfg.configHome}/.local/state/BuckMaterialShell/session.json"
            "${cfg.configHome}/.cache/BuckMaterialShell/dykwabi-colors.json"
        ];
    };
}
