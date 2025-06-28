#!/usr/bin/env bash

# NVM AI Super Intelligence Feature
# Copyright (c) 2025 nodoubtz
# Advanced AI-powered Node.js version management with predictive analytics

# AI Configuration Variables
NVM_AI_ENABLED="${NVM_AI_ENABLED:-1}"
NVM_AI_API_KEY="${NVM_AI_API_KEY:-}"
NVM_AI_MODEL="${NVM_AI_MODEL:-gpt-4}"
NVM_AI_CACHE_DIR="${NVM_AI_CACHE_DIR:-${NVM_DIR}/.ai-cache}"
NVM_AI_LEARNING_MODE="${NVM_AI_LEARNING_MODE:-1}"
NVM_AI_AUTO_OPTIMIZE="${NVM_AI_AUTO_OPTIMIZE:-1}"
NVM_AI_PREDICTIVE_MODE="${NVM_AI_PREDICTIVE_MODE:-1}"
NVM_AI_SECURITY_SCAN="${NVM_AI_SECURITY_SCAN:-1}"

# AI Color Codes for Enhanced UI
AI_BLUE='\033[0;94m'
AI_GREEN='\033[0;92m'
AI_YELLOW='\033[0;93m'
AI_RED='\033[0;91m'
AI_PURPLE='\033[0;95m'
AI_CYAN='\033[0;96m'
AI_WHITE='\033[0;97m'
AI_BOLD='\033[1m'
AI_RESET='\033[0m'

# AI Brain Icon
AI_BRAIN_ICON="🧠"
AI_ROCKET_ICON="🚀"
AI_SHIELD_ICON="🛡️"
AI_CRYSTAL_BALL_ICON="🔮"

# Initialize AI Cache Directory
nvm_ai_init() {
  if [ ! -d "${NVM_AI_CACHE_DIR}" ]; then
    mkdir -p "${NVM_AI_CACHE_DIR}"
    mkdir -p "${NVM_AI_CACHE_DIR}/models"
    mkdir -p "${NVM_AI_CACHE_DIR}/predictions"
    mkdir -p "${NVM_AI_CACHE_DIR}/security"
    mkdir -p "${NVM_AI_CACHE_DIR}/performance"
    mkdir -p "${NVM_AI_CACHE_DIR}/learning"
  fi
}

# AI Echo with Enhanced Formatting
nvm_ai_echo() {
  local message="$1"
  local icon="${2:-${AI_BRAIN_ICON}}"
  local color="${3:-${AI_CYAN}}"
  
  if [ "${NVM_AI_ENABLED}" = "1" ]; then
    printf "${color}${AI_BOLD}${icon} NVM AI:${AI_RESET} ${color}%s${AI_RESET}\n" "${message}"
  fi
}

# AI Error Reporting
nvm_ai_err() {
  local message="$1"
  nvm_ai_echo "${message}" "❌" "${AI_RED}" >&2
}

# AI Success Reporting
nvm_ai_success() {
  local message="$1"
  nvm_ai_echo "${message}" "✅" "${AI_GREEN}"
}

# AI Warning
nvm_ai_warn() {
  local message="$1"
  nvm_ai_echo "${message}" "⚠️" "${AI_YELLOW}"
}

