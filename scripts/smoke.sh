#!/bin/bash
# Forge Anything: Audit-Grade Smoke Test
# Verifies canonical runtime integrity, manifest parity, and structural health.
set -euo pipefail

# HARDENED PATH RESOLUTION: Trace symlinks to the real framework source
REAL_PATH=$(readlink -f "$0")
SCRIPT_DIR="$(cd "$(dirname "$REAL_PATH")" && pwd)"
cd "$SCRIPT_DIR/.." || exit 1

echo "🚀 Starting Forge Smoke Test..."

# Detect if we are in the Framework Source or a Project HQ.
IS_SOURCE=false
if [ -f "plugin.json" ] && [ -d "agents" ] && [ -d "skills" ] && [ -d "commands" ]; then
    IS_SOURCE=true
    echo "[*] Detected: Forge Anything Source Environment"
else
    echo "[*] Detected: Target Project Environment"
fi

# 1. Structural Verification
echo "[1/8] Verifying Runtime Integrity..."
if [ "$IS_SOURCE" = true ]; then
    RUNTIME_DIRS=("agents" "skills" "commands")
    for dir in "${RUNTIME_DIRS[@]}"; do
        if [ ! -d "$dir" ]; then
            echo "❌ Error: Canonical runtime directory '$dir' is missing in source."
            exit 1
        fi
    done
    if [ ! -f "AGENTS.md" ]; then
        echo "❌ Error: Root boot file AGENTS.md is missing."
        exit 1
    fi
    echo "✅ Canonical root runtime surface is present."
else
    DEPARTMENTS=("Executive" "Product" "Engineering" "Growth" "Security" "Infrastructure" "Legal-Finance" "Knowledge")
    for dept in "${DEPARTMENTS[@]}"; do
        if [ ! -d "docs/departments/$dept" ]; then
            echo "❌ Error: Intelligence Layer Department '$dept' is missing in project."
            exit 1
        fi
    done
    echo "✅ All ${#DEPARTMENTS[@]} Intelligence Layer departments accounted for."
fi

# 2. Path & Script Awareness
echo "[2/8] Verifying CLI Accessibility..."
if command -v forge >/dev/null 2>&1; then
    echo "✅ CLI command is reachable."
else
    echo "⚠️ Warning: 'forge' not in PATH."
fi

# 3. Documentation/HQ Readiness
echo "[3/8] Checking Workspace Maturity..."
if [ -d "docs/departments" ]; then
    echo "✅ Intelligence Layer structure exists."
else
    echo "⚠️ Warning: Intelligence Layer not initialized. Run 'forge scaffold'."
fi

# 4. Framework Source specific checks
if [ "$IS_SOURCE" = true ]; then
    echo "[4/8] Verifying Manifest Parity..."
    python3 - <<'PY'
import json
import re
import sys
from pathlib import Path

package_version = json.load(open('package.json'))['version']

# Every manifest version must equal package.json. Comparing manifests
# against each other is not enough: two stale manifests agree with each
# other and the drift goes unnoticed.
checks = [
    ('plugin.json', lambda d: [d['version']]),
    ('.claude-plugin/plugin.json', lambda d: [d['version']]),
    ('.codex-plugin/plugin.json', lambda d: [d['version']]),
    ('.antigravity-plugin/plugin.json', lambda d: [d['version']]),
    ('.claude-plugin/marketplace.json',
     lambda d: [d['metadata']['version']] + [p['version'] for p in d.get('plugins', [])]),
]
failed = False
for rel, extract in checks:
    data = json.load(open(rel))
    for version in extract(data):
        status = "OK" if version == package_version else "MISMATCH"
        print(f"  {rel}: {version} ({status})")
        if version != package_version:
            failed = True

yaml_text = Path('.hermes-plugin/plugin.yaml').read_text()
match = re.search(r'^version:\s*(.+)$', yaml_text, re.MULTILINE)
yaml_version = match.group(1).strip() if match else None
status = "OK" if yaml_version == package_version else "MISMATCH"
print(f"  .hermes-plugin/plugin.yaml: {yaml_version} ({status})")
if yaml_version != package_version:
    failed = True

if failed:
    print(f"❌ Error: Manifest versions must all equal package.json v{package_version}.")
    print("Run `python3 scripts/sync-plugin-version.py` to re-sync.")
    sys.exit(1)
print(f"✅ All manifest versions locked at v{package_version}.")
PY

    echo "[5/8] Checking monolith-free boot policy..."
    if [ -e "CONVENTIONS.md" ] || [ -e "docs/CONVENTIONS.md" ]; then
        echo "❌ Error: Monolithic CONVENTIONS artifacts must not exist in the framework runtime surface."
        exit 1
    fi
    echo "✅ Root boot is canonical-runtime scoped and monolith-free."

    echo "[6/8] Checking lazy Neural Link policy..."
    if grep -R -n -E --exclude='graph.json' --exclude='smoke.sh' \
        'Check the Map First|God Nodes|MUST read `docs/graph\.json`' \
        agents skills commands scripts docs \
        >/tmp/forge-mandatory-graph.txt; then
        sed -n '1,40p' /tmp/forge-mandatory-graph.txt
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
if plugin.get('name') not in ('forge-anything', '@galyarderlabs/forge-anything'):
    raise SystemExit("Marketplace plugin name must be forge-anything or @galyarderlabs/forge-anything")
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
