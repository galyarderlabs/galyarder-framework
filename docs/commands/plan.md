---
title: "Plan Command | Galyarder Framework"
description: "Restate requirements, assess risks, and create a step-by-step implementation plan with Vertical Slices (Tracer Bullets)."
---

# :material-folder-zip: Plan Command

<p class="domain-label">Product Command</p>

---

This command invokes the **super-architect** agent to create a comprehensive implementation plan before writing any code.

## What This Command Does

1. **Restate Requirements** - Clarify what needs to be built.
2. **Identify Risks** - Surface potential issues and blockers.
3. **Create Step Plan** - Break down implementation into **Vertical Slices**.
4. **Linear Integration** - Map tasks to Linear tickets.

## When to Use

Use `/plan` when:
- Starting a new feature.
- Making significant architectural changes.
- Working on complex refactoring.
- Multiple files/components will be affected.

## Vertical Slice Strategy

Unlike traditional planning, `/plan` focuses on **Tracer Bullets**:
- A phase must cut through ALL layers (DB -> API -> UI).
- Each phase must be independently demoable and verifiable.

---
**Note**: This command is powered by the `galyarder-framework:writing-plans` and `prd-to-plan` skills.
