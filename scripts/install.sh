#!/usr/bin/env bash
# Usage:
#   ./scripts/install.sh [--tool <name>] [--target <dir>] [--help]
#
# Tools: forge-agent, all
# Default: all
#
# Forge Agent is the only target installed from generated copies
# (integrations/forge-agent/). Every other harness (Claude Code, OMP/Pi,
# Codex, Cursor, Antigravity, OpenCode, Copilot CLI, Hermes) is served by
# its native plugin manifest, which reads the canonical skills/, agents/,
# and commands/ directories directly. Passing one of those as --tool prints
# its native plugin install command instead of copying files.

set -euo pipefail

# HARDENED PATH RESOLUTION: Trace symlinks to the real framework source
REAL_PATH=$(readlink -f "$0")
SCRIPT_DIR="$(cd "$(dirname "$REAL_PATH")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

TOOL="all"
TARGET_DIR=""

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

ok() { echo -e "${GREEN}[OK]${NC} $*"; }
warn() { echo -e "${YELLOW}[!!]${NC} $*"; }
err() { echo -e "${RED}[ERR]${NC} $*" >&2; }
info() { echo -e "${BLUE}[*]${NC} $*"; }

usage() {
  cat <<'USAGE'
Usage:
  ./scripts/install.sh [--tool <name>] [--target <dir>] [--help]

Tools:
  forge-agent, all

Other harnesses (claude-code, codex, cursor, antigravity, opencode,
omp/pi, copilot, hermes) are installed through their native plugin
manager, not through this script. Pass one as --tool to print its
native plugin install command.

Defaults:
  --tool all
USAGE
}

print_plugin_install() {
  local t="$1"
  case "$t" in
    claude-code|copilot|copilot-cli)
      info "Claude Code / Copilot CLI use the native plugin. Install it from the marketplace:"
      echo "  /plugin marketplace add galyarderlabs/forge-anything"
      echo "  /plugin install forge-anything@galyarderlabs-marketplace"
      echo "See docs/INTEGRATION.md for details." ;;
    hermes)
      info "Hermes uses the native plugin. Install it with:"
      echo "  hermes plugins install galyarderlabs/forge-anything --enable"
      echo "Restart any active Hermes sessions after installing. See docs/INTEGRATION.md." ;;
    codex)
      info "Codex uses the native plugin (.codex-plugin/plugin.json); it reads the root skills/ directly."
      echo "See docs/INTEGRATION.md for the install steps." ;;
    cursor)
      info "Cursor uses the native plugin (portable root plugin.json)."
      echo "See docs/INTEGRATION.md for the install steps." ;;
    antigravity)
      info "Antigravity uses the native plugin (.antigravity-plugin/plugin.json)."
      echo "See docs/INTEGRATION.md for the install steps." ;;
    opencode)
      info "OpenCode uses the native plugin (.opencode/plugins/forge-anything.js)."
      echo "See docs/INTEGRATION.md for the install steps." ;;
    omp|pi)
      info "OMP/Pi uses the native Pi extension (.pi/extensions/forge-anything.ts)."
      echo "See docs/INTEGRATION.md for the install steps." ;;
  esac
}

is_plugin_tool() {
  case "$1" in
    claude-code|codex|cursor|antigravity|opencode|omp|pi|copilot|copilot-cli|hermes) return 0 ;;
    *) return 1 ;;
  esac
}

is_valid_tool() {
  case "$1" in
    forge-agent|all) return 0 ;;
    *) return 1 ;;
  esac
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --tool) TOOL="${2:-}"; shift 2 ;;
    --target) TARGET_DIR="${2:-}"; shift 2 ;;
    --help|-h) usage; exit 0 ;;
    *) err "Unknown argument: $1"; usage; exit 1 ;;
  esac
done

# Plugin-covered harnesses: print the native install command, install nothing.
if is_plugin_tool "$TOOL"; then
  print_plugin_install "$TOOL"
  exit 0
fi

if ! is_valid_tool "$TOOL"; then err "Invalid --tool: ${TOOL}"; usage; exit 1; fi

# 1. Run Conversion (Point to the absolute path of sibling script)
info "Running Forge Anything conversion engine..."
"${SCRIPT_DIR}/convert.sh" --tool forge-agent

info "Installing for forge-agent..."
SRC_DIR="${REPO_ROOT}/integrations/forge-agent"

if [ ! -d "$SRC_DIR" ]; then
    warn "Source directory for forge-agent missing. Skipping."
    exit 1
fi

DEST="${HOME}/.g-agent/skills"
mkdir -p "$DEST"
# Surgical overwrite to prevent dir-vs-file conflicts
for item in "${SRC_DIR}/skills/"*; do
    [ -e "$item" ] || continue
    name=$(basename "$item")
    rm -rf "${DEST}/${name}"
    cp -R "$item" "${DEST}/"
done
ok "Installed Forge Agent skills to ${DEST}."

ok "Forge Anything installation process complete."