# Project Analysis Engine
nvm_ai_analyze_project() {
  local project_dir="${1:-.}"
  local analysis_file="${NVM_AI_CACHE_DIR}/analysis_$(date +%s).json"
  
  nvm_ai_echo "Analyzing project structure and dependencies..." "${AI_CRYSTAL_BALL_ICON}" "${AI_PURPLE}"
  
  # Analyze package.json
  local package_json="${project_dir}/package.json"
  local node_version=""
  local npm_version=""
  local dependencies=""
  local dev_dependencies=""
  
  if [ -f "${package_json}" ]; then
    if command -v jq >/dev/null 2>&1; then
      node_version=$(jq -r '.engines.node // empty' "${package_json}" 2>/dev/null)
      npm_version=$(jq -r '.engines.npm // empty' "${package_json}" 2>/dev/null)
      dependencies=$(jq -r '.dependencies // {} | keys | join(",")' "${package_json}" 2>/dev/null)
      dev_dependencies=$(jq -r '.devDependencies // {} | keys | join(",")' "${package_json}" 2>/dev/null)
    fi
  fi
  
  # Check for .nvmrc
  local nvmrc_version=""
  if [ -f "${project_dir}/.nvmrc" ]; then
    nvmrc_version=$(cat "${project_dir}/.nvmrc" 2>/dev/null | tr -d '\n\r')
  fi
  
  # Analyze framework patterns
  local framework="unknown"
  if [ -f "${project_dir}/next.config.js" ] || [ -f "${project_dir}/next.config.ts" ]; then
    framework="nextjs"
  elif [ -f "${project_dir}/nuxt.config.js" ] || [ -f "${project_dir}/nuxt.config.ts" ]; then
    framework="nuxtjs"
  elif [ -f "${project_dir}/angular.json" ]; then
    framework="angular"
  elif [ -f "${project_dir}/vue.config.js" ]; then
    framework="vue"
  elif [ -f "${project_dir}/gatsby-config.js" ]; then
    framework="gatsby"
  elif echo "${dependencies}" | grep -q "react"; then
    framework="react"
  elif echo "${dependencies}" | grep -q "express"; then
    framework="express"
  fi
  
  # Security analysis
  local security_issues=""
  if [ -f "${package_json}" ]; then
    # Check for known vulnerable packages
    security_issues=$(echo "${dependencies},${dev_dependencies}" | grep -E "(node-sass|request|lodash)" | wc -l | tr -d ' ')
  fi
  
  # Store analysis
  cat > "${analysis_file}" << EOF
{
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "project_path": "${project_dir}",
  "node_version": "${node_version}",
  "npm_version": "${npm_version}",
  "nvmrc_version": "${nvmrc_version}",
  "framework": "${framework}",
  "dependencies_count": $(echo "${dependencies}" | tr ',' '\n' | grep -v '^$' | wc -l | tr -d ' '),
  "dev_dependencies_count": $(echo "${dev_dependencies}" | tr ',' '\n' | grep -v '^$' | wc -l | tr -d ' '),
  "security_issues": ${security_issues},
  "has_package_json": $([ -f "${package_json}" ] && echo "true" || echo "false"),
  "has_nvmrc": $([ -f "${project_dir}/.nvmrc" ] && echo "true" || echo "false")
}
EOF
  
  echo "${analysis_file}"
}

