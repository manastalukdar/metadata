# Browsers

Web browsers.

Vivaldi and Edge are installed from their pre-release channels (snapshot / dev), which Flathub does not carry — hence the distro repos rather than a flatpak. See each OS `packages.md` for the repo setup. On CachyOS all three come from the AUR, so there is no repo setup at all.

## Mandatory

- Vivaldi Browser `dnf:vivaldi-snapshot` `apt:vivaldi-snapshot` `aur:vivaldi-snapshot` `cask:vivaldi`
- Microsoft Edge Dev `dnf:microsoft-edge-dev` `apt:microsoft-edge-dev` `aur:microsoft-edge-dev-bin` `cask:microsoft-edge@dev`
- Google Chrome `dnf:google-chrome-stable` `apt:google-chrome-stable` `aur:google-chrome` `cask:google-chrome`
- [Tor browser](https://www.torproject.org) `flatpak:org.torproject.torbrowser-launcher` `cask:tor-browser`

## Optional

- Opera Browser (for free VPN) `flatpak:com.opera.Opera` `cask:opera`
