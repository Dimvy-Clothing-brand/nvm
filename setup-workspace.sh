#!/bin/bash

# NVM Workspace Setup Script
# Created by @nodoubtz

echo "🚀 Setting up NVM workspace..."

# Check if we're in the right directory
if [ ! -f "nvm.sh" ]; then
    echo "❌ Error: nvm.sh not found. Please run this script from the NVM root directory."
    exit 1
fi

echo "✅ NVM directory confirmed"

# Check Node.js and npm
if command -v node >/dev/null 2>&1; then
    echo "✅ Node.js $(node --version) found"
else
    echo "⚠️  Node.js not found - some features may not work"
fi

if command -v npm >/dev/null 2>&1; then
    echo "✅ npm $(npm --version) found"
else
    echo "❌ npm not found - cannot install dependencies"
    exit 1
fi

# Install dependencies
echo "📦 Installing dependencies..."
npm install || {
    echo "❌ Failed to install dependencies"
    exit 1
}

echo "✅ Dependencies installed successfully"

# Check if security tools are available
echo "🔍 Checking security tools..."

# Check basic tools
tools=("git" "bash" "grep" "find")
for tool in "${tools[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo "✅ $tool available"
    else
        echo "⚠️  $tool not found"
    fi
done

# Check optional tools
optional_tools=("shellcheck" "docker")
for tool in "${optional_tools[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo "✅ $tool available"
    else
        echo "ℹ️  $tool not found (optional)"
    fi
done

# Test NVM script syntax
echo "🧪 Testing NVM script syntax..."
if bash -n nvm.sh; then
    echo "✅ nvm.sh syntax is valid"
else
    echo "❌ nvm.sh has syntax errors"
    exit 1
fi

if bash -n install.sh; then
    echo "✅ install.sh syntax is valid"
else
    echo "❌ install.sh has syntax errors"
    exit 1
fi

# Check workspace files
echo "📋 Checking workspace configuration..."
workspace_files=(
    ".vscode/settings.json"
    ".vscode/tasks.json"
    ".vscode/launch.json"
    ".vscode/extensions.json"
    ".eslintrc.json"
    ".prettierrc.json"
    "package.json"
)

for file in "${workspace_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
    else
        echo "⚠️  $file missing"
    fi
done

# Test package.json syntax
echo "🔧 Validating package.json..."
if node -e "JSON.parse(require('fs').readFileSync('package.json', 'utf8'))" 2>/dev/null; then
    echo "✅ package.json is valid JSON"
else
    echo "❌ package.json has syntax errors"
    exit 1
fi

echo ""
echo "🎉 Workspace setup complete!"
echo ""
echo "📝 Next steps:"
echo "   1. Open nvm.code-workspace in VS Code"
echo "   2. Install recommended extensions"
echo "   3. Use Ctrl+Shift+P > 'Tasks: Run Task' to access build tasks"
echo "   4. Run 'Run All Tests' to verify everything works"
echo ""
echo "🔒 Security features:"
echo "   - Run 'Security Audit All' for vulnerability scanning"
echo "   - Automated security workflows in .github/workflows/"
echo "   - Code quality checks with ESLint and Prettier"
echo ""
echo "✨ Happy coding! - @nodoubtz"
