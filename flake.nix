{
    description = "Buck Material Shell";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
        dgop,
        dykwabi-cli,
        stash,
        ...
    }: let
        forEachSystem = fn:
            nixpkgs.lib.genAttrs
            ["aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux"]
            (system: fn system nixpkgs.legacyPackages.${system});
        buildDmsPkgs = pkgs: {
            dykwabiCli = dykwabi-cli.packages.${pkgs.system}.default;
            dgop = dgop.packages.${pkgs.system}.dgop;
            buckMaterialShell = self.packages.${pkgs.system}.buckMaterialShell;
            stash = stash.packages.${pkgs.system}.default;
        };
    in {
        formatter = forEachSystem (_: pkgs: pkgs.alejandra);

        packages = forEachSystem (system: pkgs: {
            buckMaterialShell = let
                mkDate = longDate: pkgs.lib.concatStringsSep "-" [
                    (builtins.substring 0 4 longDate)
                    (builtins.substring 4 2 longDate)
                    (builtins.substring 6 2 longDate)
                ];
            in pkgs.stdenvNoCC.mkDerivation {
                pname = "buckMaterialShell";
                version = pkgs.lib.removePrefix "v" (pkgs.lib.trim (builtins.readFile ./VERSION))
                    + "+date=" + mkDate (self.lastModifiedDate or "19700101")
                    + "_" + (self.shortRev or "dirty");
                src = pkgs.lib.cleanSourceWith {
                    src = ./.;
                    filter = path: type:
                        !(builtins.any (prefix: pkgs.lib.path.hasPrefix (./. + prefix) (/. + path)) [
                            /.github
                            /.gitignore
                            /dykwabi.spec
                            /dykwabi-greeter.spec
                            /nix
                            /flake.nix
                            /flake.lock
                            /alejandra.toml
                        ]);
                };
                installPhase = ''
                    mkdir -p $out/etc/xdg/quickshell/dykwabi
                    cp -r . $out/etc/xdg/quickshell/dykwabi
                '';
            };

            default = self.packages.${system}.buckMaterialShell;
        });

        homeModules.default = {pkgs, ...}: let
            dykwabiPkgs = buildDmsPkgs pkgs;
        in {
            imports = [./nix/default.nix ./nix/niri.nix];
            _module.args.dykwabiPkgs = dykwabiPkgs;
        };

        nixosModules.greeter = {pkgs, ...}: let
            dykwabiPkgs = buildDmsPkgs pkgs;
        in {
            imports = [./nix/greeter.nix];
            _module.args.dykwabiPkgs = dykwabiPkgs;
        };
    };
}
