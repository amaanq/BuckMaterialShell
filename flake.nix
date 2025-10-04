{
    description = "Buck Material Shell";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
        quickshell = {
            url = "git+https://git.outfoxxed.me/quickshell/quickshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        dgop = {
            url = "github:AvengeMedia/dgop";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        dykwabi-cli = {
            url = "github:amaanq/dykwabi";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        stash = {
            url = "github:notashelf/stash";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        quickshell,
        dgop,
        dykwabi-cli,
        stash,
        ...
    }: let
        forEachSystem = fn:
            nixpkgs.lib.genAttrs
            ["aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux"]
            (system: fn system nixpkgs.legacyPackages.${system});
    in {
        formatter = forEachSystem (_: pkgs: pkgs.alejandra);

        packages = forEachSystem (system: pkgs: {
            buckMaterialShell = pkgs.stdenvNoCC.mkDerivation {
                name = "buckMaterialShell";
                src = ./.;
                installPhase = ''
                    mkdir -p $out/etc/xdg/quickshell/BuckMaterialShell
                    cp -r . $out/etc/xdg/quickshell/BuckMaterialShell
                    ln -s $out/etc/xdg/quickshell/BuckMaterialShell $out/etc/xdg/quickshell/dykwabi
                '';
            };

            quickshell = quickshell.packages.${system}.default;

            default = self.packages.${system}.buckMaterialShell;
        });

        homeModules.default = {pkgs, ...}: let
            dykwabiPkgs = {
                dykwabiCli = dykwabi-cli.packages.${pkgs.system}.default;
                dgop = dgop.packages.${pkgs.system}.dgop;
                stash = stash.packages.${pkgs.stdenv.hostPlatform.system}.default;
                buckMaterialShell = self.packages.${pkgs.system}.buckMaterialShell;
            };
        in {
            imports = [./nix/default.nix ./nix/niri.nix];
            _module.args.dykwabiPkgs = dykwabiPkgs;
        };
    };
}
