#!/bin/bash

# Galyarder Framework: Company Scaffolder
# Purpose: Initialize the hierarchical directory structure for a Digital Enterprise.

echo "Initializing Galyarder Framework Digital Enterprise headquarters..."

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

# 3. Seed Templates (if available)
if [ -d "docs/templates" ]; then
    echo "Seeding departmental templates from docs/templates/..."
    # Copy specific templates to their departments
    cp docs/templates/*Founder* docs/departments/Executive/ 2>/dev/null
    cp docs/templates/*Product* docs/departments/Product/ 2>/dev/null
    cp docs/templates/*Engineering* docs/departments/Engineering/ 2>/dev/null
    cp docs/templates/*Growth* docs/departments/Growth/ 2>/dev/null
    cp docs/templates/*Security* docs/departments/Security/ 2>/dev/null
    cp docs/templates/*Legal-Finance* docs/departments/Legal-Finance/ 2>/dev/null
    cp docs/templates/*Knowledge* docs/departments/Knowledge/ 2>/dev/null
fi

echo "Company structure initialized at docs/departments/"
echo "Your Digital Headquarters is ready for Obsidian."
