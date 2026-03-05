{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.programs.niri;
  inherit (lib)
    mkIf
    mkMerge
    mkEnableOption
    mkPackageOption
    ;
in
{
  options.programs.niri = {
    enable = mkEnableOption "Niri, a scrollable-tiling Wayland compositor";

    package = mkPackageOption pkgs "niri" { };

    useNautilus = mkEnableOption "Nautilus as file-chooser for xdg-desktop-portal-gnome" // {
      default = true;
    };

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

  disabledModules = [ "programs/wayland/niri.nix" ];

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = [
        cfg.package
      ];

      services.dbus.packages = mkIf cfg.useNautilus [
        pkgs.nautilus
      ];

      services = {
        displayManager.sessionPackages = [ cfg.package ];

        gnome.gnome-keyring.enable = lib.mkDefault true;

        graphical-desktop.enable = true;
        xserver.desktopManager.runXdgAutostartIfNone = lib.mkDefault true;
      };

      security.polkit.enable = true;

      programs.dconf.enable = lib.mkDefault true;

      systemd.packages = [ cfg.package ];
    }
    (mkIf cfg.withUWSM {
      programs.uwsm = {
        enable = true;
        waylandCompositors = {
          niri = {
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
  ]);
}
