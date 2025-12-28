{
  self,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  niri-unstable = pkgs.callPackage ./niri.nix {
    inherit self;
    src = inputs.niri-unstable;
  };
  xwayland-satellite-unstable = pkgs.callPackage ./xwayland-satellite.nix {
    inherit self;
    src = inputs.xwayland-satellite-unstable;
  };

  docs-nixos = pkgs.callPackage ./docs.nix {
    inherit lib pkgs;
    modules = [
      self.nixosModules.default
    ];
  };

  docs-home = pkgs.callPackage ./docs.nix {
    inherit lib pkgs;
    modules = [
      self.homeModules.default
    ];
  };
}
