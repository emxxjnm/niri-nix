{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.programs.niri;
  inherit (lib) mkIf mkMerge mkEnableOption;
in
{
  options.programs.niri = {
    withUWSM = mkEnableOption "UWSM support" // {
      description = ''
        Launch Niri with the Universal Wayland Session Manager. This has better systemd support and automatically starts `graphical-session.target` and `wayland-session@niri.target`.
      '';
    };
    withXDG = mkEnableOption "XDG portal support" // {
      description = ''
        Enable XDG portal support for Niri.
      '';
      default = true;
    };
  };

  config = mkIf cfg.enable mkMerge [
    (mkIf cfg.withUWSM {
      programs.uwsm = {
        enable = true;
        waylandCompositors = {
          hyprland = {
            prettyName = "Niri";
            comment = "A scrollable-tiling Wayland compositor";
            binPath = "/run/current-system/sw/bin/niri-session";
          };
        };
      };
    })
    (mkIf cfg.withXDG {
      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = lib.mkDefault true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
          xdg-desktop-portal-gtk
        ];
        configPackages = [ cfg.package ];
      };
    })
  ];
}
