# Git Changes Analyzer 📊

[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Bash Version](https://img.shields.io/badge/bash-%3E%3D4.0-blue)](https://www.gnu.org/software/bash/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

An interactive command-line tool for analyzing Git repository changes, generating reports, and gaining insights into your codebase evolution.

## ✨ Features

- **📈 Commit Analytics** - Comprehensive commit statistics and summaries
- **👥 Author Insights** - Detailed breakdown of contributions by author
- **📁 File Hotspots** - Identify frequently modified files
- **🏷️ Commit Type Analysis** - Analyze conventional commit patterns
- **🔍 Detailed Commit Viewer** - Deep dive into specific commits
- **📄 Report Generation** - Export analysis to markdown format
- **⏱️ Flexible Time Ranges** - Analyze any time period
- **🔄 Live Updates** - Refresh git data on demand

## 🚀 Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/tddworks/git-changes-analyzer.git
cd git-changes-analyzer

# Make the script executable
chmod +x git-changes-analyzer.sh

# Optional: Add to PATH for global access
sudo ln -s $(pwd)/git-changes-analyzer.sh /usr/local/bin/git-analyzer
```

### Basic Usage

```bash
# Interactive mode (recommended)
./git-changes-analyzer.sh

# Quick summary of today's changes
./git-changes-analyzer.sh --summary

# Generate a report for the last 7 days
./git-changes-analyzer.sh --days 7 --report

# Show help
./git-changes-analyzer.sh --help
```

## 📖 Documentation

### Interactive Menu Options

| Option | Description | Use Case |
|--------|-------------|----------|
| **1. Summary** | Overall repository statistics | Daily standup, quick overview |
| **2. By Author** | Commits grouped by contributor | Team performance, code review |
| **3. File Changes** | Most frequently modified files | Identify technical debt, hotspots |
| **4. Commit Types** | Distribution of feat/fix/docs | Process compliance, quality metrics |
| **5. Commit Details** | Examine specific commits | Debugging, detailed investigation |
| **6. Generate Report** | Export to markdown | Documentation, team meetings |
| **7. Change Time Range** | Adjust analysis period | Sprint reviews, custom periods |
| **8. Refresh** | Update git data | Sync with remote changes |
| **9. Quit** | Exit the program | - |

### Command Line Options

```bash
git-changes-analyzer.sh [OPTIONS]

Options:
  --help, -h        Show help message
  --days N          Analyze last N days (default: 1)
  --summary         Show summary and exit
  --report          Generate report and exit
```

### Examples

#### Daily Standup Report
```bash
# What did the team do yesterday?
./git-changes-analyzer.sh --days 1 --summary
```

#### Weekly Sprint Review
```bash
# Interactive analysis for sprint review
./git-changes-analyzer.sh --days 7
# Then select option 6 to generate report
```

#### Individual Contributor Analysis
```bash
# Use interactive mode
./git-changes-analyzer.sh
# Select option 2 to see commits by author
```

#### Technical Debt Identification
```bash
# Find files that need refactoring
./git-changes-analyzer.sh
# Select option 3 to see most changed files
```

## 🎨 Output Format

### Color Coding
- 🔵 **Blue**: Headers and titles
- 🟢 **Green**: Success messages and author names
- 🟡 **Yellow**: Prompts and warnings
- 🔷 **Cyan**: Section headers and statistics
- 🔴 **Red**: Errors and invalid inputs

### Report Structure
Generated reports include:
- Repository metadata
- Time-based statistics
- Author contributions
- Detailed commit history
- File change analysis

## 🛠️ Requirements

- **Git** 2.0 or higher
- **Bash** 4.0 or higher
- **Standard Unix tools**: awk, sed, sort, uniq
- **Terminal** with color support (most modern terminals)

### Checking Requirements

```bash
# Check bash version
bash --version

# Check git version
git --version

# Test color support
echo -e "\033[0;32mGreen text test\033[0m"
```

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Setup

```bash
# Fork and clone the repository
git clone https://github.com/tddworks/git-changes-analyzer.git
cd git-changes-analyzer

# Create a feature branch
git checkout -b feature/your-feature-name

# Make your changes
vim git-changes-analyzer.sh

# Test your changes
./test.sh

# Commit and push
git add .
git commit -m "feat: add amazing feature"
git push origin feature/your-feature-name
```

### Code Style
- Use 4 spaces for indentation
- Add comments for complex logic
- Follow existing naming conventions
- Test thoroughly before submitting PR

## 📋 Roadmap

- [ ] Add support for custom date ranges
- [ ] Export to multiple formats (JSON, CSV)
- [ ] Integration with CI/CD pipelines
- [ ] Web-based dashboard
- [ ] Git hook integration
- [ ] Performance metrics analysis
- [ ] Branch comparison features
- [ ] Team velocity tracking

## 🐛 Troubleshooting

### Common Issues

#### "Not in a git repository" Error
```bash
# Ensure you're in a git repository
git status
```

#### No Commits Found
```bash
# Check if repository has commits in the time range
git log --oneline --since="1 day ago"
```

#### Permission Denied
```bash
# Make script executable
chmod +x git-changes-analyzer.sh
```

#### Colors Not Displaying
```bash
# Check terminal color support
echo $TERM
# Should show something like: xterm-256color
```

## 📄 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by the need for better git analytics tools
- Built with love for the developer community
- Special thanks to all contributors

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/tddworks/git-changes-analyzer/issues)
- **Discussions**: [GitHub Discussions](https://github.com/tddworks/git-changes-analyzer/discussions)
- **Email**: support@tddworks.com

## ⭐ Star History

[![Star History Chart](https://api.star-history.com/svg?repos=tddworks/git-changes-analyzer&type=Date)](https://star-history.com/#tddworks/git-changes-analyzer&Date)

---

**Made with ❤️ by [TDDWorks](https://github.com/tddworks)**

If you find this tool helpful, please consider giving it a ⭐ on GitHub!