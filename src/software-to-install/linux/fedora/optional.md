# Optional

- [kooha](https://github.com/SeaDve/Kooha). Screen recorder. Optional.
- [shutter](https://shutter-project.org/): `dnf install shutter`. This is a screenshot tool. Note: Does not work on Wayland. Not recommended.
- [Audacious media player](https://audacious-media-player.org/)

    ```shell
    sudo dnf install audacious
    sudo dnf install audacious-plugins-freeworld
    ```

- [NotepadNext](https://github.com/dail8859/NotepadNext)
- [system-monitoring-center](https://github.com/hakandundar34coding/system-monitoring-center)
- [Blanket](https://github.com/rafaelmardojai/blanket): Ambient sounds.
- [SysMonTask](https://github.com/KrispyCamel4u/SysMonTask)
- [Plots](https://github.com/alexhuntley/Plots/)
- [drawing](https://github.com/maoschanz/drawing)
- [Geany](https://www.geany.org): `sudo dnf install geany`
- [Guake Terminal](https://github.com/Guake/guake)
- [Black Box Terminal](https://gitlab.gnome.org/raggesilver/blackbox)
- [amberol](https://gitlab.gnome.org/World/amberol): sound and music player that is well integrated with GNOME.
- [pass](https://www.passwordstore.org): `sudo dnf install pass`.
- [Git Credential Manager](https://github.com/GitCredentialManager/git-credential-manager/blob/main/docs/credstores.md)

  ```shell
  Download the latest [tarball](https://github.com/GitCredentialManager/git-credential-manager/releases/latest), and run the following:

  tar -xvf <path-to-tarball> -C /usr/local/bin
  git-credential-manager-core configure
  
  To uninstall:

  git-credential-manager-core unconfigure
  rm $(command -v git-credential-manager-core)
  ```

- <https://xmonad.org/>
- <https://github.com/swaywm/sway>: `sudo dnf install sway`
  - [[ref](https://computingforgeeks.com/setup-sway-tiling-window-manager-on-fedora-with-waybar/)] [[ref](https://thomas-leister.de/sway-window-manager/)] [[ref](https://www.techjunkie.com/tiling-window-managers/)] [[ref](https://www.greghilston.com/post/tiling-window-managers/)] [[ref](https://www.reddit.com/r/swaywm/comments/sphp7b/a_quick_look_to_sway_wm_with_nvidias_drivers/)]
- <https://github.com/Alexays/Waybar>
- <https://sr.ht/~emersion/grim/>
- <https://github.com/natpen/awesome-wayland>
- [qtile](http://www.qtile.org/). [Source](https://github.com/qtile/qtile).

  [Installing from source](http://docs.qtile.org/en/stable/manual/install/index.html#installing-from-source).
  [Installing from copr repo](https://copr.fedorainfracloud.org/coprs/frostyx/qtile/):

  ```shell
  dnf copr enable frostyx/qtile
  dnf install qtile
  dnf install qtile-extras
  ```
