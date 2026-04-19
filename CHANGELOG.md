# Changelog

All notable changes to Galyarder Framework will be documented in this file.

## [1.8.5] - 2026-04-19
### Added
- **Root Compatibility Surface**: Restored root-level `agents/`, `skills/`, `commands/`, and `personas/` paths as generated symlink surfaces so extension hosts that scan fixed root directories can discover framework assets again.
### Changed
- **Gemini/Cursor/Codex Root Paths**: Repointed top-level manifests back to root compatibility directories instead of custom bundle-only paths.
### Fixed
- **Gemini Extension Discovery**: Root extension installs can now resolve the standard directory names Gemini CLI expects for custom agents, skills, and commands.

## [1.8.4] - 2026-04-19
### Added
- **Host Bundle Layer**: Added root `Bundle/` and `Gemini/` all-in-one install surfaces so multi-department assets are exposed through single paths that host manifests can scan.
### Changed
- **Gemini Manifest Shape**: Reworked the top-level Gemini extension manifest to use single bundle paths for `agents`, `skills`, and `commands`, matching the older manifest style that previously registered custom assets.
- **Design Discovery**: Folded `Growth/design/*.md` assets into bundle-backed skill entries so design libraries travel with all-in-one installs.
### Fixed
- **Executive Visibility**: Exposed CEO/CFO/CMO/CTO personas through host-facing `agents` bundles for pickers that ignore `personas`.
- **Cursor/Codex Root Paths**: Repointed root plugin manifests away from nonexistent `./agents` / `./skills` / `./commands` directories to valid bundle paths.
- **Gemini Local Install**: Fixed Gemini sync/install scripts so generated skills deploy from `integrations/gemini` instead of the pre-silo root layout.

## [1.8.3] - 2026-04-19
### Added
- **Bundle Install Path**: Added a top-level `galyarder-framework` marketplace bundle so all 8 departments can be installed as one package.
### Changed
- **Neural Link Policy**: Re-scoped Neural Link / World-Map access to lazy lookup. Agents, personas, and commands now load graph context only for architecture discovery, cross-department routing, or explicit `/graph` work.
- **Boot Surface**: Root operating context is department-scoped and monolith-free instead of dragging full-world context into normal execution.
### Fixed
- **Marketplace Integrity**: Removed broken nested skill symlinks that caused `ENOENT realpath` install failures in marketplace consumers.
- **Aider Decommission**: Removed legacy `CONVENTIONS.md` and the `integrations/aider` export so obsolete Aider conventions no longer leak into generated tool packages.
- **Generated Integrations**: Rebuilt all supported tool integrations so the lazy-load policy and cleaned packaging propagate consistently.

## [1.8.2] - 2026-04-19
### Added
- **Neural Link Broadcast**: Added `/graph` command to core `GEMINI.md` and `CLAUDE.md` operational triggers.
- **Executive Awareness**: Injected "Strategic Knowledge Synthesis" into `chief-of-staff` to automate map rebuilding.
### Changed
- **Manifest Versions**: Bumped all 21 `gemini-extension.json`, `plugin.json`, and `marketplace.json` manifests to `1.8.2`.

## [1.8.1] - 2026-04-19
### Fixed
- **Legacy Path Purge**: Surgically removed all hardcoded references to `.agents/`, `.claude/`, and `.gemini/` hidden directories inside logic files.
- **Dependency Re-routing**: Updated agent memory logic to use the new `docs/departments/` structure for `founder-context.md` and `product-marketing-context.md`.
- **OpenCode Plugin Integrity**: Fixed Silo path resolution and internal tool mapping for the OpenCode environment.
- **Hidden Directory Eradication**: Permanently deleted `.autoresearch`, `.claude`, `.gemini`, `.github`, and `.agents` legacy folders.
- **Asset Re-generation**: 207 assets across 14 platforms re-synced to ensure consistent path logic system-wide.

## [1.8.0] - 2026-04-19
### Summary
Architectural guardrails to make execution provable: gated testing ladder, test-oracle defenses, operational modes, context version-truth, and tool interface boundaries.
### Added
- **Gating Ladder**: Enforced execution gates: **Unit → Contract → E2E**.
- **Test Oracle Guardrails**: Mandatory negative control / mutation check to prevent “fake green” tests.
- **Operational Modes**:
  - `BUILD` (default): PRD-driven, full ceremony, full TDD.
  - `INCIDENT`: hotfix bypass with mandatory post-mortem.
  - `EXPERIMENT`: timeboxed, quarantined throwaway work.
- **Context Truth**: `context7` fetch must verify **library version** against local dependencies before adoption.
- **Tool Interfaces**: Standard interfaces introduced:
  - `IssueTracker` (Linear adapter)
  - `ExecutionProxy` (RTK adapter)
  - `MemoryStore` (Obsidian adapter)
- **Obsidian Loop**: Mandatory durable reporting artifact output to `docs/departments/`.
- **Company Scaffolder**: `scripts/scaffold-company.sh` to initialize HQ + departmental templates.
- **Sync Suite**: Added/updated sync + docs generation scripts (see `/scripts`).
### Changed
- Repo structure flattened; removed legacy `framework/` directory.
- `WORKFLOW.md` updated for Humans 3.0 hierarchy + gating + modes.
- Branding standardized: “Galyarder Framework” vs “Galyarder Labs”.
### Fixed
- Non-ASCII purge for terminal compatibility.
- Linear scoping hardened to enforce project-scoped operations.
- Global Karpathy protocol integrated across agents/skills (think-first, simplicity-first, surgical changes, goal-driven execution).
### Breaking Changes
- Removed `framework/` subdirectory; paths have changed accordingly.
- Any workflows/scripts referencing old paths must be updated.
### Migration
1. Update local references from `framework/...` to repo root paths.
2. Re-run install/conversion scripts for your tool (`./scripts/install.sh --tool <...>`).
3. Regenerate docs if you rely on portal output (`generate-docs.py`).
### Verification (Smoke)
- Run one BUILD mission and confirm gates: unit pass → contract pass → e2e pass.
- Confirm test-oracle policy: a known-bad variant must fail before implementation proceeds.
- Confirm `context7` outputs include version verification metadata.

## [1.6.0] - 2026-04-12

### Added
- **5 new agents:**
  - `mcp-builder` - MCP server development specialist
  - `sre` - Site reliability engineering, SLOs, error budgets
  - `chief-of-staff` - Founder coordination and clarity
  - `rapid-prototyper` - Ultra-fast POC and MVP validation
  - `sales-engineer` - Pre-sales technical specialist
- Total: 40 agents, 132 skills

### Fixed
- All plugin configs updated to root paths (no `framework/` prefix)
- Gemini extension paths fixed
- FUNDING.yml removed (pending GitHub Sponsors enrollment)

### Changed
- Separated Framework from Dashboard into independent repos
- Dashboard moved to [Galyarder Framework HQ](https://github.com/galyarderlabs/galyarder-hq)
- Framework is now standalone - agents and skills at root level
- Updated README to reflect standalone Framework positioning
- Fixed all symlinks for Antigravity, Codex, and OpenCode

### Breaking Changes
- Removed all Dashboard CI workflows (Docker, e2e, release-smoke).
- Migrated dashboard logic to a separate repository; local hooks must be re-pointed to `@galyarderlabs/galyarder-hq`.

---
© 2026 Galyarder Labs. Galyarder Framework. Engineering. Marketing. Distribution.
