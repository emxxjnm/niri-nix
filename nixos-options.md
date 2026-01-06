## programs\.niri\.enable

Whether to enable Niri, a scrollable-tiling Wayland compositor\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/m6942g96429kif1p92s2ij7xhb93np23-source/modules/nixos\.nix](file:///nix/store/m6942g96429kif1p92s2ij7xhb93np23-source/modules/nixos.nix)



## programs\.niri\.package



The niri package to use\.



*Type:*
package



*Default:*
` pkgs.niri `

*Declared by:*
 - [/nix/store/m6942g96429kif1p92s2ij7xhb93np23-source/modules/nixos\.nix](file:///nix/store/m6942g96429kif1p92s2ij7xhb93np23-source/modules/nixos.nix)



## programs\.niri\.useNautilus



Whether to enable Nautilus as file-chooser for xdg-desktop-portal-gnome\.



*Type:*
boolean



*Default:*
` true `



*Example:*
` true `

*Declared by:*
 - [/nix/store/m6942g96429kif1p92s2ij7xhb93np23-source/modules/nixos\.nix](file:///nix/store/m6942g96429kif1p92s2ij7xhb93np23-source/modules/nixos.nix)



## programs\.niri\.withUWSM



Launch Niri with the Universal Wayland Session Manager\. This has better systemd support and automatically starts ` graphical-session.target ` and ` wayland-session@niri.target `\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/m6942g96429kif1p92s2ij7xhb93np23-source/modules/nixos\.nix](file:///nix/store/m6942g96429kif1p92s2ij7xhb93np23-source/modules/nixos.nix)



## programs\.niri\.withXDG



Enable XDG portal support for Niri\.



*Type:*
boolean



*Default:*
` true `



*Example:*
` true `

*Declared by:*
 - [/nix/store/m6942g96429kif1p92s2ij7xhb93np23-source/modules/nixos\.nix](file:///nix/store/m6942g96429kif1p92s2ij7xhb93np23-source/modules/nixos.nix)


