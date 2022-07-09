# Flashing, etc.

- Install adb
- Download twrp recovery into computer

 <https://twrp.me/asus/asusnexus72013wifi.html>

- Plug device into USB port. For `adb devices` to work, you may have to reboot into recovery. See next step.
- Install twrp recovery

  ```plaintext
  adb reboot bootloader
  fastboot flash recovery twrp.img
  fastboot reboot
  ```

- Reboot into twrp recovery.
- From computer copy rom and gaaps files into device.
- Use twrp to flash files.
- Reboot. This may reboot into twrt recovery, in which case reboot again into system.

## Links

1. <https://afiskon.github.io/how-to-restore-android.html>
2. <https://www.techrrival.com/flash-recovery-adb-fastboot/>
3. <https://www.androidrecovery.com/blog/install-use-adb-windows.html>
4. <https://forum.xda-developers.com/nexus-7-2013/orig-development/repartition-nexus-7-2013-repartition-t3844386>
