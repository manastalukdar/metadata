# Contributing Guide

Thank you for your interest in improving this metadata repository! This guide will help you contribute effectively.

## 🎯 Contribution Types

### Documentation Updates
- Fix broken links or outdated information
- Add new software tools and configurations
- Improve installation instructions
- Add troubleshooting solutions

### Configuration Improvements
- Update editor configurations with modern settings
- Add support for new tools and languages
- Improve cross-platform compatibility
- Optimize performance settings

### Automation Enhancements
- Improve setup scripts
- Add new platform support
- Enhance error handling
- Add verification steps

## 📋 Before Contributing

1. **Test your changes** on the target platform(s)
2. **Follow existing conventions** (file naming, structure, formatting)
3. **Update documentation** when adding new features
4. **Run health checks** to ensure nothing breaks

## 🔧 Development Setup

1. **Fork and clone**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/metadata.git
   cd metadata
   ```

2. **Create feature branch**:
   ```bash
   git checkout -b feature/your-improvement
   ```

3. **Test locally**:
   ```bash
   # Run version check
   bash scripts/check-versions.sh
   
   # Test relevant setup script
   bash scripts/setup-ubuntu.sh  # or your platform
   ```

## 📝 Contribution Guidelines

### File Organization
- **Configurations**: Place in `src/configurations/`
- **Installation guides**: Place in `src/software-to-install/`
- **Scripts**: Place in `scripts/`
- **Documentation**: Place in `docs/`

### Naming Conventions
- **Files**: Use lowercase with hyphens (`setup-ubuntu.sh`)
- **Directories**: Use lowercase with hyphens (`software-to-install`)
- **Scripts**: Use descriptive names (`backup-configs.sh`)

### Code Style
- **Shell scripts**: Use bash with `set -e`
- **Markdown**: Follow CommonMark specification
- **Configuration files**: Follow tool-specific conventions
- **Comments**: Include helpful explanations

### Cross-Platform Compatibility
- **Test on multiple platforms** when possible
- **Use environment variables** instead of hardcoded paths
- **Provide alternatives** for platform-specific tools
- **Document platform differences**

## 🧪 Testing Requirements

### Before Submitting
1. **Syntax validation**:
   ```bash
   # Check shell scripts
   shellcheck scripts/*.sh
   
   # Check markdown (if markdownlint is installed)
   markdownlint docs/*.md src/**/*.md
   ```

2. **Functional testing**:
   - Test installation commands on clean systems
   - Verify configuration files work with latest tool versions
   - Check that scripts handle errors gracefully

3. **Documentation verification**:
   - Ensure all links work
   - Verify code examples execute correctly
   - Check that instructions are complete

### Testing Checklist
- [ ] Scripts run without errors
- [ ] Configurations load properly
- [ ] Documentation is accurate
- [ ] Links are valid
- [ ] Cross-platform compatibility maintained

## 📤 Submission Process

1. **Create pull request**:
   - Use descriptive title
   - Link to related issues
   - Include testing information
   - Add screenshots if relevant

2. **Pull request template**:
   ```markdown
   ## Changes
   - Brief description of changes
   
   ## Testing
   - Platforms tested: Ubuntu 22.04, macOS 13
   - Test results: All scripts execute successfully
   
   ## Documentation
   - [ ] Updated relevant documentation
   - [ ] Added troubleshooting entries if needed
   - [ ] Updated index/navigation files
   ```

3. **Review process**:
   - Automated checks must pass
   - Manual review for functionality
   - Testing on different platforms
   - Documentation review

## 🎨 Style Guidelines

### Markdown
- Use **meaningful headings**
- Include **code examples** in fenced blocks
- Add **language tags** to code blocks
- Use **consistent emoji** for visual organization

### Shell Scripts
- Include **error handling** (`set -e`)
- Add **progress indicators** with echo statements
- Use **descriptive variable names**
- Include **usage examples** in comments

### Configuration Files
- Add **explanatory comments**
- Use **environment variables** where appropriate
- **Test with clean installations**
- **Document custom modifications**

## 🐛 Bug Reports

When reporting issues:

1. **Use issue templates**
2. **Include system information**:
   ```bash
   uname -a
   echo $SHELL
   echo $PATH
   ```
3. **Provide reproduction steps**
4. **Include error messages** (complete output)
5. **Suggest solutions** if you have ideas

## 💡 Feature Requests

When suggesting new features:

1. **Explain the use case**
2. **Research existing solutions**
3. **Consider maintenance burden**
4. **Provide implementation ideas**

## 🏷️ Versioning

This repository follows semantic versioning for major changes:
- **Major**: Breaking changes to script interfaces
- **Minor**: New tools or significant enhancements
- **Patch**: Bug fixes and minor updates

## 📊 Quality Standards

### Code Quality
- Scripts must be **idempotent** (safe to run multiple times)
- Error handling must be **comprehensive**
- Output must be **informative and helpful**
- Code must be **well-documented**

### Documentation Quality
- Instructions must be **complete and accurate**
- Examples must be **tested and working**
- Links must be **current and accessible**
- Format must be **consistent across files**

## 🤝 Community

### Getting Help
- Check existing documentation first
- Search issues for similar problems
- Ask questions in discussions
- Be specific about your environment

### Helping Others
- Answer questions in issues
- Improve documentation
- Share your configurations
- Report bugs you encounter

Thank you for contributing to make development environment setup easier for everyone! 🙏