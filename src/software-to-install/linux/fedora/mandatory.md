# Mandatory

## NVIDIA drivers

- Error: `Xxorg-x11-drv-nouveau Unexpected System Error`
- Confirm that NVIDIA drivers are not installed: `Dnf list --installed | grep nvidia`. [[ref](https://www.reddit.com/r/Fedora/comments/v1llpu/xxorgx11drvnouveau_unexpected_system_error/)]
- Install drivers: [[ref](https://rpmfusion.org/Howto/NVIDIA)]

    ```shell
    sudo dnf update -y # and reboot if you are not on the latest kernel
    sudo dnf install akmod-nvidia
    ```

- Error: `Nvidia kernel Module Missing. Falling back to Nouveau`
  - Solution: Disabling secure boot in bios. Restart + F2. [[ref](https://ask.fedoraproject.org/t/fedora-35-showing-nvidia-kernel-module-missing-on-boot/17346/14)] [[ref](https://www.reddit.com/r/Fedora/comments/poi03c/need_help_nvidia_kernel_module_missing_falling/)]
- Other: [[ref](https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/)] [[ref](https://www.linuxcapable.com/how-to-install-nvidia-drivers-on-fedora-36-linux/)].

## Enable RPM Fusion Repositories

```shell
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

## Add Flathub Repository

[Flatpak Setup](https://flatpak.org/setup/Fedora)

`flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo`

If you get the error, `While opening repository /var/lib/flatpak/repo: opendir(objects): No such file or directory`, run `sudo rm -r /var/lib/flatpak/repo`, and then re-run above `flatpak` command.

## Configure DNF for Faster Downloads of Packages

`sudo nano /etc/dnf/dnf.conf`

Then, append following lines to the file:

```plaintext
fastestmirror=true
deltarpm=true
max_parallel_downloads=10
```

Then, `Ctrl+o`, `CTRL+x`.

## Install snap

```shell
sudo dnf install snapd`
sudo ln -s /var/lib/snapd/snap /snap # to enable classic snap support
sudo snap refresh # to update all snap packages
```

## Multimedia

- [VLC Media Player](https://www.videolan.org/vlc/download-fedora.html)

    ```shell
    #$> su -
    > sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    > sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    > sudo dnf install vlc
    ```

- [Strawberry music player](https://www.strawberrymusicplayer.org/#repositories): `sudo dnf install strawberry`
- [pinta](https://www.pinta-project.com): Install snap using instruction above, then run `sudo snap install pinta`. To update, run: `sudo snap refresh pinta`.
- [ffmpeg](https://ffmpeg.org/) [[ref](https://computingforgeeks.com/how-to-install-ffmpeg-on-fedora/)]

    ```shell
    sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf -y install ffmpeg
    sudo dnf -y install ffmpeg-devel # optional
    ffmpeg -version
    ```

### Install Multimedia Plugins

To install media codecs, run:

```shell
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia
```

## Changing Hostname

`sudo hostnamectl set-hostname "new-name"`

## Gnome Tweaks and Gnome Extensions

- Gnome Tweaks: `sudo dnf install gnome-tweaks`
- [Gnome Extensions](https://extensions.gnome.org)
  - [Option 1](https://flathub.org/apps/details/org.gnome.Extensions)

    ```shell
    flatpak install flathub org.gnome.Extensions
    flatpak run org.gnome.Extensions
    ```

  - Option2 (recommended): `sudo dnf install gnome-extensions-app`
  - Installing specific extensions: The best way to install any specific extension is to install the (chrome) browser extension and then toggle the on/off switch when you go to a specific gnome extension page.

## Install Fedy

[Fedy](https://github.com/rpmfusion-infra/fedy) can be used to install various third party software.

```shell
sudo dnf copr enable kwizart/fedy
sudo dnf install fedy -y
```

## Reduce Battery Usage

```shell
sudo dnf install tlp tlp-rdw
sudo systemctl enable tlp
```

## OneDrive

Microsoft does not have an official Linux client for OneDrive. There is a pretty good open-source alternative.

- Install [OneDrive](https://github.com/abraunegg/onedrive): `sudo dnf install onedrive` [[ref](https://www.linuxuprising.com/2020/02/how-to-keep-onedrive-in-sync-with.html)]
  - [GUI for configuration management](https://github.com/bpozdena/OneDriveGUI)
  - [OneDrive Client for Linux System Tray Icon](https://github.com/DanielBorgesOliveira/onedrive_tray)

Note that OneDrive latest has not been updated in the dnf pkg repo. The one version older still works. If you want the latest and greatest, you can always build from source. The GUI for config management and tray icon add-ons do not work with the older version.

OneDrive:

```shell
onedrive --help
onedrive --synchronize --verbose --dry-run
onedrive --synchronize
systemctl --user enable onedrive
systemctl --user start onedrive
systemctl status --user onedrive
journalctl --user-unit onedrive -f
sudo systemctl restart SERVICE_NAME # to restart service
systemctl --user restart onedrive # to restart onedrive service
```

Tray icon:

```shell
sudo dnf install qtcreator
mkdir data/third-party-code/
cd data/third-party-code/
git clone https://github.com/DanielBorgesOliveira/onedrive_tray.git
cd onedrive_tray
mkdir build
cd build
qmake-qt5 ../systray.pro
make
sudo make install
systemctl enable --user onedrive_tray.service
systemctl start --user onedrive_tray.service
systemctl status --user onedrive_tray.service
```

## File Explorers

- [Double Commander](https://doublecommander.com) [[ref](https://software.opensuse.org/download.html?project=home%3AAlexx2000&package=doublecmd-gtk)]

    ```shell
    dnf config-manager --add-repo https://download.opensuse.org/repositories/home:Alexx2000/Fedora_36/home:Alexx2000.repo
    dnf install doublecmd-gtk
    ```

- [MuCommander](http://www.mucommander.com)

## Editors

- Visual Studio Code Insiders: Install snap using instruction above, then run `sudo snap install --classic code-insiders`. To update, run: `sudo snap refresh code-insiders`.
- [SublimeText](https://www.sublimetext.com/docs/linux_repositories.html#dnf)

    Strongly recommend going with the stable channel (unless you have a license).

    ```shell
    sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
    sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo # Stable channel
    sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/dev/x86_64/sublime-text.repo # Dev channel
    sudo dnf install sublime-text
    ```

- Geany: `sudo dnf install geany`
- [TexStudio](https://www.texstudio.org).
- [MikTex](https://miktex.org/download)

    ```shell
    sudo rpm --import "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xD6BC243565B2087BC3F897C9277A7293F59E4889"
    sudo curl -L -o /etc/yum.repos.d/miktex.repo https://miktex.org/download/fedora/35/miktex.repo
    sudo dnf update
    sudo dnf install miktex
    ```

## Git Related

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

## Office Utilities

- Document processing: Fedora comes with Libre Office.
- Outlook: Open outlook in your web browser, right click in the tab and install (PWA).

## Web Browsers

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

## Miscellaneous Utilities

- [polybar](https://github.com/polybar/polybar): `sudo dnf install polybar`
- [gTile](https://extensions.gnome.org/extension/28/gtile/) [[source code](https://github.com/gTile/gTile)]
- Blueman-manager: `sudo dnf install blueman`
- [Ulauncher](https://github.com/Ulauncher/Ulauncher/): `sudo dnf install ulauncher`
- Gnome Dock

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

- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh/wiki): `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
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

- Gnome Screenshot: `sudo dnf install gnome-screenshot`.
- [Screenshot Tool](https://extensions.gnome.org/extension/1112/screenshot-tool/) (gnome extensions based) [[source code](https://github.com/OttoAllmendinger/gnome-shell-screenshot/)]
- [Azure Storage Explorer](https://snapcraft.io/install/storage-explorer/fedora#install): Install snap using instruction above, then run `sudo snap install storage-explorer`. To update, run: `sudo snap refresh storage-explorer`.
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
- Fractional scaling: `gsettings set org.gnome.desktop.interface text-scaling-factor 1.5`
- `sudo dnf upgrade && sudo dnf update`

## Other

- `sudo dnf install fedora-workstation-repositories`

## Troubleshooting and Known Issues

- Dual external monitors through a single USB-C hub does not work out of box. There seems to be some sort of issue with Wayland (X configuration is simpler, but you will have to first switch the default compositor to X. I am not planning to do that.). I am still investigating a solution with Wayland. As a workaround, please connect one of the external monitors directly to one of the USB-C ports on the laptop.
- MS Teams:
  - MS Teams screen sharing does not work when using the desktop app. Open Teams using your browser of choice to share screen.
  - Background images and blurring not available on Linux.
  - Status does not automatically change from away to available.
- Keyboard and Mouse: Getting the Apple keyboard and mouse to work is not straight-forward. Recommend using a Windows keyboard and mouse as workaround.
- Conference room screens: On plugging in the display cable, scaling is not automatic. Manual configuration is needed. Not a deal-breaker, but something to be aware of.
- Unlike on a Mac, the OS does not wake up (after sleep/suspend) on using the external keyboard or mouse. You have to open the laptop lid, make sure the OS has awakened, and then put the lid down. The behavior may be different depending on the external USB-C hub used, and its firmware, etc.
  - Potential Solution: <https://askubuntu.com/a/874701/696087>. Have not been able to get it to work, _yet_.
- When bringing the laptop back and plugging it in, external monitors do not work immediately and of course the laptop itself does not wake up immediately. Need to open-close lid as described above. Also as previously mentioned, this likely has some solution, and the behavior may vary depending on firmware of the USB-C hub.
- On plugging back external monitors, windows go not revert back to previous positions. On Mac there are applications to enable this (stay, etc.).
  - Potential solution: <https://askubuntu.com/questions/411503/is-there-a-dynamic-multiple-monitor-friendly-desktop-environment-available-for-u>.
