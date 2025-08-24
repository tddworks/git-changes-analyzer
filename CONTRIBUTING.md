# Contributing to Git Changes Analyzer

Thank you for your interest in contributing to Git Changes Analyzer! We welcome contributions from the community and are excited to work with you.

## 🤝 Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct. Please be respectful, inclusive, and constructive in all interactions.

## 🚀 Getting Started

### Prerequisites

Before contributing, make sure you have:
- Git installed and configured
- Bash 4.0 or higher
- A Unix-like environment (Linux, macOS, WSL)
- Basic understanding of shell scripting

### Development Environment Setup

1. **Fork the repository** on GitHub
2. **Clone your fork**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/git-changes-analyzer.git
   cd git-changes-analyzer
   ```
3. **Add upstream remote**:
   ```bash
   git remote add upstream https://github.com/tddworks/git-changes-analyzer.git
   ```
4. **Create a development branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## 📝 How to Contribute

### Types of Contributions

We welcome various types of contributions:

- 🐛 **Bug fixes** - Fix issues or improve reliability
- ✨ **New features** - Add new functionality
- 📚 **Documentation** - Improve or add documentation
- 🎨 **UI/UX improvements** - Enhance user experience
- ⚡ **Performance** - Optimize performance
- 🧪 **Tests** - Add or improve test coverage
- 🔧 **Refactoring** - Code improvements without changing functionality

### Before You Start

1. **Check existing issues** to see if your idea is already being worked on
2. **Open an issue** to discuss major changes before implementing
3. **Keep changes focused** - one feature or fix per pull request
4. **Follow our coding standards** (see below)

## 🛠️ Development Guidelines

### Code Style

- **Indentation**: Use 4 spaces (no tabs)
- **Line length**: Keep lines under 100 characters when possible
- **Comments**: Add comments for complex logic and functions
- **Variable names**: Use descriptive, lowercase names with underscores
- **Function names**: Use descriptive names with underscores

#### Example:
```bash
# Good
function analyze_commit_data() {
    local days=$1
    local author_filter=${2:-""}
    
    # Process git log data
    git log --since="$days days ago" --pretty=format:"%h|%an|%s"
}

# Avoid
function f() {
    # No comments, unclear purpose
    git log --since="$1 days ago"
}
```

### Testing

- Test your changes thoroughly on different scenarios
- Ensure the script works with various git repository states
- Test edge cases (empty repositories, no commits in time range)
- Verify color output works in different terminals

#### Manual Testing Checklist:
- [ ] Script runs without errors
- [ ] All menu options work correctly
- [ ] Command-line arguments function properly
- [ ] Colors display correctly
- [ ] Generated reports are properly formatted
- [ ] Error handling works as expected

### Documentation

- Update README.md if adding new features
- Add inline comments for complex logic
- Update help text if changing command-line options
- Include usage examples for new features

## 📋 Pull Request Process

### Before Submitting

1. **Sync with upstream**:
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Test thoroughly**:
   ```bash
   # Test basic functionality
   ./git-changes-analyzer.sh --summary
   
   # Test interactive mode
   ./git-changes-analyzer.sh
   ```

3. **Clean commit history**:
   ```bash
   # Squash related commits if needed
   git rebase -i HEAD~n
   ```

### Pull Request Template

When creating a pull request, please include:

```markdown
## Description
Brief description of the changes

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Testing
- [ ] I have tested these changes locally
- [ ] I have updated documentation as needed
- [ ] I have added tests that prove my fix is effective or that my feature works

## Screenshots (if applicable)
Add screenshots to help explain your changes

## Additional Notes
Any additional information about the implementation
```

### Review Process

1. **Automated checks** must pass
2. **Code review** by maintainers
3. **Testing** by reviewers
4. **Approval** and merge by maintainers

## 🐛 Bug Reports

When reporting bugs, please include:

### Bug Report Template
```markdown
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected behavior**
What you expected to happen.

**Environment:**
- OS: [e.g. macOS 12.0, Ubuntu 20.04]
- Bash version: [e.g. 5.0.17]
- Git version: [e.g. 2.30.0]
- Terminal: [e.g. iTerm2, GNOME Terminal]

**Additional context**
Add any other context about the problem here.
```

## ✨ Feature Requests

For feature requests, please include:

### Feature Request Template
```markdown
**Is your feature request related to a problem? Please describe.**
A clear description of what the problem is.

**Describe the solution you'd like**
A clear description of what you want to happen.

**Describe alternatives you've considered**
Other solutions you've considered.

**Additional context**
Any other context about the feature request.
```

## 📚 Documentation Guidelines

- Use clear, concise language
- Include code examples where helpful
- Keep formatting consistent
- Update table of contents if needed
- Test all code examples

## 🏷️ Commit Message Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
type(scope): description

[optional body]

[optional footer(s)]
```

### Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code changes that neither fix bugs nor add features
- `perf`: Performance improvements
- `test`: Adding or correcting tests
- `chore`: Maintenance tasks

### Examples:
```bash
feat(analysis): add support for custom date ranges
fix(menu): resolve input handling issue
docs(readme): update installation instructions
```

## 🚀 Release Process

For maintainers:

1. Update version numbers
2. Update CHANGELOG.md
3. Create release notes
4. Tag the release
5. Publish to GitHub

## 🙋 Getting Help

- **Documentation**: Check the [README](README.md) and [User Guide](GIT_ANALYZER_GUIDE.md)
- **Issues**: Search existing [GitHub Issues](https://github.com/tddworks/git-changes-analyzer/issues)
- **Discussions**: Join [GitHub Discussions](https://github.com/tddworks/git-changes-analyzer/discussions)
- **Contact**: Reach out to maintainers via email or GitHub

## 📄 License

By contributing to Git Changes Analyzer, you agree that your contributions will be licensed under the same Apache License 2.0 that covers the project.

---

Thank you for contributing to Git Changes Analyzer! 🎉