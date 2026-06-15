# Development Environment Metadata

> A comprehensive collection of development environment configurations, software installation guides, and automation scripts for cross-platform development setup.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform Support](https://img.shields.io/badge/Platform-Windows%20%7C%20macOS%20%7C%20Linux-blue)]()
[![Maintenance](https://img.shields.io/badge/Maintained-Yes-green.svg)]()

## 🚀 Quick Start

### One-Command Setup

**Ubuntu/Debian:**
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/manastalukdar/metadata/main/scripts/setup-ubuntu.sh)
```

**Fedora:**
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/manastalukdar/metadata/main/scripts/setup-fedora.sh)
```

**macOS:**
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/manastalukdar/metadata/main/scripts/setup-macos.sh)
```

### Development Containers

**VS Code DevContainer:**
1. Open repository in VS Code
2. Install "Dev Containers" extension
3. Use Command Palette: "Dev Containers: Reopen in Container"

**GitHub Codespaces:**
1. Click "Code" → "Codespaces" → "Create codespace on main"
2. Wait for automated setup

## 📁 Repository Structure

```
metadata/
├── 📚 docs/                    # Comprehensive documentation
│   ├── INDEX.md               # Complete navigation guide
│   ├── QUICK_START.md         # Fast onboarding
│   ├── TROUBLESHOOTING.md     # Problem-solving guide
│   ├── MAINTENANCE.md         # Update procedures
│   └── CONTRIBUTING.md        # Contribution guidelines
├── 🤖 scripts/                # Automation scripts
│   ├── setup-*.sh             # Platform-specific setup
│   ├── backup-configs.sh      # Configuration backup
│   ├── restore-configs.sh     # Configuration restore
│   ├── update-all.sh          # Universal updater
│   └── check-versions.sh      # Health check
├── 🐳 .devcontainer/          # VS Code DevContainer config
├── ☁️ .github/codespaces/     # GitHub Codespaces config
└── 📂 src/
    ├── configurations/        # Application configurations
    │   ├── editors/           # Vim, Emacs, VSCode
    │   ├── starship/          # Shell prompt
    │   ├── powershell/        # PowerShell profile
    │   └── windows-terminal/  # Windows Terminal
    ├── software-to-install/   # Installation guides
    │   ├── common/           # Cross-platform tools, by category
    │   ├── linux/            # Linux-specific (Ubuntu, Fedora)
    │   ├── macos/            # macOS-specific
    │   └── windows/          # Windows-specific
    ├── development/          # Development notes
    └── tech-interview-prep/  # Interview materials
```

## 🛠️ What's Included

### Core Development Tools
- **Languages**: Java 21+, Python 3.11+, Node.js LTS, Go, Rust
- **Editors**: VS Code, Cursor, Neovim, Emacs, Sublime Text
- **Version Control**: Git, GitHub CLI
- **Package Managers**: npm, pip, SDKman, Homebrew
- **Containers**: Docker, Podman

### Shell & Terminal
- **Prompts**: Starship (cross-platform)
- **Shells**: Bash, Zsh, PowerShell
- **Terminals**: Windows Terminal, iTerm2, Alacritty
- **Multiplexers**: tmux, screen

### Productivity Tools
- **Notes**: Obsidian, Logseq, Notion
- **API Testing**: Bruno, Postman, Insomnia
- **Design**: GIMP, Inkscape, Figma
- **Security**: KeePass, 1Password

## 📖 Documentation

| Guide | Description |
|-------|-------------|
| [📋 INDEX](docs/INDEX.md) | Complete navigation and overview |
| [⚡ QUICK_START](docs/QUICK_START.md) | Fast setup and onboarding |
| [🔧 TROUBLESHOOTING](docs/TROUBLESHOOTING.md) | Common issues and solutions |
| [🔄 MAINTENANCE](docs/MAINTENANCE.md) | Keeping configs up-to-date |
| [🤝 CONTRIBUTING](docs/CONTRIBUTING.md) | How to contribute |

## 🎯 Use Cases

- **New machine setup** - Get productive quickly on any platform
- **Team onboarding** - Consistent development environments
- **Configuration backup** - Safe storage of your customizations
- **Tool discovery** - Find new development tools and utilities
- **Cross-platform workflow** - Work seamlessly across different OS

## 🔧 Maintenance

### Keep Your Environment Updated
```bash
# Check what's installed
bash scripts/check-versions.sh

# Update everything
bash scripts/update-all.sh

# Backup configurations before major changes
bash scripts/backup-configs.sh
```

### Health Monitoring
- **Monthly**: Security updates and cleanup
- **Quarterly**: Tool version updates and testing
- **Annually**: Major version upgrades and audits

## 🐳 Container Development

This repository includes modern development container configurations:

- **DevContainer** for VS Code with pre-configured tools
- **GitHub Codespaces** for cloud-based development
- **Automated setup** with post-create scripts
- **Port forwarding** for web development

## 📝 VSCode Extensions Management

### Updating Extensions List

1. Export extensions: Use VS Code Sync or Settings Sync
2. Filter by publisher: Use [JSON Editor Online](https://jsoneditoronline.org/)
3. Update: Modify [`src/configurations/editors/vscode/extensions.json`](src/configurations/editors/vscode/extensions.json)

### Recommended Extensions
See [extensions.json](src/configurations/editors/vscode/extensions.json) for the complete curated list including:
- Language support (Python, TypeScript, Go, Rust)
- AI assistance (GitHub Copilot, Claude Dev)
- Git integration (GitLens, GitHub PR)
- Productivity tools (REST Client, Live Server)

## 🤝 Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](docs/CONTRIBUTING.md) for guidelines.

### Quick Contribution Steps
1. Fork the repository
2. Create a feature branch
3. Test your changes on target platforms
4. Submit a pull request with detailed description

## 🆘 Support

- **Documentation**: Check [docs/](docs/) directory
- **Issues**: Use GitHub Issues for bug reports
- **Discussions**: Use GitHub Discussions for questions
- **Troubleshooting**: See [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)

## 📈 Stats

- **Platforms Supported**: 3 (Windows, macOS, Linux)
- **Automation Scripts**: 7
- **Configuration Files**: 15+
- **Software Tools Covered**: 100+

## 🙏 Acknowledgments

Thanks to the open-source community for creating the amazing tools and configurations that make development enjoyable and productive.

## 📄 License

[MIT License](LICENSE) - Feel free to use, modify, and distribute.
