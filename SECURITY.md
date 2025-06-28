# NVM Security Policy

## Supported Versions

We actively support security updates for the following versions of NVM:

| Version | Supported          |
| ------- | ------------------ |
| 0.40.x  | :white_check_mark: |
| 0.39.x  | :white_check_mark: |
| 0.38.x  | :x:                |
| < 0.38  | :x:                |

## Reporting a Vulnerability

We take security vulnerabilities seriously. If you discover a security vulnerability in NVM, please follow these steps:

### 1. **Do Not** Create a Public Issue

Please do not create a public GitHub issue for security vulnerabilities. This could put users at risk.

### 2. Contact Information

Send an email to: [security@nodoubtz.com](mailto:security@nodoubtz.com)

Include the following information:

- Description of the vulnerability
- Steps to reproduce the issue
- Potential impact
- Any suggested fixes (if you have them)

### 3. Response Timeline

- **Initial Response**: Within 48 hours
- **Status Update**: Within 7 days
- **Fix Timeline**: Critical vulnerabilities will be addressed within 30 days

### 4. Security Best Practices

When using NVM:

- Always verify the integrity of downloads
- Keep NVM updated to the latest version
- Use official installation methods only
- Review any scripts before execution
- Be cautious with custom repositories

### 5. Bug Bounty

We currently do not offer a formal bug bounty program, but we greatly appreciate responsible disclosure and will acknowledge security researchers in our release notes.

### 6. GPG Verification

Our releases are signed with GPG. You can verify the authenticity of releases using our public key:

```bash
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 0x1234567890ABCDEF
```

## Security Tools

This project uses several security tools:

- **npm audit**: Regular dependency vulnerability scanning
- **Snyk**: Advanced vulnerability detection and monitoring
- **CodeQL**: Static analysis security testing
- **Trivy**: Container vulnerability scanning
- **TruffleHog**: Secret detection
- **ShellCheck**: Shell script security analysis

## Security Monitoring

- Automated security scans run on every push and pull request
- Daily scheduled security audits
- Dependency vulnerability monitoring
- Container image security scanning

---

For general questions about NVM, please use our [GitHub Discussions](https://github.com/nvm-sh/nvm/discussions) or [Issues](https://github.com/nvm-sh/nvm/issues) page.
