#!/bin/bash

# Forge Anything: CLI Setup
# Purpose: Build the Rust forge CLI and link it (plus the framework scripts)
# to a global PATH for effortless cross-project use.

set -e

# Determine the ABSOLUTE path of the framework root
# This logic traces back to the real directory even if run via path
REAL_PATH=$(readlink -f "$0")
FRAMEWORK_DIR="$(cd "$(dirname "$REAL_PATH")/.." && pwd)"
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

echo "Linking Forge Anything to global PATH..."

# Build the Rust CLI (no external dependencies, so this works offline),
# then link the release binary. cargo is usually on PATH after a rustup
# install; fall back to the standard rustup location if it is not.
if ! command -v cargo >/dev/null 2>&1; then
    if [ -x "$HOME/.cargo/bin/cargo" ]; then
        export PATH="$HOME/.cargo/bin:$PATH"
    else
        echo "[!] cargo is required to build the forge CLI. Install Rust: https://rustup.rs" >&2
        exit 1
    fi
fi
cargo build --release --locked --manifest-path "$FRAMEWORK_DIR/crates/forge/Cargo.toml"
ln -sf "$FRAMEWORK_DIR/crates/forge/target/release/forge" "$BIN_DIR/forge"

# Direct script shortcut (the forge CLI delegates to this same script).
ln -sf "$FRAMEWORK_DIR/scripts/smoke.sh" "$BIN_DIR/f-smoke"

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
        echo "# Forge Anything CLI" >> "$RC_FILE"
        echo "export PATH=\"\$PATH:$BIN_DIR\"" >> "$RC_FILE"
        echo "Path added. Please run: source $RC_FILE"
    else
        echo "Please add 'export PATH=\"\$PATH:$BIN_DIR\"' to your shell configuration manually."
    fi
else
    echo "Forge CLI is already in your PATH."
fi

echo "---"
echo "CLI Setup Complete."
echo "Commands now available globally:"
echo "  - forge <cmd> : Main Forge Anything CLI (Rust)"
echo "  - forge scaffold  : Initialize a new Forge Anything project"
echo "  - f-smoke         : Verify system integrity"
