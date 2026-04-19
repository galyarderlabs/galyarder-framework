#!/bin/bash
# Galyarder Framework: Audit-Grade Smoke Test
# Verifies system integrity, version parity, and structural health.

set -e

echo "🚀 Starting Galyarder v1.8.0 Smoke Test..."

# Detect if we are in the Framework Source or a Project HQ
IS_SOURCE=false
if [ -f "gemini-extension.json" ] && [ -d "Engineering" ]; then
    IS_SOURCE=true
    echo "[*] Detected: Galyarder Framework Source Environment"
else
    echo "[*] Detected: Target Project Environment"
fi

# 1. Structural Verification
echo "[1/4] Verifying Departmental Integrity..."
DEPARTMENTS=("Executive" "Product" "Engineering" "Growth" "Security" "Legal-Finance" "Knowledge")

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
echo "✅ All 7 Departments accounted for."

# 2. Path & Script Awareness
echo "[2/4] Verifying CLI Accessibility..."
if command -v galyarder-scaffold >/dev/null 2>&1; then
    echo "✅ CLI commands are reachable."
else
    echo "⚠️ Warning: 'galyarder-scaffold' not in PATH."
fi

# 3. Documentation/HQ Readiness
echo "[3/4] Checking Workspace Maturity..."
if [ -d "docs/departments" ]; then
    echo "✅ Digital HQ structure exists."
else
    echo "⚠️ Warning: Digital HQ not initialized. Run 'galyarder-scaffold'."
fi

# 4. Framework Source specific checks
if [ "$IS_SOURCE" = true ]; then
    echo "[4/4] Verifying Manifest Parity..."
    ROOT_VERSION=$(grep '"version":' gemini-extension.json | head -1 | awk -F'"' '{print $4}')
    if [ "$ROOT_VERSION" != "1.8.0" ]; then
        echo "❌ Error: Version mismatch ($ROOT_VERSION != 1.8.0)"
        exit 1
    fi
    echo "✅ Versioning locked at v1.8.0."
else
    echo "[4/4] Target project check complete."
fi

echo "---"
echo "✅ SMOKE TEST PASSED: Environment is operational."
