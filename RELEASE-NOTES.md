# Release Notes - Galyarder Framework

## [v1.8.5] - 2026-04-19
### Root Extension Surface
This patch restores the fixed root directory layout that extension hosts like Gemini CLI expect while keeping the department-based source structure intact underneath.

#### Highlights
- **Root `agents/skills/commands/personas`**: Added generated root compatibility paths for host scanners that do not follow custom bundle conventions.
- **Manifest Repointing**: Gemini, Cursor, and Codex top-level manifests now target the restored root paths again.
- **Department Sources Preserved**: The framework still uses department folders as the source of truth; the root surface is generated as a compatibility layer.

#### Verification
```bash
python3 scripts/build_root_extension_surface.py
bash scripts/smoke.sh
```

---

## [v1.8.4] - 2026-04-19
### Host Bundle Repair
This patch fixes the all-in-one install surface for Gemini and other host manifests that expect one root bundle instead of scattered department paths.

#### Highlights
- **Gemini All-in-One**: Added a root `Gemini/` bundle with unified `agents`, `skills`, and `commands` paths.
- **Design Included**: Growth design libraries are now exposed as bundle skill entries instead of being left outside the all-in-one install surface.
- **Executive Picker Repair**: CEO, CFO/COO, CMO, and CTO are now exposed through host-facing agent bundles for pickers that only read `agents`.
- **Cursor/Codex Root Fix**: Top-level plugin manifests now point to valid bundle directories instead of nonexistent root folders.

#### Verification
```bash
python3 scripts/build_gemini_bundle.py
python3 scripts/build_host_bundle.py
bash scripts/smoke.sh
```

---

## [v1.8.3] - 2026-04-19
### Packaging Recovery & Lazy Neural Link
This release hardens the framework for real marketplace installs: lighter boot context, one-shot full-bundle install, and no more broken nested skill paths.

#### Highlights
- **Lazy Neural Link**: World-Map / graph context is now fetched only when the task actually needs architecture discovery, dependency mapping, or explicit `/graph` work.
- **Full Marketplace Bundle**: Added `galyarder-framework` as a top-level bundle so all 8 departments can be installed together instead of one by one.
- **Installer Repair**: Removed broken nested skill symlinks that were producing `ENOENT realpath` failures during plugin install.
- **Aider Purge**: Deleted the old `CONVENTIONS.md` monolith and removed Aider integration exports from generated packages.
- **Integration Rebuild**: Re-generated all supported tool packages so the lighter load policy lands everywhere consistently.

#### Verification
```bash
bash scripts/smoke.sh
```

Expected outcome:
- Neural Link lookup is lazy
- No broken symlinks detected
- Full marketplace bundle is present and scoped

---

## [v1.8.2] - 2026-04-19
### Ecosystem Broadcast: The Neural Link
Officially broadcasted the Galyarder Neural Link capability across all 14 platforms and executive agents.

#### Highlights
- **Command Broadcast**: The `/graph` command is now natively recognized across Claude Code, Gemini CLI, and other integrations.
- **Executive Awareness**: `chief-of-staff` and `galyarder-specialist` are now programmed to orchestrate map rebuilding after major architectural shifts.
- **Global Manifest Bump**: All 21 marketplace and plugin manifests have been bumped to v1.8.2 to ensure the ecosystem picks up the new capabilities.

---

## [v1.8.1] - 2026-04-19
### Final Audit & Path Hardening
A critical patch following the Humans 3.0 deep audit to ensure 100% logic integrity across all 14 platforms.

#### Fixes & Improvements
- **Global Path Eradication**: Removed all legacy hardcoded references to `.agents/`, `.claude/`, and `framework/` subdirectories inside agent logic files.
- **Strategic Re-Routing**: Re-pointed all memory dependencies (Founder Context, Product Context) to the new high-integrity `docs/departments/` structure.
- **Conversion Consistency**: Re-generated all 207 assets across 14 tools to ensure zero "ghost directory" instructions.
- **OpenCode Repair**: Fixed Silo discovery and tool mapping in the OpenCode native plugin.
- **Clean Registry**: Permanently purged all low-value hidden directories (`.autoresearch`, `.agents`).

---

## [v1.8.0] - 2026-04-19
### Summary
Architectural guardrails to make execution provable: gated testing ladder, test-oracle defenses, operational modes, context version-truth, and tool interface boundaries.

#### Highlights
- **Gating Ladder**: Enforced execution gates: **Unit → Contract → E2E**.
- **Contract Tests**: Verified API/interface boundaries in `tests/contract/`.
- **Test Oracle Guardrails**: Mandatory negative control / mutation check.
- **Operational Modes**: `BUILD` (Standard), `INCIDENT` (Hotfix), `EXPERIMENT` (Spike).
- **Context Truth**: `context7` fetches verify library versions against local dependencies.
- **Tool Interfaces**: Abstracted adapters for Linear, RTK, and Obsidian.

#### How to Run (100% Copy-Paste)
```bash
# 1. Install & Scaffold
./scripts/install.sh --tool <cursor|claude-code> && ./scripts/scaffold-company.sh

# 2. Run Audit-Grade Smoke Test
bash scripts/smoke.sh

# 3. Run Full Gating Ladder (Example)
rtk npm run test:unit && rtk npm run test:contract && rtk npm run test:e2e
```

#### Compatibility Matrix
| Tool | Support Level | Version Tested | Known Limitation |
| :--- | :--- | :--- | :--- |
| **Claude Code** | Full (Native) | v0.2.x | Slower marketplace crawl on first init. |
| **Gemini CLI** | Full (Native) | v1.1.x | Requires manual hard refresh for favicon. |
| **Cursor** | High (MDC) | v0.42.x | `.mdc` files require IDE restart to reload. |
| **Windsurf** | Medium | v1.0.x | Plugin lifecycle is still in experimental. |

#### Known Issues (Alpha Caveats)
- **Symlink Fragility**: Moving root files can break local platform folders. **Workaround**: Re-run `scripts/sync-*.py`.
- **Mermaid Rendering**: GitHub SVG element issues occasionally delay visual display. **Workaround**: Hard refresh (Ctrl+F5).
- **Context Latency**: `context7` fetching adds 2-5s overhead to high-rigor tasks.

#### Migration
[View Full Migration Guide](docs/MIGRATION.md)

---
© 2026 Galyarder Labs. Galyarder Framework. Engineering. Marketing. Distribution.
