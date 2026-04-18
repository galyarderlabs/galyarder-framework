---
title: "Build Fix Command | Galyarder Framework"
description: "Systematically investigate and fix build errors, TypeScript errors, or test failures with minimal diffs."
---

# :material-folder-zip: Build Fix Command

<p class="domain-label">Engineering Command</p>

---

This command invokes the **build-error-resolver** agent to surgically fix compilation or runtime errors.

## What This Command Does

1. **Error Analysis** - Reads the full stack trace and identifies the origin of the failure.
2. **Minimal Correction** - Applies the smallest possible change to resolve the error.
3. **Verification** - Runs the build or tests again to ensure the fix works.

## When to Use

Use `/build-fix` when:
- `npm run build` fails.
- TypeScript compiler (`tsc`) reports errors.
- Tests are failing due to environment or type mismatches.

---
**Note**: This command is powered by the `galyarder-framework:systematic-debugging` skill.
