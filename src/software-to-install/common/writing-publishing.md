# Writing & Publishing

Markdown editors, LaTeX/typesetting, long-form authoring, and desktop publishing.

## Mandatory

- Latex (MikTex on Windows)
  - Ubuntu

    ```plaintext
    sudo apt-get install texlive-full
    ```

    *After you installed texlive-full you can list all the installed language packs with dpkg -l texlive-lang-\*. Then you can remove the unneeded ones with sudo apt-get purge -y texlive-lang-... (where ... is the language).
    [Reference](https://tex.stackexchange.com/questions/372130/how-to-install-a-more-minimal-but-complete-texlive-on-ubuntu#comment919440_372130)*

- TexStudio
  - Ubuntu

    *May have to install libqt5scripts*

    ```plaintext
    sudo dpkg -i texstudio_*_amd64.deb
    sudo apt --fix-broken install
    ```

    <https://code.launchpad.net/~sunderme/+archive/ubuntu/texstudio>

    dark mode:

    - <https://github.com/thatlittleboy/TeXstudio-Qt-Stylesheet>

## Optional

- MarkText
- [MarkText](https://github.com/marktext/marktext)
- [Typora](https://typora.io)
- [TexMaker](https://www.xm1math.net/texmaker/)
- [Scribus](https://www.scribus.net)
- [skribisto](https://github.com/jacquetc/skribisto). Software for writers. Continuation of plume-creator.
- [novelWriter](https://novelwriter.io). [source](https://github.com/vkbo/novelWriter)
