# Writing & Publishing

Markdown editors, LaTeX/typesetting, long-form authoring, and desktop publishing.

## Mandatory

- Latex (MikTex on Windows) `dnf:texlive-scheme-medium` `apt:texlive-latex-extra` `apt:texlive-fonts-recommended` `pacman:texlive-basic` `pacman:texlive-latex` `pacman:texlive-latexextra` `pacman:texlive-fontsrecommended` `cask:mactex`
  - Swap in `texlive-scheme-full` / `texlive-full` / `texlive-meta` if you hit missing packages.
  - Arch has no scheme meta-packages, so the four collections above are the hand-rolled equivalent of Fedora's `medium` scheme.
  - Ubuntu

    ```plaintext
    sudo apt-get install texlive-full
    ```

    *After you installed texlive-full you can list all the installed language packs with dpkg -l texlive-lang-\*. Then you can remove the unneeded ones with sudo apt-get purge -y texlive-lang-... (where ... is the language).
    [Reference](https://tex.stackexchange.com/questions/372130/how-to-install-a-more-minimal-but-complete-texlive-on-ubuntu#comment919440_372130)*

- TexStudio `dnf:texstudio` `apt:texstudio` `pacman:texstudio` `cask:texstudio`
  - Ubuntu

    *May have to install libqt5scripts*

    ```plaintext
    sudo dpkg -i texstudio_*_amd64.deb
    sudo apt --fix-broken install
    ```

    <https://code.launchpad.net/~sunderme/+archive/ubuntu/texstudio>

    dark mode:

    - <https://github.com/thatlittleboy/TeXstudio-Qt-Stylesheet>
- [Typst](https://github.com/typst/typst) `mise:typst@latest`
  - [Typst](https://typst.app) official website

## Optional

- [MarkText](https://github.com/marktext/marktext)
- [Typora](https://typora.io)
- [TexMaker](https://www.xm1math.net/texmaker/)
- [Scribus](https://www.scribus.net)
- [skribisto](https://github.com/jacquetc/skribisto). Software for writers. Continuation of plume-creator.
- [novelWriter](https://novelwriter.io). [source](https://github.com/vkbo/novelWriter)
- [Stirling pdf](https://stirling.com/download) [code](https://github.com/Stirling-Tools/Stirling-PDF)
- [NotepadNext](https://github.com/dail8859/NotepadNext)

### Typst Editors

- [katvan](https://katvan.app/) [code](https://github.com/IgKh/katvan) `flatpak:app.katvan.Katvan`
- [typstify](https://typstify.com) [code](https://github.com/typstify/typstify) `manual`
- [typst-desktop](https://github.com/lucaslrodri/typst-desktop)
