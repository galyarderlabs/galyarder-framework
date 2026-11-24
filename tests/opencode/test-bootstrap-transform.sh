#!/usr/bin/env bash
# Test: OpenCode bootstrap transform
# Verifies the plugin's experimental.chat.messages.transform hook injects the
# using-forge-anything bootstrap into the first user message, exactly once.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Test: OpenCode bootstrap transform ==="

if ! command -v node >/dev/null 2>&1; then
    echo "  [SKIP] node not on PATH"
    exit 0
fi

if node --test "$SCRIPT_DIR/test-bootstrap-transform.mjs" 2>&1; then
    echo "  [PASS] Bootstrap transform injects once, from the skill body"
else
    echo "  [FAIL] Bootstrap transform test failed"
    exit 1
fi

echo ""
echo "=== Bootstrap transform tests passed ==="
