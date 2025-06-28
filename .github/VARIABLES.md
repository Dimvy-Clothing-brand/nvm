# GitHub Repository Variables Configuration

This document outlines the recommended GitHub repository variables for the NVM project with AI Super Intelligence features.

## Repository Variables (Settings > Secrets and variables > Actions > Variables)

### Core Configuration Variables

```yaml
# Runtime Configuration
NODE_VERSION: "20"
NPM_VERSION: "10"
DOCKER_REGISTRY: "ghcr.io"

# Build Configuration
BUILD_TIMEOUT: "30m"
TEST_TIMEOUT: "20m"
DEPLOY_TIMEOUT: "10m"

# Security Configuration
SNYK_SEVERITY_THRESHOLD: "high"
CODEQL_LANGUAGES: "javascript"
SECURITY_SCAN_TIMEOUT: "15m"
```

### Quality Gates Variables

```yaml
# Code Quality Thresholds
MIN_CODE_COVERAGE: "75"
MAX_COMPLEXITY: "10"
MIN_MAINTAINABILITY: "60"
SONAR_QUALITY_GATE: "strict"
```

### Nodoubtz Configuration Variables

```yaml
# Nodoubtz Specific Settings
NODOUBTZ_MAINTAINER: "@nodoubtz"
NODOUBTZ_TOOLKIT_VERSION: "latest"
NODOUBTZ_SECURITY_LEVEL: "comprehensive"
NODOUBTZ_ANALYSIS_TYPE: "full"
```

### Environment-Specific Variables

#### Development Environment
```yaml
DEBUG_MODE: "true"
LOG_LEVEL: "debug"
ENVIRONMENT_TYPE: "development"
REGISTRY_URL: "https://registry.npmjs.org"
```

#### Staging Environment
```yaml
DEBUG_MODE: "true"
LOG_LEVEL: "warn"
ENVIRONMENT_TYPE: "staging"
REGISTRY_URL: "https://npm.pkg.github.com"
```

#### Production Environment
```yaml
DEBUG_MODE: "false"
LOG_LEVEL: "error"
ENVIRONMENT_TYPE: "production"
REGISTRY_URL: "https://registry.npmjs.org"
```

### AI Features Variables

```yaml
# AI Configuration
NVM_AI_ENABLED: "1"
NVM_AI_MODEL: "gpt-4"
NVM_AI_CACHE_DIR: "~/.nvm/.ai-cache"
NVM_AI_LEARNING_MODE: "1"
NVM_AI_AUTO_OPTIMIZE: "1"
NVM_AI_PREDICTIVE_MODE: "1"
NVM_AI_SECURITY_SCAN: "1"
```

## Repository Secrets (Settings > Secrets and variables > Actions > Secrets)

### Required Secrets

```yaml
# GitHub Integration
GITHUB_TOKEN: "ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# Security Scanning
SNYK_TOKEN: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
SONAR_TOKEN: "squ_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# Container Registry
DOCKER_HUB_USERNAME: "nodoubtz"
DOCKER_HUB_TOKEN: "dckr_pat_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
GHCR_TOKEN: "ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# Deployment Keys
DEPLOY_KEY_PRIVATE: "-----BEGIN OPENSSH PRIVATE KEY-----"
DEPLOY_KEY_PUBLIC: "ssh-rsa AAAAB3NzaC1yc2E..."

# API Keys (Optional for enhanced AI features)
NVM_AI_API_KEY: "sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
OPENAI_API_KEY: "sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

## Environment Configuration

### GitHub Environments

Create the following environments in your repository settings:

1. **development**
   - Protection rules: None
   - Environment secrets: Development-specific secrets
   - Reviewers: @nodoubtz

2. **staging**
   - Protection rules: Required reviewers
   - Environment secrets: Staging-specific secrets
   - Reviewers: @nodoubtz

3. **production**
   - Protection rules: Required reviewers + deployment branches
   - Environment secrets: Production-specific secrets
   - Reviewers: @nodoubtz
   - Deployment branches: main, master

## Usage in Workflows

### Accessing Variables in GitHub Actions

```yaml
env:
  NODE_VERSION: ${{ vars.NODE_VERSION }}
  MIN_COVERAGE: ${{ vars.MIN_CODE_COVERAGE }}
  NODOUBTZ_MAINTAINER: ${{ vars.NODOUBTZ_MAINTAINER }}

steps:
  - name: Use variables
    run: |
      echo "Node Version: ${{ vars.NODE_VERSION }}"
      echo "Maintainer: ${{ vars.NODOUBTZ_MAINTAINER }}"
      echo "Coverage Threshold: ${{ vars.MIN_CODE_COVERAGE }}%"
```

### Accessing Secrets in GitHub Actions

```yaml
env:
  SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
  
steps:
  - name: Security scan
    run: |
      snyk auth ${{ secrets.SNYK_TOKEN }}
      snyk test
```

## Setting Up Variables

### Via GitHub CLI

```bash
# Set repository variables
gh variable set NODE_VERSION --body "20"
gh variable set MIN_CODE_COVERAGE --body "75"
gh variable set NODOUBTZ_MAINTAINER --body "@nodoubtz"

# Set repository secrets
gh secret set SNYK_TOKEN --body "your-snyk-token"
gh secret set DOCKER_HUB_TOKEN --body "your-docker-token"
```

### Via GitHub Web Interface

1. Go to your repository
2. Click on **Settings**
3. Click on **Secrets and variables** → **Actions**
4. Click on **Variables** tab
5. Click **New repository variable**
6. Add the variable name and value
7. Click **Add variable**

### Via Terraform (Infrastructure as Code)

```hcl
resource "github_actions_variable" "node_version" {
  repository    = "nvm"
  variable_name = "NODE_VERSION"
  value         = "20"
}

resource "github_actions_variable" "nodoubtz_maintainer" {
  repository    = "nvm"
  variable_name = "NODOUBTZ_MAINTAINER"
  value         = "@nodoubtz"
}

resource "github_actions_secret" "snyk_token" {
  repository      = "nvm"
  secret_name     = "SNYK_TOKEN"
  plaintext_value = var.snyk_token
}
```

## Best Practices

### Variable Management

1. **Use Variables for Configuration**: Store non-sensitive configuration in variables
2. **Use Secrets for Sensitive Data**: Store API keys, tokens, and passwords in secrets
3. **Environment-Specific Values**: Use environment-specific variables for different deployment targets
4. **Naming Convention**: Use UPPER_CASE with underscores for consistency
5. **Documentation**: Document all variables and their purposes

### Security Considerations

1. **Least Privilege**: Only grant access to secrets that are needed
2. **Regular Rotation**: Rotate secrets regularly
3. **Audit Access**: Monitor who has access to secrets
4. **Environment Isolation**: Use different secrets for different environments
5. **Secret Scanning**: Enable secret scanning to detect leaked secrets

### Maintenance

1. **Regular Review**: Review variables and secrets quarterly
2. **Remove Unused**: Clean up unused variables and secrets
3. **Update Documentation**: Keep this documentation current
4. **Version Control**: Track changes to variable configurations
5. **Backup**: Maintain backups of critical secrets (securely)

---

**Maintained by:** @nodoubtz  
**Last Updated:** $(date -u +'%Y-%m-%d')  
**Version:** 1.0.0
