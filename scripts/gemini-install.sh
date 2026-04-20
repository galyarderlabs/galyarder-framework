#!/bin/bash
#
# Gemini CLI Installation Script for Galyarder Framework Library
#
# Sets up the workspace for Gemini CLI by generating symlinks and an index.
#
# Usage:
#   ./scripts/gemini-install.sh [--dry-run]
#

set -e

# Configuration
# HARDENED PATH RESOLUTION: Trace symlinks to the real framework source
REAL_PATH=$(readlink -f "${BASH_SOURCE[0]}")
SCRIPT_DIR="$(cd "$(dirname "$REAL_PATH")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
GEMINI_SYNC_SCRIPT="$SCRIPT_DIR/sync-gemini-skills.py"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

... (38 more lines, 1679 bytes total)
