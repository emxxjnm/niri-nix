{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.programs.niri;
in
{
  options.programs.niri = {
    withUWSM = lib.mkEnableOption "UWSM support" // {
      description = ''
        Launch Niri with the Universal Wayland Session Manager. This has better systemd support and automatically starts `graphical-session.target` and `wayland-session@niri.target`.
      '';
    };
    withXDG = lib.mkEnableOption "XDG portal support" // {
      description = ''
        Enable XDG portal support for Niri.
      '';
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.uwsm = lib.mkIf cfg.withUWSM {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "Niri";
          comment = "A scrollable-tiling Wayland compositor";
          binPath = "/run/current-system/sw/bin/niri-session";
        };
      };
    };

    xdg.portal = lib.mkIf cfg.withXDG {
      enable = true;
      xdgOpenUsePortal = lib.mkDefault true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
      configPackages = [ cfg.package ];
    };
  };
}
