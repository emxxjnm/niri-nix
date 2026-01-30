## programs\.niri\.enable

Whether to enable Niri, a scrollable-tiling Wayland compositor\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```

*Declared by:*
 - [modules/nixos\.nix](https://codeberg.org/BANanaD3V/niri-nix/src/branch/main/modules/nixos.nix)



## programs\.niri\.package



The niri package to use\.



*Type:*
package



*Default:*

```nix
pkgs.niri
```

*Declared by:*
 - [modules/nixos\.nix](https://codeberg.org/BANanaD3V/niri-nix/src/branch/main/modules/nixos.nix)



## programs\.niri\.useNautilus



Whether to enable Nautilus as file-chooser for xdg-desktop-portal-gnome\.



*Type:*
boolean



*Default:*

```nix
true
```



*Example:*

```nix
true
```

*Declared by:*
 - [modules/nixos\.nix](https://codeberg.org/BANanaD3V/niri-nix/src/branch/main/modules/nixos.nix)



## programs\.niri\.withUWSM



Launch Niri with the Universal Wayland Session Manager\. This has better systemd support and automatically starts ` graphical-session.target ` and ` wayland-session@niri.target `\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```

*Declared by:*
 - [modules/nixos\.nix](https://codeberg.org/BANanaD3V/niri-nix/src/branch/main/modules/nixos.nix)



## programs\.niri\.withXDG



Enable XDG portal support for Niri\.



*Type:*
boolean



*Default:*

```nix
true
```



*Example:*

```nix
true
```

*Declared by:*
 - [modules/nixos\.nix](https://codeberg.org/BANanaD3V/niri-nix/src/branch/main/modules/nixos.nix)


