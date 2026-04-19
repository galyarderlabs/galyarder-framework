#!/bin/bash

# Galyarder Framework: Company Scaffolder
# Purpose: Initialize the hierarchical directory structure for a Digital Enterprise.
# This script can be run locally or via:
# curl -sSL https://raw.githubusercontent.com/galyarderlabs/galyarder-framework/main/scripts/scaffold-company.sh | bash

RAW_URL="https://raw.githubusercontent.com/galyarderlabs/galyarder-framework/main/docs/templates"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"
LOCAL_TEMPLATE_DIR="$SCRIPT_DIR/../docs/templates"

echo "🚀 Initializing Galyarder Framework Digital Headquarters in $(pwd)..."

# 1. Base Directories
mkdir -p docs/specs
mkdir -p docs/plans
mkdir -p docs/reports
mkdir -p docs/templates

# 2. Departmental Structure
DEPARTMENTS=("Executive" "Product" "Engineering" "Growth" "Security" "Legal-Finance" "Knowledge")

for DEPT in "${DEPARTMENTS[@]}"; do
    DEPT_PATH="docs/departments/$DEPT"
    mkdir -p "$DEPT_PATH"
    
    # Initialize Department README if missing
    if [ ! -f "$DEPT_PATH/README.md" ]; then
        echo "# Department: $DEPT" > "$DEPT_PATH/README.md"
        echo "This directory contains persistent reports and strategic memory for the $DEPT department." >> "$DEPT_PATH/README.md"
        echo "---" >> "$DEPT_PATH/README.md"
        echo "Copyright 2026 Galyarder Labs. Galyarder Framework." >> "$DEPT_PATH/README.md"
    fi
done

# 3. Seed Templates
echo "[*] Seeding departmental templates..."

seed_remote() {
    local file=$1
    local dest=$2
    # Convert spaces to %20 for URL
    local url_file="${file// /%20}"
    echo "  -> Fetching: $file"
    curl -sSL "$RAW_URL/$url_file" -o "$dest/$file"
}

if [ -d "$LOCAL_TEMPLATE_DIR" ]; then
    echo "    (Using local source: $LOCAL_TEMPLATE_DIR)"
    cp "$LOCAL_TEMPLATE_DIR"/*Founder* docs/departments/Executive/ 2>/dev/null || true
    cp "$LOCAL_TEMPLATE_DIR"/*Product* docs/departments/Product/ 2>/dev/null || true
    cp "$LOCAL_TEMPLATE_DIR"/*Engineering* docs/departments/Engineering/ 2>/dev/null || true
    cp "$LOCAL_TEMPLATE_DIR"/*Growth* docs/departments/Growth/ 2>/dev/null || true
    cp "$LOCAL_TEMPLATE_DIR"/*Security* docs/departments/Security/ 2>/dev/null || true
    cp "$LOCAL_TEMPLATE_DIR"/*Legal-Finance* docs/departments/Legal-Finance/ 2>/dev/null || true
    cp "$LOCAL_TEMPLATE_DIR"/*Knowledge* docs/departments/Knowledge/ 2>/dev/null || true
else
    echo "    (Local source not found. Fetching from Galyarder GitHub...)"
    seed_remote "Galyarder-Framework Founder Office Audit.md" "docs/departments/Executive"
    seed_remote "Galyarder-Framework Product Audit.md" "docs/departments/Product"
    seed_remote "Galyarder-Framework Engineering Audit.md" "docs/departments/Engineering"
    seed_remote "Galyarder-Framework Growth Audit.md" "docs/departments/Growth"
    seed_remote "Galyarder-Framework Security Audit.md" "docs/departments/Security"
    seed_remote "Galyarder-Framework Legal-Finance Audit.md" "docs/departments/Legal-Finance"
    seed_remote "Galyarder-Framework Knowledge Audit.md" "docs/departments/Knowledge"
    seed_remote "Galyarder-Framework Decision Log Template.md" "docs/reports"
fi

echo "✅ Company structure initialized at docs/departments/"
echo "Your Digital Headquarters is ready for Obsidian."
