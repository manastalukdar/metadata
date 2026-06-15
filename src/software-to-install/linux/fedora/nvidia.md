# Fedora — NVIDIA Drivers

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

Note: (proprietary) NVIDIA drivers are not supported by the tiling window manager [sway](https://github.com/swaywm/sway), which is the top option for the Wayland compositor (which is what Fedora defaults to). So, if you want to use a tiling window manager:

- Switch to the open source [Nouveau](https://nouveau.freedesktop.org/) driver (which may lead to issues mentioned above).
- Use another tiling window manager. The options are limited on Wayland. Some alternatives are [river](https://github.com/riverwm/river), [qtile](https://github.com/qtile/qtile).
- Switch to Xorg and use [i3](https://i3wm.org/).

## Going back to Nvidia display drivers

```shell
sudo dnf remove \*nvidia\* --exclude=nvidia-gpu-firmware
sudo dnf install akmod-nvidia
```
