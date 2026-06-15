# Metadata Repository Index

A comprehensive development environment setup and configuration repository.

## Quick Navigation

### 🚀 Quick Start
- [Setup Scripts](../scripts/) - Automated installation scripts
- [Essential Software](../src/software-to-install/common/) - Cross-platform tools by category
- [Platform Guides](#platform-specific-guides)

### 📁 Directory Structure

```
metadata/
├── docs/                           # Documentation and guides
├── scripts/                        # Automation scripts
└── src/
    ├── configurations/             # Application configurations
    │   ├── editors/               # Editor configs (vim, emacs, vscode)
    │   ├── shells/                # Shell configs (zsh, powershell)
    │   └── terminals/             # Terminal configs
    ├── development/               # Development notes and guides
    ├── software-to-install/       # Software installation guides
    └── tech-interview-prep/       # Interview preparation materials
```

## Platform-Specific Guides

See [software-to-install/README.md](../src/software-to-install/README.md) for the full structure and routing rules.

### 🌐 Cross-Platform
- [Common Tools](../src/software-to-install/common/) - Organized by function (languages, editors, AI tools, CLI utilities, etc.)

### 🐧 Linux
- [Ubuntu Setup](../scripts/setup-ubuntu.sh) (Automated)
- [Ubuntu Manual](../src/software-to-install/linux/ubuntu/)
- [Fedora Manual](../src/software-to-install/linux/fedora/)

### 🍎 macOS
- [macOS Setup](../scripts/setup-macos.sh) (Automated)
- [macOS Manual](../src/software-to-install/macos/)

### 🪟 Windows
- [Windows Manual](../src/software-to-install/windows/)

## Configuration Categories

### 👨‍💻 Editor Configurations
- [Neovim](../src/configurations/editors/vim/neovim/) - Modern Vim configuration
- [Emacs](../src/configurations/editors/emacs/) - Emacs configuration for Python development
- [VSCode](../src/configurations/editors/vscode/) - Visual Studio Code settings

### 🖥️ Terminal & Shell
- [Starship](../src/configurations/starship/) - Cross-platform prompt
- [PowerShell](../src/configurations/powershell/) - Modern PowerShell profile
- [Windows Terminal](../src/configurations/windows-terminal/) - Windows Terminal configuration

### 🏗️ Development Tools
- [Development Notes](../src/development/) - Publishing, source control, etc.
- [Android Development](../src/android/) - Android-specific guides

## Maintenance

### Updating Software Lists
1. Review and update version numbers quarterly
2. Test installation scripts on clean systems
3. Validate configuration files against latest tool versions
4. Update documentation links and references

### Contributing
1. Follow existing naming conventions
2. Test changes on target platforms
3. Update this index when adding new categories
4. Maintain cross-platform compatibility where possible

## Tools by Category

### Essential Development
- **Languages**: Java, Python, Node.js, Go, Rust
- **Version Control**: Git, GitHub CLI
- **Editors**: VSCode, Cursor, Neovim, Emacs
- **Terminals**: Windows Terminal, iTerm2, Alacritty

### Productivity
- **Notes**: Obsidian, Logseq, Notion
- **Design**: GIMP, Inkscape, Figma
- **Communication**: Slack, Telegram
- **Utilities**: Bruno, Postman, KeePass

### Specialized
- **Data Science**: Jupyter, Pandas, NumPy, TensorFlow
- **LaTeX**: TeXStudio, TexMaker, Pandoc
- **Multimedia**: VLC, DaVinci Resolve, OBS Studio