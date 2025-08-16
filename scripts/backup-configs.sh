#!/bin/bash
# Configuration Backup Script
# Creates timestamped backups of important configuration files

BACKUP_DIR="$HOME/config-backups/$(date +%Y%m%d_%H%M%S)"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "🗄️ Creating configuration backup in: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Function to backup file if it exists
backup_file() {
    local source="$1"
    local dest="$2"
    
    if [ -f "$source" ]; then
        echo "📄 Backing up: $source"
        mkdir -p "$(dirname "$BACKUP_DIR/$dest")"
        cp "$source" "$BACKUP_DIR/$dest"
    fi
}

# Function to backup directory if it exists
backup_dir() {
    local source="$1"
    local dest="$2"
    
    if [ -d "$source" ]; then
        echo "📁 Backing up: $source"
        mkdir -p "$(dirname "$BACKUP_DIR/$dest")"
        cp -r "$source" "$BACKUP_DIR/$dest"
    fi
}

# Shell configurations
backup_file "$HOME/.bashrc" "shell/bashrc"
backup_file "$HOME/.zshrc" "shell/zshrc"
backup_file "$HOME/.profile" "shell/profile"

# Editor configurations
backup_file "$HOME/.vimrc" "editors/vimrc"
backup_dir "$HOME/.config/nvim" "editors/nvim"
backup_file "$HOME/.emacs" "editors/emacs"
backup_dir "$HOME/.emacs.d" "editors/emacs.d"

# Terminal configurations
backup_dir "$HOME/.config/alacritty" "terminals/alacritty"
backup_file "$HOME/.config/starship.toml" "prompt/starship.toml"

# Development tools
backup_file "$HOME/.gitconfig" "git/gitconfig"
backup_dir "$HOME/.ssh" "ssh"

# VS Code (cross-platform locations)
if [[ "$OSTYPE" == "darwin"* ]]; then
    backup_dir "$HOME/Library/Application Support/Code/User" "vscode"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    backup_dir "$HOME/.config/Code/User" "vscode"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    backup_dir "$APPDATA/Code/User" "vscode"
fi

# Create manifest
echo "📋 Creating backup manifest..."
cat > "$BACKUP_DIR/MANIFEST.md" << EOF
# Configuration Backup Manifest

**Created**: $(date)
**System**: $(uname -a)
**User**: $(whoami)
**Backup Location**: $BACKUP_DIR

## Backed Up Items

$(find "$BACKUP_DIR" -type f -not -name "MANIFEST.md" | sort | sed "s|$BACKUP_DIR/|- |")

## Restore Instructions

To restore configurations:
1. Review backed up files before restoring
2. Use the restore script: \`bash scripts/restore-configs.sh "$BACKUP_DIR"\`
3. Or manually copy files to their original locations

EOF

echo "✅ Backup completed successfully!"
echo "📍 Backup location: $BACKUP_DIR"