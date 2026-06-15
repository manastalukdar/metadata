# Fedora — Post-install Configuration

See also: [NVIDIA drivers](nvidia.md), [OneDrive](onedrive.md), [packages](packages.md).

## Enable RPM Fusion Repositories

```shell
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

## Add Flathub Repository

[Flatpak Setup](https://flatpak.org/setup/Fedora)

`flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo`

If you get the error, `While opening repository /var/lib/flatpak/repo: opendir(objects): No such file or directory`, run `sudo rm -r /var/lib/flatpak/repo`, and then re-run above `flatpak` command.

## Add Copr Repository

[ref](https://copr.fedorainfracloud.org)
[ref](https://docs.pagure.org/copr.copr/how_to_enable_repo.html#how-to-enable-repo)

```shell
dnf copr enable user/project
```

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

## Install Multimedia Plugins

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

- [Extensions Manager](https://github.com/mjakeman/extension-manager)
- Extensions:
  - gTile
  - Screenshot Tool
  - Search Light
  - Background Logo
  - Dash to Dock

## Install Fedy

[Fedy](https://github.com/rpmfusion-infra/fedy) can be used to install various third party software.

```shell
sudo dnf copr enable kwizart/fedy
sudo dnf install fedy -y
```

## Reduce Battery Usage

TLP is an alternative power management solution to the default GNOME power-profiles-daemon. It’s supposed to work better for laptops, and choosing to install TLP will require turning off power-profiles-daemon since they are conflicting.

```shell
sudo dnf install tlp tlp-rdw
sudo systemctl enable tlp
```

```shell
sudo dnf install tlp tlp-rdw
sudo dnf remove power-profiles-daemon
sudo systemctl enable tlp
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
```

## Fractional scaling

`gsettings set org.gnome.desktop.interface text-scaling-factor 1.5`

## Package maintenance

- Ensure all packages up-to-date: `sudo dnf upgrade --refresh`
- Remove old packages: `sudo dnf autoremove`
- `sudo dnf --refresh`
- `sudo flatpak update`
- `sudo dnf upgrade && sudo dnf update`
- Note: [Upgrading Fedora](https://www.linuxcapable.com/how-to-upgrade-fedora-release/)
- `sudo dnf install fedora-workstation-repositories`

## Enabling "Right Click -> Create new document"

[ref](https://askubuntu.com/questions/777711/create-new-document-right-click-option-missing-in-ubuntu-gnome)

```plaintext
See if you have ~/Templates folder2. Create one if it is missing using command:

mkdir ~/Templates

Now create an empty file from command prompt:1

touch ~/Templates/Text\ File.txt
```

## Removing applications in the app grid that are already uninstalled

[ref](https://www.reddit.com/r/gnome/comments/ko53pd/how_to_remove_applications_in_the_app_grid_that/)

```plaintext
/usr/share/applications/
$HOME/.local/share/applications/
$HOME/Desktop
```

## Troubleshooting and Known Issues

- Dual external monitors through a single USB-C hub does not work out of box. There seems to be some sort of issue with Wayland (X configuration is simpler, but you will have to first switch the default compositor to X. I am not planning to do that.). I am still investigating a solution with Wayland. As a workaround, please connect one of the external monitors directly to one of the USB-C ports on the laptop.
- MS Teams:
  - MS Teams screen sharing does not work when using the desktop app. Open Teams using your browser of choice to share screen.
  - Note that by default sharing the entire desktop/screen does not work even when using the web app. To get around this, enable WebRTC with pipewire on Chrome based browsers: `chrome://flags/#enable-webrtc-pipewire-capturer` in browser and change "WebRTC PipeWire support" to Enabled. [[ref](https://askubuntu.com/questions/1293394/screen-sharing-under-wayland#:~:text=Enabling%20WebRTC%20with%20pipewire%20works,WebRTC%20PipeWire%20support%22%20to%20Enabled)]
  - Background images and blurring not available on Linux.
  - Status does not automatically change from away to available.
- Keyboard and Mouse: Getting the Apple keyboard and mouse to work is not straight-forward. Recommend using a Windows keyboard and mouse as workaround.
- Conference room screens: On plugging in the display cable, scaling is not automatic. Manual configuration is needed. Not a deal-breaker, but something to be aware of.
- Unlike on a Mac, the OS does not wake up (after sleep/suspend) on using the external keyboard or mouse. You have to open the laptop lid, make sure the OS has awakened, and then put the lid down. The behavior may be different depending on the external USB-C hub used, and its firmware, etc.
  - Potential Solution: <https://askubuntu.com/a/874701/696087>. Have not been able to get it to work, _yet_.
- When bringing the laptop back and plugging it in, external monitors do not work immediately and of course the laptop itself does not wake up immediately. Need to open-close lid as described above. Also as previously mentioned, this likely has some solution, and the behavior may vary depending on firmware of the USB-C hub.
- On plugging back external monitors, windows go not revert back to previous positions. On Mac there are applications to enable this (stay, etc.).
  - Potential solution: <https://askubuntu.com/questions/411503/is-there-a-dynamic-multiple-monitor-friendly-desktop-environment-available-for-u>. Note: This is for X based compositor. Fedora defaults to Wayland.
- Multiple Github accounts: If you have a personal GitHub account and would like to push code to repositories, in say, work and personal accounts, there is no straightforward way to accomplish that yet. There is an open [issue](https://github.com/cli/cli/issues/326) on the GitHub CLI repo to make this happen. For now, here are some options:
  - Using SSH keys: [How to configure a local Git repository to use a specific SSH key](https://dev.to/web3coach/how-to-configure-a-local-git-repository-to-use-a-specific-ssh-key-4aml)
  - Using GitHub CLI aliases: <https://gist.github.com/manastalukdar/64eacff05d460524deea16b22cbc8660>
