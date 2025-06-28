#!/usr/bin/env bash

# NVM AI Super Intelligence Demo
# This script demonstrates the advanced AI capabilities

echo "🧠 NVM AI Super Intelligence Demo"
echo "=================================="
echo ""

# Source NVM first
if [ -s "${NVM_DIR}/nvm.sh" ]; then
    . "${NVM_DIR}/nvm.sh"
else
    echo "❌ NVM not found. Please install NVM first."
    exit 1
fi

# Enable AI
export NVM_AI_ENABLED=1

echo "✅ NVM AI enabled!"
echo ""

# Show AI configuration
echo "📋 Current AI Configuration:"
nvm ai config
echo ""

# Create a sample project for testing
echo "🏗️  Creating sample project for AI analysis..."
mkdir -p /tmp/nvm-ai-demo
cd /tmp/nvm-ai-demo

# Create package.json for a Next.js project
cat > package.json << 'EOF'
{
  "name": "nvm-ai-demo",
  "version": "1.0.0",
  "description": "Demo project for NVM AI testing",
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start"
  },
  "dependencies": {
    "next": "^14.0.0",
    "react": "^18.0.0",
    "react-dom": "^18.0.0"
  },
  "devDependencies": {
    "@types/node": "^20.0.0",
    "@types/react": "^18.0.0",
    "typescript": "^5.0.0",
    "eslint": "^8.0.0",
    "prettier": "^3.0.0"
  },
  "engines": {
    "node": ">=18.17.0"
  }
}
EOF

echo "✅ Sample Next.js project created!"
echo ""

# Test AI project analysis
echo "🔍 Running AI project analysis..."
nvm ai analyze
echo ""

# Test AI version recommendation
echo "🎯 Getting AI version recommendation..."
recommended_version=$(nvm ai recommend)
echo "💡 AI recommends: Node.js ${recommended_version}"
echo ""

# Test AI installation (without actually installing)
echo "🤖 AI Installation capabilities:"
echo "   Command: nvm ai install ${recommended_version}"
echo "   This would:"
echo "   • Download and install Node.js ${recommended_version}"
echo "   • Apply AI optimizations"
echo "   • Set up the project automatically"
echo "   • Run security checks"
echo "   • Install recommended global packages"
echo ""

# Test AI security scan
echo "🛡️  Running AI security scan..."
nvm ai security
echo ""

# Show AI statistics
echo "📊 AI Usage Statistics:"
nvm ai stats 2>/dev/null || echo "   No usage data available yet"
echo ""

# Demonstrate AI help
echo "📚 AI Help System:"
nvm ai help
echo ""

# Cleanup
echo "🧹 Cleaning up demo..."
cd /
rm -rf /tmp/nvm-ai-demo

echo ""
echo "🎉 NVM AI Super Intelligence Demo Complete!"
echo ""
echo "Key Features Demonstrated:"
echo "• 🧠 Intelligent project analysis"
echo "• 🎯 AI-powered version recommendations"
echo "• 🤖 Smart installation with optimizations"
echo "• 🛡️  Security vulnerability scanning"
echo "• 📊 Usage analytics and learning"
echo "• ⚡ Performance optimizations"
echo "• 🏗️  Automated project setup"
echo ""
echo "To get started with NVM AI:"
echo "1. Set NVM_AI_ENABLED=1 in your shell profile"
echo "2. Run 'nvm ai help' for all available commands"
echo "3. Use 'nvm ai recommend' to get intelligent version suggestions"
echo "4. Try 'nvm ai install' for AI-powered installations"
echo ""
echo "🚀 Happy coding with AI-powered Node.js management!"