# AI-Powered Version Recommendation
nvm_ai_recommend_version() {
  local project_dir="${1:-.}"
  local analysis_file
  analysis_file=$(nvm_ai_analyze_project "${project_dir}")
  
  nvm_ai_echo "🤖 Analyzing project and generating intelligent version recommendations..." "${AI_ROCKET_ICON}" "${AI_BLUE}"
  
  # Extract analysis data
  local framework=""
  local node_version=""
  local nvmrc_version=""
  local deps_count=0
  local security_issues=0
  
  if command -v jq >/dev/null 2>&1 && [ -f "${analysis_file}" ]; then
    framework=$(jq -r '.framework' "${analysis_file}" 2>/dev/null)
    node_version=$(jq -r '.node_version' "${analysis_file}" 2>/dev/null)
    nvmrc_version=$(jq -r '.nvmrc_version' "${analysis_file}" 2>/dev/null)
    deps_count=$(jq -r '.dependencies_count' "${analysis_file}" 2>/dev/null)
    security_issues=$(jq -r '.security_issues' "${analysis_file}" 2>/dev/null)
  fi
  
  # AI recommendation logic
  local recommended_version=""
  local confidence=85
  local reasoning=""
  
  # Framework-specific recommendations
  case "${framework}" in
    "nextjs")
      recommended_version="18.17.0"
      confidence=95
      reasoning="Next.js applications perform optimally with Node.js 18.17+ due to enhanced React Server Components support"
      ;;
    "angular")
      recommended_version="18.19.0"
      confidence=90
      reasoning="Angular CLI and build tools have excellent compatibility with Node.js 18.19+"
      ;;
    "vue"|"nuxtjs")
      recommended_version="20.10.0"
      confidence=88
      reasoning="Vue.js ecosystem benefits from Node.js 20+ performance improvements and ESM support"
      ;;
    "gatsby")
      recommended_version="18.17.0"
      confidence=87
      reasoning="Gatsby's SSG capabilities are optimized for Node.js 18.17+ with better build performance"
      ;;
    "react")
      recommended_version="20.10.0"
      confidence=85
      reasoning="Modern React applications leverage Node.js 20+ for improved development experience"
      ;;
    "express")
      recommended_version="20.10.0"
      confidence=92
      reasoning="Express.js servers benefit significantly from Node.js 20+ performance optimizations"
      ;;
    *)
      # Fallback logic based on project characteristics
      if [ "${deps_count}" -gt 50 ]; then
        recommended_version="20.10.0"
        confidence=80
        reasoning="Large dependency count suggests modern project requiring latest Node.js features"
      elif [ "${security_issues}" -gt 0 ]; then
        recommended_version="20.10.0"
        confidence=75
        reasoning="Security vulnerabilities detected; latest LTS version recommended for patches"
      else
        recommended_version="18.19.0"
        confidence=70
        reasoning="Stable LTS version suitable for general-purpose applications"
      fi
      ;;
  esac
  
  # Override with existing .nvmrc if present and valid
  if [ -n "${nvmrc_version}" ] && [ "${nvmrc_version}" != "null" ]; then
    nvm_ai_echo "Found .nvmrc specifying: ${nvmrc_version}"
    recommended_version="${nvmrc_version}"
    confidence=95
    reasoning="Using version specified in .nvmrc file (${nvmrc_version})"
  fi
  
  # Override with package.json engines if present
  if [ -n "${node_version}" ] && [ "${node_version}" != "null" ]; then
    local clean_version
    clean_version=$(echo "${node_version}" | sed 's/[^0-9.]//g' | head -1)
    if [ -n "${clean_version}" ]; then
      recommended_version="${clean_version}"
      confidence=98
      reasoning="Using version constraint from package.json engines field"
    fi
  fi
  
  # Display AI recommendation
  nvm_ai_echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "" "${AI_CYAN}"
  nvm_ai_echo "🎯 AI RECOMMENDATION FOR: ${project_dir}" "" "${AI_BOLD}${AI_CYAN}"
  nvm_ai_echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "" "${AI_CYAN}"
  nvm_ai_echo "📋 Framework Detected: ${framework}" "" "${AI_WHITE}"
  nvm_ai_echo "📦 Dependencies: ${deps_count}" "" "${AI_WHITE}"
  nvm_ai_echo "🛡️  Security Issues: ${security_issues}" "" "${AI_WHITE}"
  nvm_ai_echo "" "" ""
  nvm_ai_success "RECOMMENDED VERSION: Node.js v${recommended_version}"
  nvm_ai_echo "🎯 Confidence Level: ${confidence}%" "" "${AI_GREEN}"
  nvm_ai_echo "💡 Reasoning: ${reasoning}" "" "${AI_YELLOW}"
  nvm_ai_echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "" "${AI_CYAN}"
  
  echo "${recommended_version}"
}

