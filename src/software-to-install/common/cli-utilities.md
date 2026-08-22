# CLI Utilities

Command-line tools and document/data processing utilities.

## Mandatory

- [RBQL](https://github.com/mechatroner/RBQL) `uv:rbql`
- [q](https://github.com/harelba/q) `brew:q`
  - No Arch or AUR package, and `setup-cachyos.sh` does not install Homebrew, so this is the one Mandatory tool CachyOS skips. [RBQL](https://github.com/mechatroner/RBQL) above covers the same "SQL over a CSV" job and comes from the `uv:` tier everywhere.
- [yq](https://github.com/mikefarah/yq) `brew:yq` `pacman:go-yq`
  - Arch calls it `go-yq` to distinguish it from the unrelated Python `yq`; the binary is still `yq`.
- [jq](https://github.com/stedolan/jq) `native:jq`
- Pandoc `dnf:pandoc` `apt:pandoc` `pacman:pandoc-cli` `brew-macos:pandoc`
  - Not `native:` because Arch split the Haskell library out and renamed the executable package to `pandoc-cli`.
- [Graphviz](https://graphviz.gitlab.io) `native:graphviz`
- [ripgrep](https://github.com/BurntSushi/ripgrep) `native:ripgrep`
- [fd](https://github.com/sharkdp/fd) `dnf:fd-find` `apt:fd-find` `pacman:fd` `brew-macos:fd`
  - The binary is `fdfind` on Debian/Ubuntu and Fedora, `fd` via Homebrew and on Arch.
- [fzf](https://github.com/junegunn/fzf) `native:fzf`
- [bat](https://github.com/sharkdp/bat) `native:bat`
  - The binary is `batcat` on Debian/Ubuntu.
- [lnav](https://lnav.org/) `native:lnav`
- [pass](https://www.passwordstore.org) `native:pass`

## Optional

- [sift](https://github.com/svent/sift)
- [glances](https://github.com/nicolargo/glances)
- [glogg](https://glogg.bonnefon.org/index.html)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) `native:yt-dlp`
