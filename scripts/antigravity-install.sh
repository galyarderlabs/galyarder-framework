#!/usr/bin/env bash
# Install galyarder-framework skills into Antigravity's global skills directory
# Usage: ./scripts/antigravity-install.sh

set -euo pipefail

SKILLS_DIR="${HOME}/.gemini/antigravity/skills"
# HARDENED PATH RESOLUTION: Trace symlinks to the real framework source
REAL_PATH=$(readlink -f "$0")
SCRIPT_DIR="$(cd "$(dirname "$REAL_PATH")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "Installing Galyarder Framework Workforce into Antigravity..."

# Find all SKILL.md files and install each skill
installed=0

while IFS= read -r skill_md; do
  skill_dir="$(dirname "$skill_md")"
  skill_name="$(basename "$skill_dir")"
  target="${SKILLS_DIR}/${skill_name}"

  mkdir -p "$SKILLS_DIR"
  ln -sf "$skill_dir" "$target"
  # echo "   installed: $skill_name"
  installed=$((installed + 1))
done < <(find "$REPO_DIR/skills" -name "SKILL.md" -not -path "*/.git/*")

echo "Done. Installed $installed skill(s) into Antigravity."
echo "Antigravity now has direct access to the Galyarder Framework Workforce."