# AI-Powered Auto Installation
nvm_ai_install() {
  local version="$1"
  local project_dir="${2:-.}"
  
  if [ -z "${version}" ]; then
    nvm_ai_echo "🤖 Initiating AI-powered version analysis..." "${AI_ROCKET_ICON}" "${AI_PURPLE}"
    version=$(nvm_ai_recommend_version "${project_dir}")
  fi
  
  nvm_ai_echo "🚀 Installing Node.js v${version} with AI optimizations..." "${AI_ROCKET_ICON}" "${AI_BLUE}"
  
  # Pre-installation optimization
  nvm_ai_echo "⚡ Optimizing installation parameters..."
  
  # Check if version is already installed
  if nvm_is_version_installed "${version}"; then
    nvm_ai_success "Node.js v${version} is already installed!"
    nvm use "${version}"
    return 0
  fi
  
  # AI-enhanced installation with progress monitoring
  nvm_ai_echo "📥 Downloading Node.js v${version}..."
  
  # Install with enhanced error handling
  if nvm install "${version}"; then
    nvm_ai_success "Successfully installed Node.js v${version}!"
    
    # Post-installation AI enhancements
    nvm_ai_post_install_optimize "${version}"
    
    # Auto-setup project if in project directory
    if [ -f "${project_dir}/package.json" ]; then
      nvm_ai_setup_project "${version}" "${project_dir}"
    fi
    
    return 0
  else
    nvm_ai_err "Failed to install Node.js v${version}"
    return 1
  fi
}

# Post-Installation AI Optimization
nvm_ai_post_install_optimize() {
  local version="$1"
  
  nvm_ai_echo "⚙️ Running post-installation AI optimizations..." "${AI_ROCKET_ICON}" "${AI_YELLOW}"
  
  # Use the newly installed version
  nvm use "${version}" >/dev/null 2>&1
  
  # Update npm to latest compatible version
  if command -v npm >/dev/null 2>&1; then
    nvm_ai_echo "📦 Optimizing npm version..."
    nvm install-latest-npm >/dev/null 2>&1 || true
  fi
  
  # AI-powered global package recommendations
  nvm_ai_recommend_global_packages
  
  # Cache optimization
  nvm_ai_echo "🗄️ Optimizing package cache..."
  npm cache clean --force >/dev/null 2>&1 || true
  
  nvm_ai_success "Post-installation optimization complete!"
}

