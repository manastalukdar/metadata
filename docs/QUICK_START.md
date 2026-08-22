# Quick Start Guide

Get your development environment up and running quickly with automated scripts and essential configurations.

## 🚀 One-Command Setup

Choose your platform and run the appropriate script:

### Linux (Ubuntu)
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/manastalukdar/metadata/main/scripts/setup-ubuntu.sh)
```

### Linux (Fedora)
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/manastalukdar/metadata/main/scripts/setup-fedora.sh)
```

### Linux (CachyOS / Arch)
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/manastalukdar/metadata/main/scripts/setup-cachyos.sh)
```

Run as your normal user, not `sudo`: AUR packages cannot be built as root.

### macOS
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/manastalukdar/metadata/main/scripts/setup-macos.sh)
```

## 🔧 Manual Setup

If you prefer manual installation or want to customize:

1. **Clone this repository**:
   ```bash
   git clone https://github.com/manastalukdar/metadata.git
   cd metadata
   ```

2. **Choose your approach**:
   - **Automated**: Run platform script from `scripts/` directory
   - **Manual**: Follow guides in `src/software-to-install/`
   - **Selective**: Pick specific tools from category lists

## 📋 Essential Tools Checklist

After setup, verify these core tools are installed:

```bash
# Development essentials
java --version      # Java 21+
python3 --version   # Python 3.11+
node --version      # Node.js LTS
git --version       # Git

# Optional but recommended
code --version      # VS Code
gh --version        # GitHub CLI
```

## 🎯 Next Steps

1. **Configure Git**:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

2. **Set up SSH keys** (for GitHub/GitLab):
   ```bash
   ssh-keygen -t ed25519 -C "your.email@example.com"
   cat ~/.ssh/id_ed25519.pub  # Add this to your GitHub/GitLab account
   ```

3. **Install editor configurations**:
   - Copy configurations from `src/configurations/editors/`
   - Customize based on your preferences

4. **Set up shell prompt** (optional — no prompt is installed by default, but both configs are kept in this repo):
   ```bash
   # Starship — install it first, e.g. `mise use -g starship@latest`
   mkdir -p ~/.config
   cp src/configurations/starship/starship.toml ~/.config/
   echo 'eval "$(starship init zsh)"' >> ~/.zshrc

   # ...or Oh My Posh
   cp src/configurations/oh-my-posh/.mytheme.omp.json ~/
   echo 'eval "$(oh-my-posh init zsh --config ~/.mytheme.omp.json)"' >> ~/.zshrc
   ```

   See [terminals-shells.md](../src/software-to-install/common/terminals-shells.md) for the prompt options.

## 🐳 Development Containers

For consistent development environments:

### VS Code DevContainer
1. Open repository in VS Code
2. Install "Dev Containers" extension
3. Use Command Palette: "Dev Containers: Reopen in Container"

### GitHub Codespaces
1. Open repository on GitHub
2. Click "Code" → "Codespaces" → "Create codespace on main"
3. Wait for automated setup to complete

## 📚 Additional Resources

- [Full Index](INDEX.md) - Complete navigation guide
- [Troubleshooting](TROUBLESHOOTING.md) - Common issues and solutions
- [Maintenance Guide](MAINTENANCE.md) - Keeping configurations up-to-date

## 💡 Tips

- **Backup first**: Run `scripts/backup-configs.sh` before major changes
- **Test scripts**: Try setup scripts in a virtual machine first
- **Stay updated**: Review and update tool versions quarterly
- **Customize**: Adapt configurations to your workflow and preferences

## 🆘 Getting Help

If you encounter issues:
1. Check [Troubleshooting Guide](TROUBLESHOOTING.md)
2. Search tool-specific documentation
3. Create an issue with detailed error information