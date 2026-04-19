#!/bin/bash
# Galyarder Framework: Audit-Grade Smoke Test
# Verifies system integrity, version parity, and structural health.

set -e

echo "🚀 Starting Galyarder Smoke Test..."

# Detect if we are in the Framework Source or a Project HQ
IS_SOURCE=false
if [ -f "gemini-extension.json" ] && [ -d "Engineering" ]; then
    IS_SOURCE=true
    echo "[*] Detected: Galyarder Framework Source Environment"
else
    echo "[*] Detected: Target Project Environment"
fi

# 1. Structural Verification
echo "[1/8] Verifying Departmental Integrity..."
DEPARTMENTS=("Executive" "Product" "Engineering" "Growth" "Security" "Infrastructure" "Legal-Finance" "Knowledge")

if [ "$IS_SOURCE" = true ]; then
    # In Source: Check root folders
    for dept in "${DEPARTMENTS[@]}"; do
        if [ ! -d "$dept" ]; then
            echo "❌ Error: Department Silo '$dept' is missing in source."
            exit 1
        fi
    done
else
    # In Project: Check docs/departments/
    for dept in "${DEPARTMENTS[@]}"; do
        if [ ! -d "docs/departments/$dept" ]; then
            echo "❌ Error: Digital HQ Department '$dept' is missing in project."
            exit 1
        fi
    done
fi
echo "✅ All ${#DEPARTMENTS[@]} Departments accounted for."

# 2. Path & Script Awareness
echo "[2/8] Verifying CLI Accessibility..."
if command -v galyarder-scaffold >/dev/null 2>&1; then
    echo "✅ CLI commands are reachable."
else
    echo "⚠️ Warning: 'galyarder-scaffold' not in PATH."
fi

# 3. Documentation/HQ Readiness
echo "[3/8] Checking Workspace Maturity..."
if [ -d "docs/departments" ]; then
    echo "✅ Digital HQ structure exists."
else
    echo "⚠️ Warning: Digital HQ not initialized. Run 'galyarder-scaffold'."
fi

# 4. Framework Source specific checks
if [ "$IS_SOURCE" = true ]; then
    echo "[4/8] Verifying Manifest Parity..."
    ROOT_VERSION=$(grep '"version":' gemini-extension.json | head -1 | awk -F'"' '{print $4}')
    MARKETPLACE_VERSION=$(grep '"version":' .claude-plugin/marketplace.json | head -1 | awk -F'"' '{print $4}')
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
    echo "✅ Root boot is department-scoped and monolith-free."

    echo "[6/8] Checking lazy Neural Link policy..."
    if grep -R -n -E --exclude='graph.json' --exclude='smoke.sh' \
        'Check the Map First|God Nodes|MUST read `docs/graph\.json`' \
        Executive Engineering Growth Security Product Infrastructure Legal-Finance Knowledge scripts docs integrations \
        >/tmp/galyarder-mandatory-graph.txt; then
        sed -n '1,40p' /tmp/galyarder-mandatory-graph.txt
        echo "❌ Error: Neural Link/World-Map access must be lazy, not mandatory for normal execution."
        exit 1
    fi
    echo "✅ Neural Link lookup is lazy."

    echo "[7/8] Checking for broken skill symlinks..."
    BROKEN_LINKS=$(find . -path './.git' -prune -o -xtype l -print)
    if [ -n "$BROKEN_LINKS" ]; then
        echo "$BROKEN_LINKS" | sed -n '1,40p'
        echo "❌ Error: Broken symlinks detected. Remove legacy nested skill links."
        exit 1
    fi
    echo "✅ No broken symlinks detected."

    echo "[8/8] Checking full marketplace bundle..."
    if ! grep -q '"name": "galyarder-framework"' .claude-plugin/marketplace.json; then
        echo "❌ Error: Marketplace is missing the all-departments galyarder-framework bundle."
        exit 1
    fi
    if [ ! -f ".marketplace/full/.claude-plugin/plugin.json" ]; then
        echo "❌ Error: Full marketplace bundle manifest is missing."
        exit 1
    fi
    for dept in "${DEPARTMENTS[@]}"; do
        if [ ! -e ".marketplace/full/${dept}" ]; then
            echo "❌ Error: Full marketplace bundle is missing ${dept}."
            exit 1
        fi
    done
    if find .marketplace/full -maxdepth 1 \( -name docs -o -name integrations -o -name .git -o -name CONVENTIONS.md \) | grep -q .; then
        echo "❌ Error: Full marketplace bundle includes heavyweight root artifacts."
        exit 1
    fi
    echo "✅ Full marketplace bundle is present and scoped."
else
    echo "[4/4] Target project check complete."
fi

echo "---"
echo "✅ SMOKE TEST PASSED: Environment is operational."