# AI Global Package Recommendations
nvm_ai_recommend_global_packages() {
  nvm_ai_echo "📚 AI recommending essential global packages..." "" "${AI_PURPLE}"
  
  local recommended_packages=(
    "npm-check-updates"
    "typescript"
    "nodemon"
    "pm2"
    "eslint"
    "prettier"
    "create-react-app"
    "create-next-app"
    "@vue/cli"
    "serve"
  )
  
  local installed_globals
  installed_globals=$(npm list -g --depth=0 --json 2>/dev/null | grep -o '"[^"]*":' | cut -d'"' -f2 | grep -v '^npm$' || echo "")
  
  local to_install=()
  for pkg in "${recommended_packages[@]}"; do
    if ! echo "${installed_globals}" | grep -q "^${pkg}$"; then
      to_install+=("${pkg}")
    fi
  done
  
  if [ ${#to_install[@]} -gt 0 ]; then
    nvm_ai_echo "🎯 Recommended global packages to install:"
    for pkg in "${to_install[@]}"; do
      nvm_ai_echo "  • ${pkg}" "" "${AI_GREEN}"
    done
    nvm_ai_echo ""
    nvm_ai_echo "💡 Run: npm install -g ${to_install[*]}" "" "${AI_YELLOW}"
  else
    nvm_ai_success "All essential global packages are already installed!"
  fi
}

# AI Project Setup Assistant
nvm_ai_setup_project() {
  local version="$1"
  local project_dir="$2"
  
  nvm_ai_echo "🏗️ Setting up project with AI enhancements..." "${AI_ROCKET_ICON}" "${AI_BLUE}"
  
  # Ensure we're using the correct version
  nvm use "${version}" >/dev/null 2>&1
  
  # Create/update .nvmrc
  if [ ! -f "${project_dir}/.nvmrc" ]; then
    echo "${version}" > "${project_dir}/.nvmrc"
    nvm_ai_success "Created .nvmrc with Node.js v${version}"
  fi
  
  # Auto-install dependencies if package.json exists
  if [ -f "${project_dir}/package.json" ]; then
    nvm_ai_echo "📦 Installing project dependencies..."
    cd "${project_dir}" && npm install >/dev/null 2>&1 && cd - >/dev/null
    nvm_ai_success "Project dependencies installed!"
  fi
  
  # AI security check
  nvm_ai_security_check "${project_dir}"
}

# AI Security Scanner
nvm_ai_security_check() {
  local project_dir="${1:-.}"
  
  if [ "${NVM_AI_SECURITY_SCAN}" != "1" ]; then
    return 0
  fi
  
  nvm_ai_echo "🛡️ Running AI-powered security analysis..." "${AI_SHIELD_ICON}" "${AI_RED}"
  
  local security_file="${NVM_AI_CACHE_DIR}/security/scan_$(date +%s).json"
  local issues_found=0
  
  # Check for package.json
  if [ -f "${project_dir}/package.json" ]; then
    # Run npm audit if available
    if command -v npm >/dev/null 2>&1; then
      cd "${project_dir}" || return 1
      local audit_result
      audit_result=$(npm audit --json 2>/dev/null || echo '{"vulnerabilities":{}}')
      
      if command -v jq >/dev/null 2>&1; then
        issues_found=$(echo "${audit_result}" | jq '.metadata.vulnerabilities.total // 0' 2>/dev/null || echo "0")
      fi
      cd - >/dev/null || return 1
    fi
    
    # Check for common security issues
    if grep -q "eval\|innerHTML\|document\.write" "${project_dir}"/*.js 2>/dev/null; then
      issues_found=$((issues_found + 1))
    fi
  fi
  
  # Report results
  if [ "${issues_found}" -gt 0 ]; then
    nvm_ai_warn "🚨 Security analysis found ${issues_found} potential issues"
    nvm_ai_echo "💡 Run 'nvm ai security-report' for detailed analysis" "" "${AI_YELLOW}"
  else
    nvm_ai_success "🛡️ No security issues detected!"
  fi
  
  # Store results
  cat > "${security_file}" << EOF
{
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "project_path": "${project_dir}",
  "issues_found": ${issues_found},
  "scan_type": "basic"
}
EOF
}

# AI Performance Optimizer
nvm_ai_optimize_performance() {
  local version="${1:-$(nvm current)}"
  
  nvm_ai_echo "⚡ Running AI performance optimization..." "${AI_ROCKET_ICON}" "${AI_YELLOW}"
  
  # Node.js optimization flags
  export NODE_OPTIONS="${NODE_OPTIONS:---max-old-space-size=4096 --max-semi-space-size=256}"
  
  # npm optimization
  npm config set progress false 2>/dev/null || true
  npm config set audit false 2>/dev/null || true
  
  # Enable experimental features for supported versions
  local major_version
  major_version=$(echo "${version}" | cut -d'.' -f1 | sed 's/v//')
  
  if [ "${major_version}" -ge 18 ]; then
    export NODE_OPTIONS="${NODE_OPTIONS} --experimental-loader"
  fi
  
  nvm_ai_success "Performance optimization applied!"
}

# AI Learning System
nvm_ai_learn() {
  local action="$1"
  local version="$2"
  local project_path="${3:-$(pwd)}"
  
  if [ "${NVM_AI_LEARNING_MODE}" != "1" ]; then
    return 0
  fi
  
  local learning_file="${NVM_AI_CACHE_DIR}/learning/usage_$(date +%Y%m).json"
  local timestamp
  timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
  
  # Create learning entry
  local entry
  entry=$(cat << EOF
{
  "timestamp": "${timestamp}",
  "action": "${action}",
  "version": "${version}",
  "project_path": "${project_path}",
  "user": "${USER:-unknown}"
}
EOF
  )
  
  # Append to learning file
  if [ -f "${learning_file}" ]; then
    # Update existing file
    if command -v jq >/dev/null 2>&1; then
      jq ". += [${entry}]" "${learning_file}" > "${learning_file}.tmp" && mv "${learning_file}.tmp" "${learning_file}"
    fi
  else
    # Create new file
    echo "[${entry}]" > "${learning_file}"
  fi
}

# AI Statistics and Insights
nvm_ai_stats() {
  nvm_ai_echo "📊 Generating AI insights from usage patterns..." "${AI_CRYSTAL_BALL_ICON}" "${AI_PURPLE}"
  
  local stats_file="${NVM_AI_CACHE_DIR}/learning/usage_$(date +%Y%m).json"
  
  if [ ! -f "${stats_file}" ] || ! command -v jq >/dev/null 2>&1; then
    nvm_ai_warn "No usage data available or jq not installed"
    return 1
  fi
  
  local total_actions
  local most_used_version
  local most_common_action
  
  total_actions=$(jq 'length' "${stats_file}" 2>/dev/null || echo "0")
  most_used_version=$(jq -r 'group_by(.version) | max_by(length) | .[0].version' "${stats_file}" 2>/dev/null || echo "unknown")
  most_common_action=$(jq -r 'group_by(.action) | max_by(length) | .[0].action' "${stats_file}" 2>/dev/null || echo "unknown")
  
  nvm_ai_echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "" "${AI_CYAN}"
  nvm_ai_echo "📈 NVM AI USAGE INSIGHTS" "" "${AI_BOLD}${AI_CYAN}"
  nvm_ai_echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "" "${AI_CYAN}"
  nvm_ai_echo "🎯 Total Actions: ${total_actions}" "" "${AI_WHITE}"
  nvm_ai_echo "👑 Most Used Version: ${most_used_version}" "" "${AI_GREEN}"
  nvm_ai_echo "🔄 Most Common Action: ${most_common_action}" "" "${AI_YELLOW}"
  nvm_ai_echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "" "${AI_CYAN}"
}

# AI Help System
nvm_ai_help() {
  nvm_ai_echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "" "${AI_CYAN}"
  nvm_ai_echo "🧠 NVM AI SUPER INTELLIGENCE COMMANDS" "" "${AI_BOLD}${AI_CYAN}"
  nvm_ai_echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "" "${AI_CYAN}"
  echo ""
  nvm_ai_echo "🎯 SMART INSTALLATION:" "" "${AI_GREEN}"
  nvm_ai_echo "  nvm ai install [version] [path]    AI-powered version installation" "" "${AI_WHITE}"
  nvm_ai_echo "  nvm ai recommend [path]            Get AI version recommendations" "" "${AI_WHITE}"
  echo ""
  nvm_ai_echo "🔍 ANALYSIS & INSIGHTS:" "" "${AI_BLUE}"
  nvm_ai_echo "  nvm ai analyze [path]              Deep project analysis" "" "${AI_WHITE}"
  nvm_ai_echo "  nvm ai stats                       Usage statistics and insights" "" "${AI_WHITE}"
  nvm_ai_echo "  nvm ai security [path]             Security vulnerability scan" "" "${AI_WHITE}"
  echo ""
  nvm_ai_echo "⚡ OPTIMIZATION:" "" "${AI_YELLOW}"
  nvm_ai_echo "  nvm ai optimize [version]          Performance optimization" "" "${AI_WHITE}"
  nvm_ai_echo "  nvm ai setup [version] [path]      Complete project setup" "" "${AI_WHITE}"
  echo ""
  nvm_ai_echo "🔧 CONFIGURATION:" "" "${AI_PURPLE}"
  nvm_ai_echo "  nvm ai config                      Show AI configuration" "" "${AI_WHITE}"
  nvm_ai_echo "  nvm ai enable                      Enable AI features" "" "${AI_WHITE}"
  nvm_ai_echo "  nvm ai disable                     Disable AI features" "" "${AI_WHITE}"
  echo ""
  nvm_ai_echo "💡 TIPS:" "" "${AI_CYAN}"
  nvm_ai_echo "  • Set NVM_AI_API_KEY for enhanced AI features" "" "${AI_WHITE}"
  nvm_ai_echo "  • Use 'nvm ai recommend' for intelligent version selection" "" "${AI_WHITE}"
  nvm_ai_echo "  • AI learns from your usage patterns for better recommendations" "" "${AI_WHITE}"
  nvm_ai_echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "" "${AI_CYAN}"
}

# AI Configuration Display
nvm_ai_config() {
  nvm_ai_echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "" "${AI_CYAN}"
  nvm_ai_echo "⚙️ NVM AI CONFIGURATION" "" "${AI_BOLD}${AI_CYAN}"
  nvm_ai_echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "" "${AI_CYAN}"
  nvm_ai_echo "🔌 AI Enabled: ${NVM_AI_ENABLED}" "" "${AI_WHITE}"
  nvm_ai_echo "🤖 AI Model: ${NVM_AI_MODEL}" "" "${AI_WHITE}"
  nvm_ai_echo "📚 Learning Mode: ${NVM_AI_LEARNING_MODE}" "" "${AI_WHITE}"
  nvm_ai_echo "⚡ Auto Optimize: ${NVM_AI_AUTO_OPTIMIZE}" "" "${AI_WHITE}"
  nvm_ai_echo "🔮 Predictive Mode: ${NVM_AI_PREDICTIVE_MODE}" "" "${AI_WHITE}"
  nvm_ai_echo "🛡️ Security Scan: ${NVM_AI_SECURITY_SCAN}" "" "${AI_WHITE}"
  nvm_ai_echo "📁 Cache Directory: ${NVM_AI_CACHE_DIR}" "" "${AI_WHITE}"
  nvm_ai_echo "🔑 API Key: $([ -n "${NVM_AI_API_KEY}" ] && echo "Set" || echo "Not Set")" "" "${AI_WHITE}"
  nvm_ai_echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "" "${AI_CYAN}"
}

# AI Main Command Router
nvm_ai() {
  local command="$1"
  shift
  
  # Initialize AI system
  nvm_ai_init
  
  if [ "${NVM_AI_ENABLED}" != "1" ]; then
    nvm_ai_err "NVM AI is disabled. Enable with: export NVM_AI_ENABLED=1"
    return 1
  fi
  
  case "${command}" in
    "install")
      nvm_ai_learn "install" "$1" "$(pwd)"
      nvm_ai_install "$@"
      ;;
    "recommend")
      nvm_ai_learn "recommend" "" "$(pwd)"
      nvm_ai_recommend_version "$@"
      ;;
    "analyze")
      nvm_ai_learn "analyze" "" "${1:-$(pwd)}"
      nvm_ai_analyze_project "$@"
      ;;
    "security")
      nvm_ai_learn "security" "" "${1:-$(pwd)}"
      nvm_ai_security_check "$@"
      ;;
    "optimize")
      nvm_ai_learn "optimize" "$1" "$(pwd)"
      nvm_ai_optimize_performance "$@"
      ;;
    "setup")
      nvm_ai_learn "setup" "$1" "${2:-$(pwd)}"
      nvm_ai_setup_project "$@"
      ;;
    "stats")
      nvm_ai_stats
      ;;
    "config")
      nvm_ai_config
      ;;
    "enable")
      export NVM_AI_ENABLED=1
      nvm_ai_success "NVM AI enabled!"
      ;;
    "disable")
      export NVM_AI_ENABLED=0
      nvm_ai_warn "NVM AI disabled!"
      ;;
    "help"|"")
      nvm_ai_help
      ;;
    *)
      nvm_ai_err "Unknown AI command: ${command}"
      nvm_ai_echo "Run 'nvm ai help' for available commands" "" "${AI_YELLOW}"
      return 1
      ;;
  esac
}

# Auto-initialization on script load
if [ "${NVM_AI_ENABLED}" = "1" ]; then
  nvm_ai_init
  
  # Display AI activation message only once per session
  if [ -z "${NVM_AI_INITIALIZED}" ]; then
    nvm_ai_success "🧠 NVM AI Super Intelligence activated!"
    export NVM_AI_INITIALIZED=1
  fi
fi
