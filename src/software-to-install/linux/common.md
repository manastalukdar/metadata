# Linux (common)

Notes and tools shared across Linux distributions. Distribution-specific package lists and setup live under each distro directory:

- [Ubuntu](ubuntu/) — [packages](ubuntu/packages.md), [post-install](ubuntu/post-install.md)
- [Fedora](fedora/) — [packages](fedora/packages.md), [post-install](fedora/post-install.md), [NVIDIA](fedora/nvidia.md), [OneDrive](fedora/onedrive.md)

Cross-platform tools (languages, editors, CLI utilities, etc.) live under [../common/](../common/). This file holds tools that are Linux-only but work on every distribution — desktop apps, GNOME pieces and font packages — so the `dnf:`/`apt:`/`flatpak:` tags are in one place rather than duplicated per distro.

## Mandatory

### Desktop applications

- [Resources](https://github.com/nokyan/resources) `flatpak:net.nokyan.Resources` — system monitor
- [Text Pieces](https://github.com/liferooter/textpieces) `flatpak:com.github.liferooter.textpieces` — quick text processing
- Shortwave `flatpak:de.haeckerfelix.Shortwave` — internet radio
- [Kooha](https://github.com/SeaDve/Kooha) `flatpak:io.github.seadve.Kooha` — screen recorder, works on Wayland
- [Terminator](https://github.com/gnome-terminator/terminator) `dnf:terminator` `apt:terminator`

    ```plaintext
    Create more terminals by:
        horizontal split: `Ctrl-Shift-o`
        vertical split: `Ctrl-Shift-e`
    Shift focus to:
        next terminal: Ctrl-Shift-n
        previous terminal: Ctrl-Shift-p
    New tab: Ctrl-Shift-t
    New window: Ctrl-Shift-i
    Close terminal or tab:
        Ctrl-Shift-w
        or right mouse click -> Close
    Close window with all it's terminals and tabs: Ctrl-Shift-q
    Reset zoom: Ctrl-0
    ```

- [Nautilus My Computer](https://github.com/yannmasoch/nautilus-my-computer) `manual`
- [Peek](https://github.com/phw/peek) `dnf:peek` `apt:peek` — GIF screen recorder

### Desktop environment

- Gnome Tweaks `dnf:gnome-tweaks` `apt:gnome-tweaks`
- Gnome Extensions app `dnf:gnome-extensions-app` `apt:gnome-shell-extension-manager` `apt:gnome-shell-extension-prefs`
- Dash to Dock `dnf:gnome-shell-extension-dash-to-dock`
  - Ubuntu ships its own Ubuntu Dock; see [How to Bring out Bottom Dock Launcher from Activities View in Fedora Gnome 40](https://fostips.com/bring-out-bottom-dock-fedora-gnome/).
- Gnome Font Viewer `dnf:gnome-font-viewer` `apt:gnome-font-viewer`
- Gnome Screenshot `dnf:gnome-screenshot` `apt:gnome-screenshot`
- Blueman bluetooth manager `dnf:blueman` `apt:blueman`
- [Ulauncher](https://github.com/Ulauncher/Ulauncher/) `dnf:ulauncher` `apt:ulauncher`
  - Ubuntu needs the `ppa:agornostal/ulauncher` PPA, added by `setup-ubuntu.sh`.
- [polybar](https://github.com/polybar/polybar) `dnf:polybar` `apt:polybar`
- [conky](https://github.com/brndnmtthws/conky) `dnf:conky` `apt:conky`
  - [Conky – The Fully Customizable System Monitor For Linux](https://www.linuxfordevices.com/tutorials/linux/conky-customizable-system-monitor#Installing-Conky), [lean-conky-config](https://github.com/jxai/lean-conky-config)
- redshift `dnf:redshift` `dnf:redshift-gtk` `apt:redshift` `apt:redshift-gtk`
  - The setup scripts write a starter `~/.config/redshift.conf`; set `lat`/`lon` to your location.
- Gnome extensions installed from [extensions.gnome.org](https://extensions.gnome.org) `manual`
  - gTile, Screenshot Tool, Search Light, Background Logo.

### Fonts

- Powerline fonts `dnf:powerline-fonts` `apt:fonts-powerline`
- Font Awesome `dnf:fontawesome-fonts` `apt:fonts-font-awesome`
- Fira Code `dnf:fira-code-fonts` `apt:fonts-firacode`
- Noto color emoji `dnf:google-noto-emoji-color-fonts` `apt:fonts-noto-color-emoji`

## Optional

- [shutter](https://shutter-project.org/): `dnf install shutter`. This is a screenshot tool. Note: Does not work on Wayland. Not recommended.
- [Notepadqq](https://notepadqq.com/s/) [source](https://github.com/notepadqq/notepadqq)
- [system-monitoring-center](https://github.com/hakandundar34coding/system-monitoring-center)
- [Blanket](https://github.com/rafaelmardojai/blanket): Ambient sounds.
- [SysMonTask](https://github.com/KrispyCamel4u/SysMonTask)
- [Plots](https://github.com/alexhuntley/Plots/)
- [drawing](https://github.com/maoschanz/drawing)
- [Guake Terminal](https://github.com/Guake/guake)
- [Black Box Terminal](https://gitlab.gnome.org/raggesilver/blackbox)
- [amberol](https://gitlab.gnome.org/World/amberol): sound and music player that is well integrated with GNOME.
- <https://xmonad.org/>
- <https://github.com/swaywm/sway>: `sudo dnf install sway`
- <https://github.com/Alexays/Waybar>
- <https://github.com/elkowar/eww>
- <https://sr.ht/~emersion/grim/>
- <https://github.com/natpen/awesome-wayland>
- [qtile](http://www.qtile.org/). [Source](https://github.com/qtile/qtile).
- [pop shell](https://github.com/pop-os/shell): `sudo dnf install gnome-shell-extension-pop-shell xprop`
