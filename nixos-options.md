## programs\.niri\.enable

Whether to enable Niri, a scrollable-tiling Wayland compositor\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `



## programs\.niri\.package



The niri package to use\.



*Type:*
package



*Default:*
` pkgs.niri `



## programs\.niri\.useNautilus



Whether to enable Nautilus as file-chooser for xdg-desktop-portal-gnome\.



*Type:*
boolean



*Default:*
` true `



*Example:*
` true `



## programs\.niri\.withUWSM



Launch Niri with the Universal Wayland Session Manager\. This has better systemd support and automatically starts ` graphical-session.target ` and ` wayland-session@niri.target `\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `



## programs\.niri\.withXDG



Enable XDG portal support for Niri\.



*Type:*
boolean



*Default:*
` true `



*Example:*
` true `


