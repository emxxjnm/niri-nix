## wayland\.windowManager\.niri\.enable

Whether to enable Niri, a scrollable tiling Wayland compositor\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [modules/home\.nix](https://codeberg.org/BANanaD3V/niri-nix/src/branch/main/modules/home.nix)



## wayland\.windowManager\.niri\.package



The niri package to use\. The Niri package to use\. Set this to null if you use the NixOS module to install Niri\.



*Type:*
null or package



*Default:*
` pkgs.niri `

*Declared by:*
 - [modules/home\.nix](https://codeberg.org/BANanaD3V/niri-nix/src/branch/main/modules/home.nix)



## wayland\.windowManager\.niri\.extraConfig



Extra configuration lines to be added verbatim\.



*Type:*
strings concatenated with “\\n”



*Default:*
` "" `

*Declared by:*
 - [modules/home\.nix](https://codeberg.org/BANanaD3V/niri-nix/src/branch/main/modules/home.nix)



## wayland\.windowManager\.niri\.finalConfig



The final config applied to niri\.



*Type:*
strings concatenated with “\\n”



*Default:*
` (self.lib.mkNiriKDL cfg.settings) + "\n" + cfg.extraConfig `

*Declared by:*
 - [modules/home\.nix](https://codeberg.org/BANanaD3V/niri-nix/src/branch/main/modules/home.nix)



## wayland\.windowManager\.niri\.settings



KDL configuration for Niri written in Nix\.



*Type:*
open submodule of attribute set of anything



*Default:*
` { } `



*Example:*

```
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
        _props.app-id._raw = r#"^org\.telegram\.desktop$"#;
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

```

*Declared by:*
 - [modules/home\.nix](https://codeberg.org/BANanaD3V/niri-nix/src/branch/main/modules/home.nix)



## wayland\.windowManager\.niri\.systemd\.variables



Environment variables to be imported in the systemd \& D-Bus user
environment\.



*Type:*
list of string



*Default:*

```
[
  "DISPLAY"
  "HYPRLAND_INSTANCE_SIGNATURE"
  "WAYLAND_DISPLAY"
  "XDG_CURRENT_DESKTOP"
]
```



*Example:*

```
[
  "--all"
]
```

*Declared by:*
 - [modules/home\.nix](https://codeberg.org/BANanaD3V/niri-nix/src/branch/main/modules/home.nix)



## wayland\.windowManager\.niri\.validation\.enable



Enable niri config validation using the ` niri validate ` command\.



*Type:*
boolean



*Default:*
` true `



*Example:*
` true `

*Declared by:*
 - [modules/home\.nix](https://codeberg.org/BANanaD3V/niri-nix/src/branch/main/modules/home.nix)


