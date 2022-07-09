# Configuration

## Enabling right mouse click option for a Synaptics mousepad

1. Open a terminal by pressing Ctrl+Alt+T and use the following command: `sudo nautilus`. This will open a window with sudo privileges and allow you to change and save root files.
2. Find and open the file: /usr/share/X11/xorg.conf.d/70-synaptics.conf
3. Locate the paragraph:

    ```plaintext
    # This option enables the bottom right corner to be a right button on clickpads
    # and the right and middle top areas to be right / middle buttons on clickpads
    # with a top button area.
    # This option is only interpreted by clickpads.
      Section "InputClass"
          Identifier "Default clickpad buttons"
          MatchDriver "synaptics"
          Option "SoftButtonAreas" "50% 0 82% 0 0 0 0 0"
          Option "SecondarySoftButtonAreas" "58% 0 0 15% 42% 58% 0 15%"
        EndSection
    ```

4. Add two extra lines before `Option "SoftButtonAreas" "50% 0 82% 0 0 0 0 0"` :

    ```plaintext
    Option "ClickPad"         "true"
    Option "EmulateMidButtonTime" "0"
    ```

   (first one enables right click and the second middle click)

5. Now save the changes and Log out/Log in. The right click should be working now!

[Reference](https://askubuntu.com/questions/579645/right-click-on-synaptic-touchpad-not-working-on-ubuntu-14-10)

On Wayland desktop enviroment:

- [ref](https://ask.fedoraproject.org/en/question/100632/touchpad-libinput-to-xorg-configuration-not-working/)
- [ref](http://www.ubuntuvibes.com/2017/04/how-to-configure-touchpad-in-ubuntu.html)
- [ref](https://bbs.archlinux.org/viewtopic.php?id=222883)
- [ref](https://www.topbug.net/blog/2017/02/23/enable-natural-scrolling-for-trackpads-using-libinput/)
- [ref](https://superuser.com/questions/1252871/migrate-from-x11-to-wayland-multitouch-on-fedora-25?newreg=0570eaa16b904c98a5d82a677c449d4e)

## Configuring GetDeb

Install the getdeb package.
Or configure the repository manually:
Go to System-Administration-Software Sources, Third-Party Software tab, Add:

```plaintext
deb http://archive.getdeb.net/ubuntu zesty-getdeb apps
```

Add the repository GPG key, open a terminal window and type:

```plaintext
wget -q -O- http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
```

If the application cannot be found, run this command and try again: `sudo apt-get update`.
If you want to uninstall the GetDeb repository run this command: `sudo apt-get remove getdeb-repository`.

[Reference](http://www.getdeb.net/updates/Ubuntu/17.04#how_to_install)

## Make battery last longer

TLP is Linux management power application, this application controls CPU temperature and this contributes to better control of battery life in long run. 

For installation and launching run: `sudo apt install tlp tlp-rdw && sudo tlp start`

[Reference](http://www.linuxandubuntu.com/home/15-things-to-do-after-installing-ubuntu-1704-zesty-zapus)

## Installing gnome on top of Ubuntu

```plaintext
sudo apt-get install ubuntu-gnome-desktop
```

*Then choose gdm3 or lightdm. Recommend to reboot.
If you need to change the login manager later on you can do that with `dpkg-reconfigure gdm3` or `dpkg-reconfigure lightdm` respectively.*

[Reference](https://askubuntu.com/questions/766071/install-gnome-shell-on-ubuntu-16-04?noredirect=1&lq=1)

## Removing Unity

```plaintext
sudo apt purge unity8 ubuntu-system-settings && sudo apt autoremove
```

## Stuck at login manager

[Reference](https://unix.stackexchange.com/questions/170650/ubuntu-does-no-let-me-log-in-to-my-user-how-can-i-fix-it)
