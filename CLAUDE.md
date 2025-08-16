# Claude Code Integration Guide

This file provides context and instructions for working with this metadata repository using Claude Code.

## 🎯 Repository Purpose

This is a **development environment metadata repository** containing:
- Cross-platform software installation guides
- Editor and shell configurations
- Automation scripts for environment setup
- Development notes and best practices

## 📂 Key Directories

### `/scripts/` - Automation Scripts
- `setup-*.sh` - Platform-specific automated setup scripts
- `backup-configs.sh` - Backup user configurations
- `restore-configs.sh` - Restore configurations from backup
- `update-all.sh` - Update all installed tools
- `check-versions.sh` - Health check and version verification

### `/src/configurations/` - Application Configs
- `editors/` - Vim, Emacs, VSCode configurations
- `starship/` - Cross-platform shell prompt configuration  
- `powershell/` - PowerShell profile with modern features
- `windows-terminal/` - Windows Terminal JSON configuration

### `/src/software-to-install/` - Installation Guides
- `any-os/` - Cross-platform tools (Java, Python, Node.js, etc.)
- `linux/` - Linux distributions (Ubuntu, Fedora)
- `mac-os/` - macOS-specific software
- `windows/` - Windows-specific software

### `/docs/` - Documentation
- `INDEX.md` - Complete navigation guide
- `QUICK_START.md` - Fast onboarding instructions
- `TROUBLESHOOTING.md` - Common issues and solutions
- `MAINTENANCE.md` - Update and maintenance procedures
- `CONTRIBUTING.md` - Contribution guidelines

## 🔧 Common Tasks

### Adding New Software
1. **Research** the tool and verify it's stable/maintained
2. **Add to appropriate category** in `src/software-to-install/`
3. **Include installation commands** for each supported platform
4. **Test installation** on target platforms
5. **Update automation scripts** if the tool should be included in default setups
6. **Document any configuration** needed in `src/configurations/`

### Updating Configurations
1. **Backup existing configs** using `scripts/backup-configs.sh`
2. **Test changes** in isolated environments first
3. **Ensure cross-platform compatibility** where applicable
4. **Update documentation** if behavior changes
5. **Verify with health check** using `scripts/check-versions.sh`

### Script Maintenance
1. **Test scripts** on clean systems/containers
2. **Handle errors gracefully** with proper exit codes
3. **Provide informative output** for user feedback
4. **Make scripts idempotent** (safe to run multiple times)
5. **Update version numbers** as tools are updated

## 🚨 Important Considerations

### Security
- **Never commit secrets** or personal information
- **Review scripts carefully** before execution
- **Use HTTPS URLs** instead of HTTP when possible
- **Validate downloads** with checksums when available

### Cross-Platform Compatibility
- **Test on multiple platforms** when making changes
- **Use environment variables** instead of hardcoded paths
- **Provide platform-specific alternatives** when needed
- **Document platform differences** clearly

### Maintenance
- **Update tool versions** quarterly
- **Test setup scripts** on clean environments
- **Monitor for deprecated tools** and provide alternatives
- **Keep documentation current** with tool changes

## 🎛️ Claude Code Specific Instructions

### When Working on Installation Guides
- **Always test installation commands** before suggesting them
- **Check for the latest stable versions** of tools
- **Provide verification steps** after installation
- **Include troubleshooting** for common issues

### When Updating Scripts
- **Run syntax checks** on shell scripts
- **Test error handling** paths
- **Verify permissions** are set correctly (`chmod +x`)
- **Check for platform detection** logic

### When Modifying Configurations
- **Understand the tool's configuration format** first
- **Preserve user customizations** where possible
- **Test with clean installations** of the target tool
- **Document any breaking changes**

## 🔍 Useful Commands

### Repository Health Check
```bash
# Check all tool versions
bash scripts/check-versions.sh

# Update everything
bash scripts/update-all.sh

# Backup current configurations
bash scripts/backup-configs.sh
```

### Development Workflow
```bash
# Test Ubuntu setup in container
docker run -it ubuntu:22.04 bash
# Then run: curl -fsSL https://raw.githubusercontent.com/manastalukdar/metadata/main/scripts/setup-ubuntu.sh | bash

# Check script syntax
shellcheck scripts/*.sh

# Validate markdown
markdownlint docs/*.md src/**/*.md
```

## 📋 Task Templates

### Adding New Tool
1. Research tool (stability, maintenance, adoption)
2. Add to appropriate markdown file in `src/software-to-install/`
3. Include installation commands for all supported platforms
4. Test installation on clean systems
5. Consider adding to automation scripts
6. Update INDEX.md if it's a new category

### Updating Existing Tool
1. Check current version in installation guides
2. Research latest stable version
3. Update installation commands
4. Test on target platforms
5. Update any related configurations
6. Run health check to verify

### Script Enhancement
1. Identify improvement area (error handling, features, etc.)
2. Implement changes with proper testing
3. Verify cross-platform compatibility
4. Update documentation if behavior changes
5. Test with `scripts/check-versions.sh`

## 💡 Best Practices

- **Always backup** before major changes
- **Test changes** in isolated environments
- **Document your reasoning** for tool choices
- **Consider maintenance burden** of new additions
- **Keep security in mind** for all installations
- **Maintain backward compatibility** when possible

## 🔗 Related Files

- [Main README](README.md) - Repository overview
- [Contributing Guide](docs/CONTRIBUTING.md) - Detailed contribution instructions
- [Troubleshooting](docs/TROUBLESHOOTING.md) - Problem-solving help