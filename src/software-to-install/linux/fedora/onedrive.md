# Fedora — OneDrive

Microsoft does not have an official Linux client for OneDrive. There is a pretty good open-source alternative.

- Install [OneDrive](https://github.com/abraunegg/onedrive): `sudo dnf install onedrive` [[ref](https://www.linuxuprising.com/2020/02/how-to-keep-onedrive-in-sync-with.html)]
  - [GUI for configuration management](https://github.com/bpozdena/OneDriveGUI)
  - [OneDrive Client for Linux System Tray Icon](https://github.com/DanielBorgesOliveira/onedrive_tray)
- Alternatively onedrive may be install using linuxbrew: `brew install onedrive-cli`

Note that OneDrive latest has not been updated in the dnf pkg repo. The one version older still works. If you want the latest and greatest, you can always build from source. The GUI for config management and tray icon add-ons do not work with the older version.

OneDrive [ref](https://github.com/abraunegg/onedrive/blob/master/docs/USAGE.md#running-onedrive-as-a-system-service):

```shell
onedrive --help
onedrive --sync --verbose --dry-run -confdir '/home/manas/.config/onedrive/accounts/<email>'
onedrive --sync
systemctl --user enable onedrive
systemctl --user start onedrive
systemctl --user stop onedrive
systemctl status --user onedrive
journalctl --user-unit onedrive -f
sudo systemctl restart SERVICE_NAME # to restart service
systemctl --user restart onedrive # to restart onedrive service
```

`/usr/lib/systemd/user/onedrive.service`:

```plaintext
[Unit]
Description=OneDrive Free Client
Documentation=https://github.com/abraunegg/onedrive
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/home/linuxbrew/.linuxbrew/bin/onedrive --monitor --confdir="/home/manas/.config/onedrive/accounts/<email>"
Restart=on-failure
RestartSec=3

[Install]
WantedBy=default.target
```

To remove [[ref](https://superuser.com/questions/513159/how-to-remove-systemd-services)]:

```shell
systemctl stop [servicename]
systemctl disable [servicename]
rm /etc/systemd/system/[servicename]
rm /etc/systemd/system/[servicename] # and symlinks that might be related
rm /usr/lib/systemd/system/[servicename]
rm /usr/lib/systemd/system/[servicename] # and symlinks that might be related
systemctl daemon-reload
systemctl reset-failed
```

Adding additional OneDrive accounts [ref](https://github.com/abraunegg/onedrive/blob/master/docs/advanced-usage.md#configuring-the-client-to-use-multiple-onedrive-accounts--configurations):

```shell
mkdir ~/.config/onedrive-work
wget https://raw.githubusercontent.com/abraunegg/onedrive/master/config -O ~/.config/onedrive-work/config
# set sync_dir in config file to ~/OneDrive-work
onedrive --confdir="~/.config/onedrive-work"
onedrive --confdir="~/.config/onedrive-work" --display-config
onedrive --confdir="~/.config/onedrive-work" --sync --verbose --dry-run
onedrive --confdir="~/.config/onedrive-work" --sync
sudo cp /usr/lib/systemd/user/onedrive.service /usr/lib/systemd/user/onedrive-work.service
# Edit the new systemd file, updating the line beginning with ExecStart so that the confdir mirrors the one you used above:
# ExecStart=/usr/local/bin/onedrive --monitor --confdir="/full/path/to/config/dir"
#Example: ExecStart=/usr/local/bin/onedrive --monitor --confdir="/home/myusername/.config/onedrive-work"
systemctl --user enable onedrive-work
systemctl --user start onedrive-work
systemctl status --user onedrive-work
systemctl --user restart onedrive-work # to restart onedrive service
```

Adding Sharepoint shared libraries [ref](https://github.com/abraunegg/onedrive/blob/master/docs/SharePoint-Shared-Libraries.md):

```shell
onedrive --confdir="~/.config/onedrive-work" --get-O365-drive-id "<name of library>"
mkdir ~/.config/SharePoint_My_Library_Name
mkdir ~/SharePoint_My_Library_Name
wget https://raw.githubusercontent.com/abraunegg/onedrive/master/config -O ~/.config/SharePoint_My_Library_Name/config
# Update your 'onedrive' configuration file (~/.config/SharePoint_My_Library_Name/config) with the local folder where you will store your data: sync_dir = "~/SharePoint_My_Library_Name"
# Update your 'onedrive' configuration file(~/.config/SharePoint_My_Library_Name/config) with the 'drive_id' value obtained in the steps above: drive_id = "insert the drive_id value from above here"
onedrive --confdir="~/.config/SharePoint_My_Library_Name" --display-config
onedrive --confdir="~/.config/SharePoint_My_Library_Name" --sync --verbose --dry-run
onedrive --confdir="~/.config/SharePoint_My_Library_Name" --sync --verbose
sudo cp /usr/lib/systemd/user/onedrive.service /usr/lib/systemd/user/onedrive-SharePoint_My_Library_Name.service
# Edit the new systemd file, updating the line beginning with ExecStart so that the confdir mirrors the one you used above:
# ExecStart=/usr/local/bin/onedrive --monitor --confdir="/home/myusername/.config/SharePoint_My_Library_Name"
systemctl --user enable onedrive-SharePoint_My_Library_Name
systemctl --user start onedrive-SharePoint_My_Library_Name
systemctl status --user onedrive-SharePoint_My_Library_Name
systemctl --user restart onedrive-SharePoint_My_Library_Name # to restart onedrive service
```

Note: You may have to do a synchronize with --reauth if your token has expired.

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
systemctl disable --user onedrive_tray.service
```
