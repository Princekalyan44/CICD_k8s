#!/bin/bash

# Pre-commit setup script for CICD_k8s project
# Run this script to install and configure pre-commit hooks

set -e

echo "========================================"
echo "Pre-commit Hooks Installation Script"
echo "========================================"
echo ""

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 is not installed. Please install Python3 first."
    echo "   Ubuntu/Debian: sudo apt install python3 python3-pip"
    exit 1
fi

echo "✅ Python3 found: $(python3 --version)"
echo ""

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    echo "❌ pip3 is not installed. Installing pip3..."
    sudo apt install python3-pip -y
fi

echo "✅ pip3 found"
echo ""

# Install pre-commit
echo "📦 Installing pre-commit framework..."
pip3 install pre-commit --user

# Add to PATH if needed
if ! command -v pre-commit &> /dev/null; then
    export PATH="$HOME/.local/bin:$PATH"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    echo "✅ Added pre-commit to PATH"
fi

echo "✅ pre-commit installed: $(pre-commit --version)"
echo ""

# Initialize secrets baseline
echo "🔐 Creating secrets baseline..."
if [ ! -f ".secrets.baseline" ]; then
    detect-secrets scan > .secrets.baseline 2>/dev/null || echo '{}' > .secrets.baseline
    echo "✅ Secrets baseline created"
else
    echo "✅ Secrets baseline already exists"
fi
echo ""

# Install pre-commit hooks
echo "🔧 Installing pre-commit hooks to .git/hooks/..."
pre-commit install

echo "✅ Pre-commit hooks installed successfully!"
echo ""

# Install hook dependencies
echo "📥 Installing hook dependencies (this may take a minute)..."
pre-commit install-hooks

echo "✅ Hook dependencies installed!"
echo ""

# Test the setup
echo "🧪 Testing pre-commit setup..."
echo "Running pre-commit on all files..."
echo ""

pre-commit run --all-files || true

echo ""
echo "========================================"
echo "✅ Pre-commit Setup Complete!"
echo "========================================"
echo ""
echo "Usage:"
echo "  • Hooks run automatically on 'git commit'"
echo "  • Skip hooks: git commit --no-verify"
echo "  • Run manually: pre-commit run --all-files"
echo "  • Update hooks: pre-commit autoupdate"
echo ""
echo "Next steps:"
echo "  1. Make some changes to your code"
echo "  2. Run: git add ."
echo "  3. Run: git commit -m 'your message'"
echo "  4. Watch pre-commit hooks run automatically!"
echo ""