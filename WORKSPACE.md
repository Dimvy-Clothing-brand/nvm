# NVM Workspace Setup

This document describes the VS Code workspace configuration for the NVM project, enhanced by **@nodoubtz**.

## Workspace Features

### 🚀 Quick Start

1. **Open Workspace**: Open `nvm.code-workspace` in VS Code
2. **Install Extensions**: Accept recommended extensions when prompted
3. **Setup Environment**: Run the "Setup Workspace" task (`Ctrl+Shift+P` > `Tasks: Run Task` > `Setup Workspace`)

### 📋 Available Tasks

Access tasks via `Ctrl+Shift+P` > `Tasks: Run Task`:

#### Build Tasks

- **Setup Workspace** ⭐ (Default) - Complete environment setup
- **Install Dependencies** - Install npm packages
- **Format Code** - Auto-format with Prettier
- **Lint Code** - Run ESLint with auto-fix

#### Test Tasks

- **Run All Tests** ⭐ (Default) - Execute full test suite
- **Run Fast Tests** - Quick test execution
- **ShellCheck Analysis** - Shell script validation
- **Test NVM Installation** - Validate installation script
- **Source NVM and Test** - Basic functionality check

#### Security Tasks

- **Security Audit All** - Complete security scan
- **Security Audit npm** - npm vulnerability check

#### Docker Tasks

- **Run nvm-dev Docker Container** - Development environment

### 🔧 Development Tools

#### Code Quality

- **ESLint**: JavaScript/JSON linting with security rules
- **Prettier**: Code formatting
- **ShellCheck**: Shell script analysis
- **Markdown Lint**: Documentation validation

#### Security Tools

- **Snyk**: Vulnerability scanning
- **npm audit**: Dependency security
- **retire.js**: JavaScript library vulnerability detection

#### Editor Features

- **Auto-format on save**: Prettier integration
- **Lint on save**: ESLint auto-fix
- **Shell script syntax highlighting**
- **Integrated terminal with bash**

### 📁 Workspace Structure

```
nvm/
├── .vscode/                    # VS Code configuration
│   ├── settings.json          # Editor settings
│   ├── tasks.json             # Build/test tasks
│   ├── launch.json            # Debug configurations
│   └── extensions.json        # Recommended extensions
├── .github/workflows/         # CI/CD workflows
│   ├── security.yml           # Security scanning
│   ├── code-quality.yml       # Code quality checks
│   ├── security-testing.yml   # Comprehensive security testing
│   └── nodoubtz-integration.yml # Custom nodoubtz processes
├── audit-ci.json             # Security audit configuration
├── .eslintrc.json            # ESLint configuration
├── .prettierrc.json          # Prettier configuration
├── .snyk                     # Snyk security policy
└── nvm.code-workspace        # Main workspace file
```

### 🛠️ Configuration Files

#### Editor Configuration

- **settings.json**: VS Code editor preferences
- **tasks.json**: Automated tasks and builds
- **launch.json**: Debug configurations
- **extensions.json**: Recommended extensions

#### Code Quality

- **.eslintrc.json**: Linting rules with security focus
- **.prettierrc.json**: Code formatting standards
- **.prettierignore**: Files to exclude from formatting

#### Security Configuration

- **audit-ci.json**: npm audit CI settings
- **.snyk**: Vulnerability management policy
- **SECURITY.md**: Security reporting guidelines

### 🔍 Security Features

#### Automated Security Scans

- **Daily**: Dependency vulnerability checks
- **Weekly**: Comprehensive security testing
- **On Push/PR**: Full security workflow execution
- **On Release**: Security validation and attestation

#### Security Tools Integration

- GitHub Security tab integration
- SARIF format security reports
- Automated dependency updates
- Secret detection and prevention

### 🚀 Getting Started

#### Prerequisites

- VS Code with recommended extensions
- Node.js 16+
- npm or yarn
- Git
- ShellCheck (for shell script analysis)

#### First-Time Setup

1. Clone the repository
2. Open `nvm.code-workspace` in VS Code
3. Install recommended extensions when prompted
4. Run "Setup Workspace" task
5. Start developing!

#### Daily Workflow

1. Open workspace
2. Pull latest changes
3. Run "Setup Workspace" if dependencies changed
4. Make your changes
5. Use "Format Code" and "Lint Code" tasks
6. Run tests before committing
7. Security scan with "Security Audit All"

### 🎯 Quality Gates

Before committing code, ensure:

- ✅ All tests pass
- ✅ Code is formatted (Prettier)
- ✅ No linting errors (ESLint)
- ✅ Shell scripts pass ShellCheck
- ✅ Security audit passes
- ✅ No secrets in code

### 🆘 Troubleshooting

#### Common Issues

**Extensions not working**

- Reload VS Code window
- Check extension recommendations in `.vscode/extensions.json`
- Install extensions manually if needed

**Tasks failing**

- Ensure all dependencies are installed: `npm install`
- Check Node.js version: `node --version`
- Verify ShellCheck is installed: `shellcheck --version`

**Security scans failing**

- Update Snyk token in settings if using authenticated scanning
- Check network connectivity for npm audit
- Review security policies in `.snyk` file

#### Getting Help

- Check task output in VS Code terminal
- Review logs in integrated terminal
- Contact @nodoubtz for workspace-specific issues

### 📊 Monitoring & Metrics

#### Code Quality Metrics

- Test coverage reports
- Linting error tracking
- Code formatting compliance
- Security vulnerability counts

#### Performance Tracking

- Build time monitoring
- Test execution duration
- Security scan performance
- Dependency update frequency

---

**Maintained by:** @nodoubtz  
**Last Updated:** June 27, 2025  
**Workspace Version:** 1.0

For questions about this workspace setup, please contact @nodoubtz through the project's communication channels.
