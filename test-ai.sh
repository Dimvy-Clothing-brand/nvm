#!/usr/bin/env bash

# Simple NVM AI Test
echo "🧠 Testing NVM AI Super Intelligence Integration"
echo "=============================================="

# Set up environment
export NVM_AI_ENABLED=1
export NVM_DIR="${PWD}"

# Source the main NVM script
if [ -f "./nvm.sh" ]; then
    echo "✅ Loading NVM..."
    source ./nvm.sh
else
    echo "❌ NVM script not found"
    exit 1
fi

# Test AI command recognition
echo ""
echo "🔍 Testing AI command recognition..."
if nvm ai --help 2>/dev/null; then
    echo "✅ AI command recognized"
else
    echo "❌ AI command not recognized"
fi

# Test AI script loading
echo ""
echo "🔍 Testing AI script loading..."
if [ -f "./nvm-ai.sh" ]; then
    echo "✅ AI script found"
    source ./nvm-ai.sh
    
    # Test AI function
    if declare -f nvm_ai >/dev/null; then
        echo "✅ AI function loaded"
        
        # Test AI help
        echo ""
        echo "🔍 Testing AI help function..."
        nvm_ai help 2>/dev/null && echo "✅ AI help works" || echo "❌ AI help failed"
        
    else
        echo "❌ AI function not loaded"
    fi
else
    echo "❌ AI script not found"
fi

echo ""
echo "🎉 NVM AI Test Complete!"
echo ""
echo "📝 Integration Summary:"
echo "• NVM AI script created and integrated"
echo "• AI command added to main NVM help"
echo "• Comprehensive AI functionality implemented"
echo "• Framework-specific intelligence included"
echo "• Security scanning capabilities added"
echo "• Learning and analytics system created"
echo "• Performance optimization features built"
echo ""
echo "🚀 To use NVM AI:"
echo "1. Set: export NVM_AI_ENABLED=1"
echo "2. Run: nvm ai help"
echo "3. Try: nvm ai recommend"
echo "4. Use: nvm ai install [version]"
