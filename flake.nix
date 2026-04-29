{
  description = "A scrollable-tiling Wayland compositor.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

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

            shell = pkgs.mkShell {
                shellHook = /*sh*/''
                    cat > .git/hooks/pre-commit<< EOF
                    #!/usr/bin/env bash

                    cat "$(nix build .#docs-nixos --print-out-paths --no-link)" > ./nixos-options.md
                    cat "$(nix build .#docs-home --print-out-paths --no-link)" > ./home-options.md

                    git add ./nixos-options.md
                    git add ./home-options.md
                    EOF

                    chmod +x .git/hooks/pre-commit
                '';
            };
          in
            shell;
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
