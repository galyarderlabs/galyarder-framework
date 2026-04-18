---
title: "Clean Command | Galyarder Framework"
description: "Dead code cleanup and consolidation specialist. Removes unused code, duplicates, and refactors for maintainability."
---

# :material-folder-zip: Clean Command

<p class="domain-label">Engineering Command</p>

---

This command invokes the **refactor-cleaner** agent to reduce technical debt.

## What This Command Does

1. **Dead Code Detection** - Runs tools like `knip` or `ts-prune` to find unused exports.
2. **Consolidation** - Merges duplicated logic into shared utilities.
3. **Refactoring** - Simplifies complex functions and deepens shallow modules.

---
**Note**: This command is powered by the `galyarder-framework:improve-codebase-architecture` skill.
