# Mandatory

- Address bar in finder
  
  ```plaintext
  1) defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES && killall Finder
  2) View -> Show Path Bar OR alt + command + P
  Reference: https://superuser.com/questions/174297/how-can-i-get-an-address-bar-in-finder
  ```

- [Double Commander](https://doublecommander.com)
- [Rectangle](https://github.com/rxhanson/Rectangle)
- [Stay](https://cordlessdog.com/stay/)
- [kap](https://getkap.co)
- [iterm2](https://iterm2.com/)
- [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
- [Antidote](https://github.com/mattmc3/antidote)
- [AppCleaner](http://freemacsoft.net/appcleaner/)
- Pine media player
- [Lightshot](https://app.prntscr.com/en/index.html)
- [nvm](https://github.com/nvm-sh/nvm)
  
  ```shell
  nvm install node --reinstall-packages-from=node
  echo "node" > .nvmrc
  nvm use node
  nvm ls
  nvm versions
  ```

  [Installing Multiple Versions of Node.js Using nvm](https://www.sitepoint.com/quick-tip-multiple-versions-node-nvm/)

- [jenv](https://github.com/jenv/jenv)

  <https://github.com/AdoptOpenJDK/homebrew-openjdk>
  `/usr/libexec/java_home -V`

`brew list`, `brew cask list`, `brew leaves`, `port installed`

- JDK, java home, etc.:
  - <https://medium.com/notes-for-geeks/java-home-and-java-home-on-macos-f246cab643bd>
  - <https://mattshomepage.com/articles/2016/May/22/java_home_mac_os_x/>
