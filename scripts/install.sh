#!/usr/bin/env bash
# Usage:
#   ./scripts/install.sh [--tool <name>] [--target <dir>] [--help]
#
# Tools: antigravity, cursor, kilocode, windsurf, opencode, augment, claude-code, codex, gemini, openclaw, hermes, galyarder-agent, all
# Default: all

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
  antigravity, cursor, kilocode, windsurf, opencode, augment, claude-code, codex, gemini, openclaw, hermes, galyarder-agent, all

Defaults:
  --tool all
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --tool) TOOL="${2:-}"; shift 2 ;;
    --target) TARGET_DIR="${2:-}"; shift 2 ;;
    --help|-h) usage; exit 0 ;;
    *) err "Unknown argument: $1"; usage; exit 1 ;;
  esac
done

# 1. Run Conversion (Point to the absolute path of sibling script)
info "Running Galyarder Framework conversion engine..."
"${SCRIPT_DIR}/convert.sh" --tool "$TOOL"

TOOLS="antigravity cursor kilocode windsurf opencode augment claude-code codex gemini openclaw hermes galyarder-agent"
[[ "$TOOL" != "all" ]] && TOOLS="$TOOL"

for t in $TOOLS; do
    info "Installing for ${t}..."
    SRC_DIR="${REPO_ROOT}/integrations/${t}"
    
    if [ ! -d "$SRC_DIR" ]; then
        warn "Source directory for ${t} missing. Skipping."
        continue
    fi

    case "$t" in
        antigravity)
            DEST="${HOME}/.gemini/antigravity/skills"
            mkdir -p "$DEST"
            # Surgical overwrite to prevent dir-vs-file conflicts
            for item in "${SRC_DIR}/"*; do
                [ -e "$item" ] || continue
                name=$(basename "$item")
                rm -rf "${DEST}/${name}"
                cp -R "$item" "${DEST}/"
            done
            ok "Linked skills to Antigravity global directory." ;;
        galyarder-agent)
            DEST="${HOME}/.g-agent/skills"
            mkdir -p "$DEST"
            # Surgical overwrite to prevent dir-vs-file conflicts
            for item in "${SRC_DIR}/skills/"*; do
                [ -e "$item" ] || continue
                name=$(basename "$item")
                rm -rf "${DEST}/${name}"
                cp -R "$item" "${DEST}/"
            done
            ok "Installed Galyarder Agent skills to ${DEST}." ;;
        cursor)
            if [ -n "$TARGET_DIR" ]; then
                mkdir -p "${TARGET_DIR}/.cursor/rules"
                cp "${SRC_DIR}/rules/"*.mdc "${TARGET_DIR}/.cursor/rules/"
                ok "Installed Cursor rules to ${TARGET_DIR}."
            else
                warn "No --target provided for Cursor. Rules available at integrations/cursor/rules/"
            fi ;;
        windsurf)
            DEST="${HOME}/.windsurf/skills"
            mkdir -p "$DEST"
            for item in "${SRC_DIR}/skills/"*; do
                [ -e "$item" ] || continue
                name=$(basename "$item")
                rm -rf "${DEST}/${name}"
                cp -R "$item" "${DEST}/"
            done
            ok "Installed Windsurf skills to ${DEST}." ;;
        gemini)
            if [ -n "$TARGET_DIR" ]; then
                DEST="${TARGET_DIR}/.gemini/skills"
            else
                DEST="${HOME}/.gemini/skills"
            fi
            mkdir -p "$DEST"
            for item in "${SRC_DIR}/skills/"*; do
                [ -e "$item" ] || continue
                name=$(basename "$item")
                rm -rf "${DEST}/${name}"
                cp -R "$item" "${DEST}/"
            done
            ok "Installed Gemini skills to ${DEST}."
            ;;
        opencode)
            DEST="${HOME}/.opencode/plugins"
            mkdir -p "$DEST"
            for item in "${SRC_DIR}/skills/"*; do
                [ -e "$item" ] || continue
                name=$(basename "$item")
                rm -rf "${DEST}/${name}"
                cp -R "$item" "${DEST}/"
            done
            ok "Installed OpenCode skills to ${DEST}." ;;
        claude-code)
            DEST="${HOME}/.claude/agents"
            mkdir -p "$DEST"
            cp "${SRC_DIR}/"* "$DEST/" 2>/dev/null || true
            ok "Installed Claude Code agents to ${DEST}." ;;
        *)
            info "Skipping automated system install for ${t}. Assets available in integrations/${t}/" ;;
    esac
done

ok "Galyarder Framework installation process complete."
