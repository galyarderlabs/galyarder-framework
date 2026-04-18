---
title: "Review Command | Galyarder Framework"
description: "Perform a principal-level code review of the current changes against the PRD and Design System."
---

# :material-folder-zip: Review Command

<p class="domain-label">Engineering Command</p>

---

This command invokes the **code-reviewer** agent to audit the quality, security, and maintainability of the codebase.

## What This Command Does

1. **Git Diff Audit** - Scans all modified files.
2. **Standard Check** - Verifies adherence to TDD, Immutability, and the 4px Design System.
3. **Security Check** - Flags hardcoded secrets, IDOR, or SSRF vulnerabilities.
4. **Actionable Feedback** - Categorizes issues by severity (Critical, Important, Minor).

---
**Note**: This command is powered by the `galyarder-framework:requesting-code-review` and `code-review-expert` skills.
