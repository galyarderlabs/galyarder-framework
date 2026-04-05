# Release Notes - Galyarder Agent Framework v1.1.4

The **Stability & Compatibility Update**. Version 1.1.4 focuses on making the 1-Man Army roster work flawlessly across all major AI tools (Claude Code, Gemini CLI, and Copilot).

## Highlights

### 1. Zero-Friction Tool Compatibility
We have resolved critical issues that prevented agents from being discovered or validated:
- **Gemini CLI Validation**: All agent definitions now use strict YAML array formatting for tools, passing the ExtensionManager's rigorous validation.
- **Copilot CLI Discovery**: Every agent is now also exposed as a discrete **Skill** in the `skills/` directory, making them 100% discoverable via `/skills list`.
- **Command Mastery**: Shorthand commands like `/analytics`, `/legal`, and `/finops` are now correctly registered as top-level CLI commands.

### 2. Narrative Refinement (RTK & Scratchpad)
To prevent "hallucination block" or resistance from AI assistants (especially Copilot), we have refined the internal instructions. The `rtk` (Rust Token Killer) and `scratchpad` protocols are now presented as native environment standards, ensuring consistent adoption without runtime errors.

### 3. Full-Scale Roster Expansion
Added 10 new specialized agents to cover the entire product lifecycle:
- **Risk & Finance**: `legal-counsel` and `finops-manager`.
- **Intelligence**: `cyber-intel` and `perseus` (Offensive Security).
- **Growth**: `analytics-architect`, `growth-engineer`, and `retention-specialist`.
- **Operations**: `release-manager`, `support-lead`, and `experimentation-engineer`.

### 4. Localized Elite Security Skills
20+ advanced security skills (Red Teaming, AD Attack Simulation, WAF Bypass) have been localized into the repository, ensuring complete autonomy and sovereignty for every user.

## The 1-Man Army Pipeline
The `galyarder-specialist` now orchestrates a hardened 5-phase workflow:
1. **Discovery**: PRD + KPIs + FinOps Feasibility.
2. **Architecture**: API Contracts + Legal Compliance Review.
3. **Engineering**: TDD + Offensive Audit + External Intel.
4. **Production**: CI/CD + Version Bump + A/B Launch.
5. **Distribution**: Viral Loops + Release Hype + FAQ Automation.

---
© 2026 Galyarder Labs. Built for the 1-Man Army.
