---
description: Enforce test-driven development workflow. Scaffold interfaces, generate tests FIRST, then implement minimal code to pass. Ensure 80%+ coverage.
---

# TDD Command

This command invokes the **elite-developer** agent to enforce test-driven development methodology.

## What This Command Does

1. **Scaffold Interfaces** - Define types/interfaces first
2. **Generate Tests First** - Write failing tests (RED)
3. **Implement Minimal Code** - Write just enough to pass (GREEN)
4. **Refactor** - Improve code while keeping tests green (REFACTOR)
5. **Verify Coverage** - Ensure 80%+ test coverage

## How It Works

The agent will follow the strict TDD protocol:
1. **Define interfaces** for inputs/outputs.
2. **Write tests that will FAIL** (because code doesn't exist yet).
3. **Run tests** and verify they fail for the right reason.
4. **Write minimal implementation** to make tests pass.
5. **Run tests** and verify they pass.
6. **Refactor** code while keeping tests green.

## Example Usage

```
User: /tdd I need a function to calculate market liquidity score
```

---
**Note**: This command is powered by the `galyarder-framework:test-driven-development` skill.
