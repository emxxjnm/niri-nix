{ self, ... }:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) types mkOption;

  cfg = config.wayland.windowManager.niri;
in
{
  options.wayland.windowManager.niri = {
    enable = lib.mkEnableOption "Niri, a scrollable tiling Wayland compositor";

    package = lib.mkPackageOption pkgs "niri" {
      nullable = true;
      extraDescription = "The Niri package to use. Set this to null if you use the NixOS module to install Niri.";
    };

    settings = mkOption {
      type =
        with lib.types;
        let
          valueType =
            nullOr (oneOf [
              bool
              int
              float
              str
              path
              (attrsOf valueType)
              (listOf valueType)
            ])
            // {
              description = "Niri configuration value";
            };
        in
        types.submodule {
          freeformType = valueType;
        };
      default = { };
      description = ''
        KDL configuration for Niri written in Nix.
      '';
      example = lib.literalExpression ''
        {
          output = [
            {
              _args = ["DP-0"];
              mode = "1920x1080@60";
              position._props = {
                x = 0;
                y = 0;
              };
            }
            {
              _args = ["DP-1"];
              mode = "2560x1440@60";
              position._props = {
                x = 1920;
                y = 0;
              };
            }
          ];
          input = {
            keyboard.xkb = {
              layout = "us";
            };
          };
          layout = {
            preset-column-widths._children = [
              {proportion = 0.33333;}
              {proportion = 0.5;}
              {proportion = 0.66667;}
              {proportion = 1.0;}
            ];
            focus-ring.off = [];
          };

          window-rule = [
            {
              match = {
                _props.app-id._raw = ${''r#"^org\.telegram\.desktop$"#''};
              };

              block-out-from = "screen-capture";
            }
          ];

          binds = {
            "Mod+TouchpadScrollDown" = {
              _props = {
                cooldown-ms = 500;
              };
              focus-workspace-down = [];
            };
            "Mod+T" = {
              spawn = "alacritty";
            };
            XF86AudioRaiseVolume = {
              spawn-sh = [
                "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"
              ];
            };
          };
          spawn-sh-at-startup = [
            ["wl-paste --type text --watch cliphist store"]
            ["wl-paste --type image --watch cliphist store"]
          ];

          include = ["colors.kdl"]; # Includes are excluded from niri config validation
        }
      '';
    };

    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = ''
        Extra configuration lines to be added verbatim.
      '';
    };

    validation.enable = lib.mkEnableOption "niri config validation" // {
      description = ''
        Enable niri config validation using the `niri validate` command.
      '';
      default = true;
    };

    finalConfig = mkOption {
      type = types.lines;
      default = (self.lib.mkNiriKDL cfg.settings) + "\n" + cfg.extraConfig;
      defaultText = lib.literalExpression ''(self.lib.mkNiriKDL cfg.settings) + "\n" + cfg.extraConfig'';
      description = ''
        The final config applied to niri.
      '';
    };

    systemd = {
      variables = lib.mkOption {
        type = types.listOf types.str;
        default = [
          "DISPLAY"
          "HYPRLAND_INSTANCE_SIGNATURE"
          "WAYLAND_DISPLAY"
          "XDG_CURRENT_DESKTOP"
        ];
        example = [ "--all" ];
        description = ''
          Environment variables to be imported in the systemd & D-Bus user
          environment.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.mkIf (cfg.package != null) [ cfg.package ];

    xdg.configFile =
      if cfg.validation.enable then
        {
          niri = {
            target = "niri/config.kdl";
            source = self.lib.validatedConfigFor cfg.package cfg.finalConfig;
          };
        }
      else
        { "niri/config.kdl".text = cfg.finalConfig; };
  };
}
