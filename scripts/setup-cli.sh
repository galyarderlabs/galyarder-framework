#!/bin/bash

# Galyarder Framework: CLI Setup
# Purpose: Link framework scripts to a global PATH for effortless cross-project use.

set -e

# Determine the ABSOLUTE path of the framework root
# This logic traces back to the real directory even if run via path
REAL_PATH=$(readlink -f "$0")
FRAMEWORK_DIR="$(cd "$(dirname "$REAL_PATH")/.." && pwd)"
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

echo "🚀 Linking Galyarder Framework to global PATH..."

# Create symbolic links with absolute paths to the source repo
ln -sf "$FRAMEWORK_DIR/bin/galyarder.js" "$BIN_DIR/galyarder"
ln -sf "$FRAMEWORK_DIR/scripts/scaffold-company.sh" "$BIN_DIR/g-scaffold"
ln -sf "$FRAMEWORK_DIR/scripts/install.sh" "$BIN_DIR/g-deploy"
ln -sf "$FRAMEWORK_DIR/scripts/smoke.sh" "$BIN_DIR/g-smoke"
ln -sf "$FRAMEWORK_DIR/scripts/convert.sh" "$BIN_DIR/g-convert"

# Hidden internal link used by install.sh
ln -sf "$FRAMEWORK_DIR/scripts/convert.sh" "$BIN_DIR/convert.sh"

# Verify PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo "[!] Warning: $BIN_DIR is not in your PATH."
    
    SHELL_NAME=$(basename "$SHELL")
    RC_FILE=""
    if [[ "$SHELL_NAME" == "zsh" ]]; then
        RC_FILE="$HOME/.zshrc"
    elif [[ "$SHELL_NAME" == "bash" ]]; then
        RC_FILE="$HOME/.bashrc"
    fi

    if [ -n "$RC_FILE" ]; then
        echo "[*] Adding $BIN_DIR to $RC_FILE..."
        echo "" >> "$RC_FILE"
        echo "# Galyarder Framework CLI" >> "$RC_FILE"
        echo "export PATH=\"\$PATH:$BIN_DIR\"" >> "$RC_FILE"
        echo "✅ Path added. Please run: source $RC_FILE"
    else
        echo "Please add 'export PATH=\"\$PATH:$BIN_DIR\"' to your shell configuration manually."
    fi
else
    echo "✅ Galyarder CLI is already in your PATH."
fi

echo "---"
echo "✅ CLI Setup Complete."
echo "Commands now available globally:"
echo "  - galyarder <cmd> : Main Framework CLI (Recommended)"
echo "  - g-scaffold      : Initialize Digital HQ"
echo "  - g-deploy        : Deploy agents to your IDE/Host"
echo "  - g-smoke         : Verify system integrity"
