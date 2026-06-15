# Fedora — Packages

Fedora-specific software and native `dnf`/`copr`/`snap` install recipes. Cross-platform tools live under [../../common/](../../common/). For system setup (RPM Fusion, Flathub, codecs, etc.) see [post-install.md](post-install.md); for NVIDIA and OneDrive see [nvidia.md](nvidia.md) and [onedrive.md](onedrive.md).

## Mandatory

### Multimedia

- [VLC Media Player](https://www.videolan.org/vlc/download-fedora.html)

    ```shell
    #$> su -
    > sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    > sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    > sudo dnf install vlc
    ```

- [Strawberry music player](https://www.strawberrymusicplayer.org/#repositories): `sudo dnf install strawberry`
- [Moosync](https://github.com/Moosync/Moosync)

    ```
    dnf copr enable ovenoboyo/Moosync
    dnf install moosync
    ```

- [pinta](https://www.pinta-project.com): Install snap using instruction in [post-install.md](post-install.md), then run `sudo snap install pinta`. To update, run: `sudo snap refresh pinta`.
- [ffmpeg](https://ffmpeg.org/) [[ref](https://computingforgeeks.com/how-to-install-ffmpeg-on-fedora/)]

    ```shell
    sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf -y install ffmpeg
    sudo dnf -y install ffmpeg-devel # optional
    ffmpeg -version
    ```

### File Explorers

- [Double Commander](https://doublecommander.com) [[ref](https://software.opensuse.org/download.html?project=home%3AAlexx2000&package=doublecmd-gtk)]

    ```shell
    dnf config-manager --add-repo https://download.opensuse.org/repositories/home:Alexx2000/Fedora_36/home:Alexx2000.repo
    dnf install doublecmd-gtk
    ```

- [MuCommander](http://www.mucommander.com)

### Editors

- Visual Studio Code Insiders: Install snap using instruction in [post-install.md](post-install.md), then run `sudo snap install --classic code-insiders`. To update, run: `sudo snap refresh code-insiders`.
- [SublimeText](https://www.sublimetext.com/docs/linux_repositories.html#dnf)

    Strongly recommend going with the stable channel (unless you have a license).

    ```shell
    sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
    sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo # Stable channel
    sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/dev/x86_64/sublime-text.repo # Dev channel
    sudo dnf install sublime-text
    ```

- [TexStudio](https://www.texstudio.org).
- [MikTex](https://miktex.org/download)

    ```shell
    sudo rpm --import "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xD6BC243565B2087BC3F897C9277A7293F59E4889"
    sudo curl -L -o /etc/yum.repos.d/miktex.repo https://miktex.org/download/fedora/35/miktex.repo
    sudo dnf update
    sudo dnf install miktex
    ```

### Git Related

- [GitHub CLI](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)

    ```shell
    sudo dnf install 'dnf-command(config-manager)'
    sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
    sudo dnf install gh
    ```

- GitHub SSH Access

    ```shell
    $ description="$(id -un) ($(hostname -f))"
    $ ssh-keygen -t ed25519 -C "${description}"
    $ Generating public/private ed25519 key pair.
    Enter file in which to save the key ($HOME/.ssh/github): $HOME/.ssh/github
    ...
    $ eval "$(ssh-agent -s)"
    $ ssh-add $HOME/.ssh/github
    $ # enter passphrase
    $ gh auth refresh -h github.com -s admin:public_key
    ! First copy your one-time code: XXXX-XXXX
    Press Enter to open github.com in your browser...
    Opening in existing browser session.
    [69494:69494:0100/000000.661538:ERROR:sandbox_linux.cc(377)] InitializeSandbox() called with multiple threads in process gpu-process.

    ✓ Authentication complete.
    $ gh ssh-key add $HOME/.ssh/github.pub --title "${description}"
    ```

- [SublimeMerge](https://www.sublimemerge.com/docs/linux_repositories#dnf)

    Strongly recommend going with the stable channel (unless you have a license).

    ```shell
    sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
    sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo # Stable channel
    sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/dev/x86_64/sublime-text.repo # Dev channel
    sudo dnf install sublime-merge
    ```

- meld: `sudo dnf install meld`
- kdiff3: `sudo dnf install kdiff3`

### Office Utilities

- Document processing: Fedora comes with Libre Office.
- Outlook: Open outlook in your web browser, right click in the tab and install (PWA).

### Web Browsers

- [Edge Insiders](https://www.microsoftedgeinsider.com/en-us/download/)

    ```shell
    ## Setup
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
    ## Dev
    sudo mv /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo /etc/yum.repos.d/microsoft-edge-dev.repo
    ## Install
    sudo dnf install microsoft-edge-dev
    ## Beta
    sudo mv /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo /etc/yum.repos.d/microsoft-edge-beta.repo
    ## Install
    sudo dnf install microsoft-edge-beta
    ```

- Vivaldi browser (snapshots). [[ref](https://www.linuxcapable.com/how-to-install-vivaldi-browser-on-fedora-36-linux/)]

    ```shell
    sudo dnf upgrade --refresh -y
    sudo dnf install dnf-utils -y
    sudo dnf config-manager --add-repo https://repo.vivaldi.com/archive/vivaldi-fedora.repo
    sudo dnf install vivaldi-snapshot -y
    vivaldi --version
    ```

- Google Chrome. [[ref](https://itsfoss.com/install-google-chrome-fedora/)]

    ```shell
    sudo dnf install fedora-workstation-repositories
    sudo dnf config-manager --set-enabled google-chrome
    sudo dnf install google-chrome-stable
    ```

### Miscellaneous Utilities

- [polybar](https://github.com/polybar/polybar): `sudo dnf install polybar`
- [gTile](https://extensions.gnome.org/extension/28/gtile/) [[source code](https://github.com/gTile/gTile)]
  - Gnome extension
- [Search Light](https://github.com/icedman/search-light)
  - Gnome extension
- Blueman-manager: `sudo dnf install blueman`
- [Ulauncher](https://github.com/Ulauncher/Ulauncher/): `sudo dnf install ulauncher`
- Gnome Dock
  - Gnome extension

    [How to Bring out Bottom Dock Launcher from Activities View in Fedora Gnome 40](https://fostips.com/bring-out-bottom-dock-fedora-gnome/)

    ```shell
    sudo dnf install gnome-shell-extension-dash-to-dock
    sudo dnf install gnome-extensions-app
    ```

    Restart. Search for Extensions. When the Gnome Extensions App opens, find out and turn on ‘Dash to Dock’ which should show the dock immediately. The extension auto-hide the dock by default. If you want, click on “Settings” and configure this behavior. In addition, you can change the dock position, such as to left or right, change icon size and other settings as you prefer.

- [Terminator](https://github.com/gnome-terminator/terminator)

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

- openssh-askpass: `sudo dnf install openssh-askpass`
- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh/wiki): `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- [antibody](https://github.com/mattmc3/antidote)
- [antigen](https://github.com/zsh-users/antigen): `curl -L git.io/antigen > antigen.zsh`
- [peek](https://github.com/phw/peek): `sudo dnf install peek`. This is a gif screen recorder.
- [nvm](https://github.com/nvm-sh/nvm): `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash`
- [jenv](https://github.com/jenv/jenv)

    ```shell
    git clone https://github.com/jenv/jenv.git ~/.jenv
    # Shell: zsh
    echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(jenv init -)"' >> ~/.zshrc
    ```

- [pyenv](https://github.com/pyenv/pyenv)
- Gnome Font Viewer: `sudo dnf install gnome-font-viewer`
- NerdFonts

    Download desired font from [here](https://www.nerdfonts.com/font-downloads), then create `.fonts` directory under `/home/<username>` if it does not exist, and copy fonts to there, and run `fc-cache` from the terminal. [[ref](https://fedoramagazine.org/add-fonts-fedora/)]

- More fonts

  ```shell
  sudo dnf install powerline-fonts fontawesome-fonts
  sudo dnf install fira-code-fonts
  ```

- Gnome Screenshot: `sudo dnf install gnome-screenshot`.
- [Screenshot Tool](https://extensions.gnome.org/extension/1112/screenshot-tool/) (gnome extensions based) [[source code](https://github.com/OttoAllmendinger/gnome-shell-screenshot/)]
  - Gnome extension
- [Azure Storage Explorer](https://snapcraft.io/install/storage-explorer/fedora#install): Install snap using instruction in [post-install.md](post-install.md), then run `sudo snap install storage-explorer`. To update, run: `sudo snap refresh storage-explorer`.
- [Text Pieces](https://github.com/liferooter/textpieces): Quick text processing.
- pandoc: `sudo dnf install pandoc`.
- [conky](https://github.com/brndnmtthws/conky)

    ```shell
    sudo dnf install conky
    mkdir ~/Documents/conky
    touch ~/Documents/conky/conky.config
    mkdir ~/.config/conky
    sudo ifconfig
    lscpu
    nproc
    ls /sys/class/hwmon
    sudo cat /sys/class/hwmon/hwmon4/name
    cp -v ~/Documents/conky/conky.config ~/.config/conky
    ```

    [Conky – The Fully Customizable System Monitor For Linux](https://www.linuxfordevices.com/tutorials/linux/conky-customizable-system-monitor#Installing-Conky)
    [lean-conky-config](https://github.com/jxai/lean-conky-config)

- Thunderbird.
  - Dark Reader
  - ImportExportTools NG.
  - Markdown Here Revival.
  - Own for Exchange.
  - Thunderbird Conversations (disabled).
- Shortwave (Radio)
- Resources. [repo](https://github.com/nokyan/resources)

## Optional

- [kooha](https://github.com/SeaDve/Kooha). Screen recorder. Optional.
- [shutter](https://shutter-project.org/): `dnf install shutter`. This is a screenshot tool. Note: Does not work on Wayland. Not recommended.
- [Audacious media player](https://audacious-media-player.org/)
- [NotepadNext](https://github.com/dail8859/NotepadNext)
- [Notepadqq](https://notepadqq.com/s/) [source](https://github.com/notepadqq/notepadqq)
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
- <https://xmonad.org/>
- <https://github.com/swaywm/sway>: `sudo dnf install sway`
- <https://github.com/Alexays/Waybar>
- <https://github.com/elkowar/eww>
- <https://sr.ht/~emersion/grim/>
- <https://github.com/natpen/awesome-wayland>
- [qtile](http://www.qtile.org/). [Source](https://github.com/qtile/qtile).
- [pop shell](https://github.com/pop-os/shell): `sudo dnf install gnome-shell-extension-pop-shell xprop`
- [lnav](https://lnav.org/): `sudo snap install lnav`. [Source](https://github.com/tstack/lnav).
