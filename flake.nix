{
  description = "A scrollable-tiling Wayland compositor.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    git-hooks.url = "github:cachix/git-hooks.nix";

    niri-unstable.url = "github:YaLTeR/niri";
    xwayland-satellite-unstable.url = "github:Supreeeme/xwayland-satellite";

    niri-unstable.flake = false;
    xwayland-satellite-unstable.flake = false;
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
      ];
      lib' = import ./lib { inherit self nixpkgs lib; };
    in
    {
      lib = lib';

      formatter = forAllSystems (system: inputs.nixpkgs.legacyPackages.${system}.nixfmt-tree);

      devShells = forAllSystems (system: {
        default =
          let
            pkgs = nixpkgs.legacyPackages.${system};
            shell = inputs.git-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                nixfmt.enable = true;
                generate-docs =
                  let
                    pkgs = nixpkgs.legacyPackages.${system};
                  in
                  {
                    enable = true;
                    name = "Generate docs for niri-nix";
                    files = ".*";
                    language = "system";
                    entry =
                      (pkgs.writeShellScript "generate-docs.sh" ''
                        cat $(nix build .#packages.${system}.docs-nixos --print-out-paths --no-link) > ./nixos-options.md
                        cat $(nix build .#packages.${system}.docs-home --print-out-paths --no-link) > ./home-options.md
                        git add ./nixos-options.md
                        git add ./home-options.md
                      '').outPath;
                    stages = [ "pre-commit" ];
                  };
              };
            };
            inherit (shell) shellHook enabledPackages;
          in
          pkgs.mkShell {
            inherit shellHook;
            buildInputs = enabledPackages;
          };
      });

      packages = forAllSystems (
        system:
        import ./packages {
          inherit self inputs lib;
          pkgs = inputs.nixpkgs.legacyPackages.${system};
        }
      );

      overlays.niri-nix =
        final: prev:
        import ./packages {
          inherit self inputs lib;
          pkgs = final;
        };

      nixosModules = {
        niri-nix = ./modules/nixos.nix;
        default = self.nixosModules.niri-nix;
      };

      homeModules = {
        niri-nix = lib.modules.importApply ./modules/home.nix { inherit self; };
        default = self.homeModules.niri-nix;
      };
    };
}
