# Terminals & Shells

Terminal emulators, shells, shell frameworks, and prompts.

## Mandatory

- Powershell Core `dnf:powershell` `apt:powershell` `brew-macos:powershell`
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) `manual`
  - Installed by the `setup-*.sh` scripts via the upstream installer; not packaged.
  - <https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.zip>
- [nushell](https://github.com/nushell/nushell) `brew:nushell`
  - Homebrew on every platform: Fedora packages it but apt does not, so one source keeps it consistent.
- [Terax terminal](https://terax.app) `cask:terax` `manual` - [code](https://github.com/crynta/terax-ai)
  - macOS is unattended via the `terax` cask, which pulls the vendor DMG.
  - Linux is a hand install: upstream publishes standalone `.deb`, `.rpm` and AppImage files per release but runs no apt or dnf repo, so there is nothing for those tiers to point at. Arch has `yay -S terax-bin`.
  - There is an npm package, `terax-ai`, but it is published from `R-Dson/terax-ai-npm-build` rather than by upstream — a third-party republish of the binary. Deliberately not tagged; prefer the vendor artifact and its published SHA256.

## Optional

- [Oh My Posh](https://ohmyposh.dev/docs)
- <https://github.com/romkatv/powerlevel10k>
- [Alacritty terminal emulator](https://alacritty.org). [source](https://github.com/alacritty/alacritty).
- Alacrity terminal
- <https://app.warp.dev>
- <https://github.com/fastfetch-cli/fastfetch>
- [Tabby](https://tabby.sh/) [code](https://github.com/eugeny/tabby)
- [Waveterm](https://www.waveterm.dev/) [code](https://github.com/wavetermdev/waveterm)
- [Ghostty](https://ghostty.org)
  - [Code](https://github.com/ghostty-org/ghostty)
- [starship](https://github.com/starship/starship) `mise:starship@latest`
  - <https://starship.rs/guide/>
  - <https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip>
  - VSCode: `terminal.integrated.fontFamily`: `FiraCode NF`
