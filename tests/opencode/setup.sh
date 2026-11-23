#!/usr/bin/env bash
# Setup script for OpenCode plugin tests
# Creates an isolated test environment with proper plugin installation
set -euo pipefail

# Get the repository root (two levels up from tests/opencode/)
REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

# Create temp home directory for isolation
export TEST_HOME
TEST_HOME=$(mktemp -d)
export HOME="$TEST_HOME"
export XDG_CONFIG_HOME="$TEST_HOME/.config"
export OPENCODE_CONFIG_DIR="$TEST_HOME/.config/opencode"

# Standard install layout:
#   $OPENCODE_CONFIG_DIR/              package root
#   $OPENCODE_CONFIG_DIR/skills/       skills dir (../../skills from plugin)
#   $OPENCODE_CONFIG_DIR/.opencode/plugins/forge-anything.js  plugin file
#   $OPENCODE_CONFIG_DIR/plugins/forge-anything.js    symlink OpenCode reads

FORGE_DIR="$OPENCODE_CONFIG_DIR/forge-anything"
FORGE_SKILLS_DIR="$FORGE_DIR/skills"
FORGE_PLUGIN_FILE="$FORGE_DIR/.opencode/plugins/forge-anything.js"

# Install skills
mkdir -p "$FORGE_DIR"
cp -r "$REPO_ROOT/skills" "$FORGE_DIR/"

# Install plugin
mkdir -p "$(dirname "$FORGE_PLUGIN_FILE")"
cp "$REPO_ROOT/.opencode/plugins/forge-anything.js" "$FORGE_PLUGIN_FILE"

# Register plugin via symlink (what OpenCode actually reads)
mkdir -p "$OPENCODE_CONFIG_DIR/plugins"
ln -sf "$FORGE_PLUGIN_FILE" "$OPENCODE_CONFIG_DIR/plugins/forge-anything.js"

# Create test skills in different locations for testing

# Personal test skill
mkdir -p "$OPENCODE_CONFIG_DIR/skills/personal-test"
cat > "$OPENCODE_CONFIG_DIR/skills/personal-test/SKILL.md" <<'EOF'
---
name: personal-test
description: Test personal skill for verification
---
# Personal Test Skill

This is a personal skill used for testing.

PERSONAL_SKILL_MARKER_12345
EOF

# Create a project directory for project-level skill tests
mkdir -p "$TEST_HOME/test-project/.opencode/skills/project-test"
cat > "$TEST_HOME/test-project/.opencode/skills/project-test/SKILL.md" <<'EOF'
---
name: project-test
description: Test project skill for verification
---
# Project Test Skill

This is a project skill used for testing.

PROJECT_SKILL_MARKER_67890
EOF

echo "Setup complete: $TEST_HOME"
echo "OPENCODE_CONFIG_DIR:  $OPENCODE_CONFIG_DIR"
echo "Forge Anything dir:      $FORGE_DIR"
echo "Skills dir:           $FORGE_SKILLS_DIR"
echo "Plugin file:          $FORGE_PLUGIN_FILE"
echo "Plugin registered at: $OPENCODE_CONFIG_DIR/plugins/forge-anything.js"
echo "Test project at:      $TEST_HOME/test-project"

# Helper function for cleanup (call from tests or trap)
cleanup_test_env() {
    if [ -n "${TEST_HOME:-}" ] && [ -d "$TEST_HOME" ]; then
        rm -rf "$TEST_HOME"
    fi
}

# Export for use in tests
export -f cleanup_test_env
export REPO_ROOT
export FORGE_DIR
export FORGE_SKILLS_DIR
export FORGE_PLUGIN_FILE
