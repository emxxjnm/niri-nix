# Niri Nix

A flake for configuring the [Niri](https://github.com/YaLTeR/niri) window
manager with Nix.

The options are described in [nixos-options.md](./nixos-options.md) and
[home-options.md](./home-options.md) respectfully.

# Installation

To install the flake, add the following input to your `flake.nix`:

```nix
niri-nix = {
  url = "git+https://codeberg.org/BANanaD3V/niri-nix";
};
```

The flake provides both NixOS and home-manager modules.

```nix
imports = [ inputs.niri-nix.nixosModules.default ]; # For NixOS
imports = [ inputs.niri-nix.homeModules.default ]; # For home-manager
```

# Overlays

The flake provides an overlay and a binary cache for packages. The packages are
`niri-unstable` and `xwayland-satellite-unstable`.

The binary cache is located at `https://niri-nix.cachix.org`, the public key is
`niri-nix.cachix.org-1:SvFtqpDcf7Sm1SMJdby1/+Y+6f3Yt3/3PMcSTKPJNJ0=`.

## Niri unstable

To use niri unstable, add the overlay and the binary cache and then set
`programs.niri.package` for the NixOS module and
`wayland.windowManager.niri.package` for home-manager. You do not need to set
the home-manager package if you're using the NixOS module to install niri.

> [!IMPORTANT]
> By using the binary cache you are trusting me not to compromise your system
> and serve you malicious packages. The module will never automatically add the
> cache. The default cache priority is `41`, which is below `cache.nixos.org`.
> Proceed at your own discretion.

```nix
{inputs, pkgs, ...}: {
  nix = {
    substituters = [
      "https://niri-nix.cachix.org"
    ];
    trusted-public-keys = [
      "niri-nix.cachix.org-1:SvFtqpDcf7Sm1SMJdby1/+Y+6f3Yt3/3PMcSTKPJNJ0="
    ];
  };
  nixpkgs.overlays = [ inputs.niri-nix.overlays.niri-nix ];
  programs.niri.package = pkgs.niri-unstable; 
}
```

# NixOS module

## UWSM

The NixOS module allows you to use [UWSM](https://github.com/Vladimir-csp/uwsm)
to launch Niri. To do so, enable `programs.niri.withUWSM`.

## XDG

The NixOS module automatically enables XDG portal configuration for you. To
disable the functionality, disable `programs.niri.withXDG`.

# home-manager module

## Niri configuration

To configure niri you generally should use the provided home-manager options,
`wayland.windowManager.niri.settings` and
`wayland.windowManager.niri.extraConfig`. The options follow the
[RFC 42](https://github.com/NixOS/rfcs/blob/master/rfcs/0042-config-option.md).
This means that the options are freeform and checked during build by running
`niri validate`. The `extraConfig` value is appended after `settings`.

You can disable validation by setting
`wayland.windowManager.niri.validation.enable` to `false`.

All KDL attributes are exposed to Nix. For writing regular nodes, use the nix
syntax. For arguments and properties, see below.

1. You can set [arguments](https://kdl.dev/spec/#name-argument) by using the
   `_args` field:

```nix
output = [
  {
    _args = ["DP-0"];
    mode = "1920x1080@60";
  }
  {
    _args = ["DP-1"];
    mode = "2560x1440@60";
  }
];
```

This results in the following KDL config:

```kdl
output "DP-0" {
 mode "1920x1080@60"
}
output "DP-1" {
 mode "2560x1440@60"
}
```

2. For [properties](https://kdl.dev/spec/#name-property) you can similarly use
   the `_props` field. Let us try to extend our previous output config:

```nix
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
```

The resulting config will now be as follows:

```kdl
output "DP-0" {
 mode "1920x1080@60"
  position x=0 y=0
}
output "DP-1" {
 mode "2560x1440@60"
  position x=1920 y=0
}
```

3. For an array of children with same property names, for example the
   `preset-column-widths`, use the `_children` field:

```nix
layout.preset-column-widths._children = [
  {proportion = 0.33333;}
  {proportion = 0.5;}
  {proportion = 0.66667;}
  {proportion = 1.0;}
];
```

The resulting KDL:

```kdl
layout {
  preset-column-widths {
  proportion 0.333330
  proportion 0.500000
  proportion 0.666670
  proportion 1.000000
 }
}
```

4. The library also provides a way to set raw values, for example, to use
   regular expressions. To do so, use the `_raw` attribute:

```nix
window-rule = [
  {
    match = {
      _props.app-id._raw = ''r#"^org\.telegram\.desktop$"#'';
    };

    block-out-from = "screen-capture";
  }
];
```

This should be everything required to fully configure Niri.

For an example configuration, see
[the options reference](./home-options.md#wayland-windowmanager-niri-settings)

## Usage without home-manager

If you do not wish to use home-manager, the flake provides a `lib` output
containing all the necessary functions to configure Niri.

```nix
{ inputs, pkgs, ... }: let
  inherit (inputs.niri-nix.lib) validatedConfigFor mkNiriKDL;
  inherit (inputs.niri-nix.packages.${pkgs.stdenv.hostPlatform.system}) niri-unstable;
  myConfig = {
    output = [
      {
        _args = ["DP-0"];
        mode = "1920x1080@60";
      }
      {
        _args = ["DP-1"];
        mode = "2560x1440@60";
      }
    ];
  };
in {
  # If you need to validate your configuration, use this pattern:
  xdg.configFile.my-niri = { # niri-nix uses "niri" as the attribute
    target = "niri/config-validated.kdl"; # niri-nix uses "niri/config.kdl"
    source = validatedConfigFor niri-unstable (mkNiriKDL myConfig);
  };

  # If you don't need validation, just use a path and text attribute:
  xdg.configFile."niri/config-plain.kdl".text = mkNiriKDL myConfig;
}
```

# Credits

- [home-manager](https://github.com/nix-community/home-manager) for the initial
  `toKDL` function
- [Naxdy/niri](https://github.com/naxdy/niri) for the required home-manager
  `systemd` option and slight `toKDL` improvements.
- [niri-flake](https://github.com/sodiboo/niri-flake/) for some code snippets
  (portals, etc).
