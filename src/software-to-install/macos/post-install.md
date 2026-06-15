# macOS — Post-install Configuration

## Address bar in Finder

```plaintext
1) defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES && killall Finder
2) View -> Show Path Bar OR alt + command + P
Reference: https://superuser.com/questions/174297/how-can-i-get-an-address-bar-in-finder
```

## Homebrew listing

`brew list`, `brew cask list`, `brew leaves`, `port installed`
