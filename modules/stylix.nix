{ config, lib, ... }:
let
  scfg = config.stylix;
  slib = config.lib.stylix;
in
{
  options.stylix.targets.niri = {
    enable = slib.mkEnableTarget "niri" true;
  };

  config = lib.mkIf (scfg.enable && scfg.targets.niri.enable) {
    wayland.windowManager.niri.settings = {
      cursor = lib.mkIf (scfg.cursor != null) {
        xcursor-theme = lib.mkDefault scfg.cursor.name;
        xcursor-size = lib.mkDefault scfg.cursor.size;
      };

      layout = with slib.colors.withHashtag; {
        border = {
          active-color = lib.mkDefault base0D;
          urgent-color = lib.mkDefault base08;
          inactive-color = lib.mkDefault base03;
        };

        focus-ring = {
          active-color = lib.mkDefault base0D;
          urgent-color = lib.mkDefault base08;
          inactive-color = lib.mkDefault base03;
        };

        tab-indicator = {
          active-color = lib.mkDefault base0B;
          urgent-color = lib.mkDefault base09;
          inactive-color = lib.mkDefault base04;
        };

        insert-hint.color = lib.mkDefault "${base07}80"; # 50% opacity
      };

      recent-windows.highlight = with slib.colors.withHashtag; {
        active-color = lib.mkDefault base02;
        urgent-color = lib.mkDefault base0F;
      };
    };
  };
}
