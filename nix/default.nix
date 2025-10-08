{
    config,
    pkgs,
    lib,
    dykwabiPkgs,
    ...
}: let
    cfg = config.programs.buckMaterialShell;
in {
    options.programs.buckMaterialShell = with lib.types; {
        enable = lib.mkEnableOption "BuckMaterialShell";

        enableSystemd = lib.mkEnableOption "BuckMaterialShell systemd startup";
        enableSystemMonitoring = lib.mkOption {
            type = bool;
            default = true;
            description = "Add needed dependencies to use system monitoring widgets";
        };
        enableClipboard = lib.mkOption {
            type = bool;
            default = true;
            description = "Add needed dependencies to use the clipboard widget";
        };
        enableVPN = lib.mkOption {
            type = bool;
            default = true;
            description = "Add needed dependencies to use the VPN widget";
        };
        enableBrightnessControl = lib.mkOption {
            type = bool;
            default = true;
            description = "Add needed dependencies to have brightness/backlight support";
        };
        enableNightMode = lib.mkOption {
            type = bool;
            default = true;
            description = "Add needed dependencies to have night mode support";
        };
        enableDynamicTheming = lib.mkOption {
            type = bool;
            default = true;
            description = "Add needed dependencies to have dynamic theming support";
        };
        enableAudioWavelength = lib.mkOption {
            type = bool;
            default = true;
            description = "Add needed dependencies to have audio waveleng support";
        };
        enableColorPicker = lib.mkOption {
          type = bool;
          default = true;
          description = "Add support for the color picker";
        };
        enableCalendarEvents = lib.mkOption {
            type = bool;
            default = true;
            description = "Add calendar events support via khal";
        };
        quickshell = {
            package = lib.mkPackageOption pkgs "quickshell" {};
        };
    };

    config = lib.mkIf cfg.enable
    {
        programs.quickshell = {
            enable = true;
            package = cfg.quickshell.package;

            configs.dykwabi = "${
                dykwabiPkgs.buckMaterialShell
            }/etc/xdg/quickshell/BuckMaterialShell";
            activeConfig = lib.mkIf cfg.enableSystemd "dykwabi";

            systemd = lib.mkIf cfg.enableSystemd {
                enable = true;
                target = "graphical-session.target";
            };
        };

        home.packages =
            [
                pkgs.material-symbols
                pkgs.inter
                pkgs.fira-code

                pkgs.ddcutil
                pkgs.libsForQt5.qt5ct
                pkgs.kdePackages.qt6ct

                dykwabiPkgs.dykwabiCli
            ]
            ++ lib.optional cfg.enableSystemMonitoring dykwabiPkgs.dgop
            ++ lib.optionals cfg.enableClipboard [dykwabiPkgs.stash pkgs.wl-clipboard]
            ++ lib.optionals cfg.enableVPN [pkgs.glib pkgs.networkmanager]
            ++ lib.optional cfg.enableBrightnessControl pkgs.brightnessctl
            ++ lib.optional cfg.enableNightMode pkgs.gammastep
            ++ lib.optional cfg.enableDynamicTheming pkgs.matugen
            ++ lib.optional cfg.enableAudioWavelength pkgs.cava
            ++ lib.optional cfg.enableColorPicker pkgs.kdePackages.kcolorchooser
            ++ lib.optional cfg.enableCalendarEvents pkgs.khal;
    };
}
