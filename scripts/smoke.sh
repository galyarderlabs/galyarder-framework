#!/bin/bash
# Galyarder Framework: Audit-Grade Smoke Test
# Verifies canonical runtime integrity, manifest parity, and structural health.
set -euo pipefail

echo "🚀 Starting Galyarder Smoke Test..."

# Detect if we are in the Framework Source or a Project HQ.
IS_SOURCE=false
if [ -f "gemini-extension.json" ] && [ -d "agents" ] && [ -d "skills" ] && [ -d "commands" ]; then
    IS_SOURCE=true
    echo "[*] Detected: Galyarder Framework Source Environment"
else
    echo "[*] Detected: Target Project Environment"
fi

# 1. Structural Verification
echo "[1/8] Verifying Runtime Integrity..."
if [ "$IS_SOURCE" = true ]; then
    RUNTIME_DIRS=("agents" "skills" "commands" "integrations")
    for dir in "${RUNTIME_DIRS[@]}"; do
        if [ ! -d "$dir" ]; then
            echo "❌ Error: Canonical runtime directory '$dir' is missing in source."
            exit 1
        fi
    done
    if [ ! -f "AGENTS.md" ] || [ ! -f "CLAUDE.md" ] || [ ! -f "GEMINI.md" ]; then
        echo "❌ Error: Root boot files are missing."
        exit 1
    fi
    echo "✅ Canonical root runtime surface is present."
else
    DEPARTMENTS=("Executive" "Product" "Engineering" "Growth" "Security" "Infrastructure" "Legal-Finance" "Knowledge")
    for dept in "${DEPARTMENTS[@]}"; do
        if [ ! -d "docs/departments/$dept" ]; then
            echo "❌ Error: Digital HQ Department '$dept' is missing in project."
            exit 1
        fi
    done
    echo "✅ All ${#DEPARTMENTS[@]} Digital HQ departments accounted for."
fi

# 2. Path & Script Awareness
echo "[2/8] Verifying CLI Accessibility..."
if command -v galyarder >/dev/null 2>&1; then
    echo "✅ CLI command is reachable."
else
    echo "⚠️ Warning: 'galyarder' not in PATH."
fi

# 3. Documentation/HQ Readiness
echo "[3/8] Checking Workspace Maturity..."
if [ -d "docs/departments" ]; then
    echo "✅ Digital HQ structure exists."
else
    echo "⚠️ Warning: Digital HQ not initialized. Run 'galyarder scaffold'."
fi

# 4. Framework Source specific checks
if [ "$IS_SOURCE" = true ]; then
    echo "[4/8] Verifying Manifest Parity..."
    ROOT_VERSION=$(python3 - <<'PY'
import json
print(json.load(open('gemini-extension.json'))['version'])
PY
)
    MARKETPLACE_VERSION=$(python3 - <<'PY'
import json
print(json.load(open('.claude-plugin/marketplace.json'))['metadata']['version'])
PY
)
    if [ "$ROOT_VERSION" != "$MARKETPLACE_VERSION" ]; then
        echo "❌ Error: Version mismatch ($ROOT_VERSION != $MARKETPLACE_VERSION)"
        exit 1
    fi
    echo "✅ Versioning locked at v${ROOT_VERSION}."

    echo "[5/8] Checking monolith-free boot policy..."
    if [ -e "CONVENTIONS.md" ] || [ -e "docs/CONVENTIONS.md" ] || [ -e "integrations/aider" ]; then
        echo "❌ Error: Monolithic CONVENTIONS/Aider artifacts must not exist in the framework runtime surface."
        exit 1
    fi
    if grep -n '@CONVENTIONS\.md' CLAUDE.md GEMINI.md >/tmp/galyarder-eager-conventions.txt; then
        cat /tmp/galyarder-eager-conventions.txt
        echo "❌ Error: Root boot files must not reference CONVENTIONS.md."
        exit 1
    fi
    echo "✅ Root boot is canonical-runtime scoped and monolith-free."

    echo "[6/8] Checking lazy Neural Link policy..."
    if grep -R -n -E --exclude='graph.json' --exclude='smoke.sh' \
        'Check the Map First|God Nodes|MUST read `docs/graph\.json`' \
        agents skills commands scripts docs integrations \
        >/tmp/galyarder-mandatory-graph.txt; then
        sed -n '1,40p' /tmp/galyarder-mandatory-graph.txt
        echo "❌ Error: Neural Link/World-Map access must be lazy, not mandatory for normal execution."
        exit 1
    fi
    echo "✅ Neural Link lookup is lazy."

    echo "[7/8] Checking for broken symlinks..."
    BROKEN_LINKS=$(find . -path './.git' -prune -o -xtype l -print)
    if [ -n "$BROKEN_LINKS" ]; then
        echo "$BROKEN_LINKS" | sed -n '1,40p'
        echo "❌ Error: Broken symlinks detected. Remove legacy nested skill links."
        exit 1
    fi
    echo "✅ No broken symlinks detected."

    echo "[8/8] Checking canonical marketplace manifest..."
    python3 - <<'PY'
import json
from pathlib import Path
manifest = json.load(open('.claude-plugin/marketplace.json'))
plugins = manifest.get('plugins', [])
if len(plugins) != 1:
    raise SystemExit(f"Marketplace must expose one canonical root plugin, found {len(plugins)}")
plugin = plugins[0]
if plugin.get('name') != 'galyarder-framework':
    raise SystemExit("Marketplace plugin name must be galyarder-framework")
source = plugin.get('source')
if source not in ('.', './'):
    raise SystemExit(f"Marketplace source must point at canonical repo root, got {source!r}")
for required in ('agents', 'skills', 'commands'):
    if not Path(required).is_dir():
        raise SystemExit(f"Canonical marketplace source is missing {required}/")
PY
    echo "✅ Marketplace points at the canonical root runtime."
else
    echo "[4/4] Target project check complete."
fi

echo "---"
echo "✅ SMOKE TEST PASSED: Environment is operational."
