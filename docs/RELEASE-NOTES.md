# Release Notes - Galyarder Framework

## [v1.9.7] - 2026-04-22
### Legacy Branding Purge
This release finalizes the "Galyarder Standard" by permanently purging all legacy "Paperclip" references from the framework's documentation, manifests, and internal logic.

#### Highlights
- **Universal Refactor**: Replaced `@paperclipai` scope with `@galyarder` across all files.
- **Branding Sterilization**: Conducted a recursive audit to ensure 100% Galyarder identity.
- **Agent Adapter Fix**: Updated the `create-agent-adapter` skill to reflect the new standardized types.

---

## [v1.9.0] - 2026-04-22
### The Unified CLI & NPM Era
A major architectural shift transitioning Galyarder Framework from a "Script-First" repository to a globally distributed "Package-First" intelligence layer.

#### Highlights
- **Unified CLI**: All commands consolidated under the `galyarder` binary (e.g., `galyarder scaffold`, `galyarder deploy`).
- **NPM Distribution**: Official support for `npm install -g galyarder-framework`.
- **Skills.sh Support**: First-class integration with `npx skills add` for departmental and full-framework injection.
- **Infrastructure Parity**: Finalized the 8-department structure including the mandatory `Infrastructure` silo.

#### Verification
```bash
npm install -g galyarder-framework
galyarder help
galyarder smoke
```

---

## [v1.8.17] - 2026-04-19
### Operational Realignment
Updated the core operational sequence and command protocols to explicitly incorporate the **Galyarder Neural Link** as a foundational mapping phase.

#### Highlights
- **Mermaid Sequence Update**: Injected the Neural Link into the "Operational Sequence" to show automated dependency auditing before strategic planning.
- **Protocol Expansion**: Added "Mapping" as Phase II of the 1-Man Army Command Protocol, ensuring all missions begin with a neural dependency audit.

---

## [v1.8.16] - 2026-04-19

### Root Runtime Cleanup
This patch removes the temporary compatibility source layer and keeps the restored assets directly in the canonical root runtime.

#### Highlights
- **No More `Compat/`**: The temporary compatibility source tree is gone.
- **Root Is Canonical**: `agents/`, `skills/`, `commands/`, and `personas/` remain the install surface and the source for bundle generation.
- **Bundle Builder Simplified**: `scripts/build_root_extension_surface.py` now only regenerates `.marketplace/full` from the canonical root runtime.

#### Verification
```bash
bash scripts/smoke.sh
```

---

## [v1.8.13] - 2026-04-20
### Runtime Compatibility Recovery
This patch restores the legacy runtime assets that had fallen out of the canonical root and full-bundle surfaces during the packaging refactors.

#### Highlights
- **Compat Source Layer**: Added `Compat/agents` and `Compat/skills`, and wired the root surface builder to include them in generated runtime outputs.
- **Agent Recovery**: Restored the missing founder-office and specialist agent surfaces, including `galyarder-specialist` and several historical orchestration agents.
- **Skill Recovery**: Restored missing compatibility skills and legacy entrypoints so older prompts, docs, and registries can still resolve their intended capability names.
- **Parity Audit Clean**: Historical canonical runtime audit now reports zero missing agents, personas, skills, or subagents.

#### Verification
```bash
python3 scripts/build_root_extension_surface.py
python3 scripts/build_root_extension_surface.py --output-root .marketplace/full
bash scripts/smoke.sh
```

---

## [v1.8.12] - 2026-04-20
### Claude Bundle Autodiscovery Fix
This patch removes the full bundle's explicit component-path overrides and lets Claude Code discover the standard root `agents/`, `skills/`, and `commands/` directories automatically.

#### Highlights
- **Minimal Claude Manifest**: `.marketplace/full/.claude-plugin/plugin.json` now contains only plugin metadata, with no explicit `agents`, `skills`, or `commands` override fields.
- **Default Root Layout**: The bundle continues to ship `agents/`, `skills/`, and `commands/` at the plugin root, matching Claude Code's documented default plugin layout.

#### Verification
```bash
bash scripts/smoke.sh
```

---

## [v1.8.11] - 2026-04-20
### Claude Bundle Manifest Shape Fix
This patch fixes the last Claude Code marketplace schema mismatch in the all-in-one bundle manifest.

#### Highlights
- **String Path Fields**: `.marketplace/full/.claude-plugin/plugin.json` now exports `agents`, `skills`, and `commands` as plain string paths, matching the Claude plugin validator.
- **Marketplace Version Bump**: Root and departmental manifests are bumped to `1.8.11` so installers can pick up the corrected bundle metadata cleanly.

#### Verification
```bash
bash scripts/smoke.sh
```

---

## [v1.8.10] - 2026-04-20
### Claude Manifest Repair + Persona Parity
This patch closes the remaining host packaging gaps that were still breaking Claude marketplace installs and partially collapsing executive personas back to host defaults.

#### Highlights
- **Claude Manifest Schema Fix**: Full bundle and department plugin manifests now match Claude's validator expectations for `author` and no longer emit an unsupported `personas` key.
- **Executive Identity Contract Parity**: CFO/COO, CMO, and CTO now export the same host-aware identity contract as CEO in generated root and marketplace agent surfaces.
- **Shorter XSS Skill Name**: The Burp Suite XSS skill now exports as `xss-testing-burpsuite`, avoiding host registries that prepend `galyarder-framework:` and exceed a 64-character skill-name limit.

#### Verification
```bash
python3 scripts/build_root_extension_surface.py
python3 scripts/build_root_extension_surface.py --output-root .marketplace/full
bash scripts/smoke.sh
```

---

## [v1.8.9] - 2026-04-20
### Copilot Persona Identity Fix
This patch tightens the CEO persona instructions for hosts like GitHub Copilot CLI that tend to reassert their platform identity.

#### Highlights
- **Identity Contract**: `galyarder-ceo` now explicitly answers as the Galyarder CEO persona running inside the active host runtime.
- **Deflation Guard**: Blocks fallback answers like "I'm just Copilot" unless the user is explicitly asking about the host/platform distinction.

#### Verification
```bash
python3 scripts/build_root_extension_surface.py
python3 scripts/build_root_extension_surface.py --output-root .marketplace/full
bash scripts/smoke.sh
```

---

## [v1.8.8] - 2026-04-19
### Gemini Agent Tool Mapping Fix
This patch converts exported root/full-bundle agents to Gemini-native tool metadata so custom agents no longer ship legacy Codex-style tool arrays.

#### Highlights
- **Gemini Tool Schema**: Replaces legacy `tools: [...]` frontmatter in exported runtime agents with `allowed-tools:` lists.
- **Root + Full Bundle Sync**: Applies the same normalization to repo root and `.marketplace/full`.

#### Verification
```bash
python3 scripts/build_root_extension_surface.py
python3 scripts/build_root_extension_surface.py --output-root .marketplace/full
bash scripts/smoke.sh
```

---

## [v1.8.7] - 2026-04-19
### Gemini Schema + Design Skill Fix
This patch fixes the two remaining loader issues after the root-runtime refactor: Gemini agent schema validation and missing skill frontmatter for design references.

#### Highlights
- **Gemini Agent Cleanup**: Strips unsupported `color`, `emoji`, and `vibe` keys from exported runtime agents.
- **Valid Design Skills**: Wraps `design-md-*` references with native YAML frontmatter so hosts treat them as proper skills.
- **Root + Full Bundle Parity**: Applies the same sanitation to repo root and `.marketplace/full`.

#### Verification
```bash
python3 scripts/build_root_extension_surface.py
python3 scripts/build_root_extension_surface.py --output-root .marketplace/full
bash scripts/smoke.sh
```

---

## [v1.8.6] - 2026-04-19
### Canonical Root Runtime
This patch finishes the packaging refactor: runtime assets now live in real root directories that can ship directly from GitHub archives, while department silos remain the documentation and reporting structure around them.

#### Highlights
- **Real Root `agents/skills/commands/personas`**: Replaced symlink-only compatibility shims with actual committed runtime directories.
- **Design-as-Skill Packaging**: Growth design assets now ship through `skills/design-md-*/SKILL.md`, so hosts see them as normal skills instead of orphan root markdown files.
- **Full Bundle Alignment**: `.marketplace/full` now exposes the same root runtime layout and manifest routing as the repo root.
- **Canonical Build Flow**: Conversion and bundle generators now read from the root runtime surface, so Gemini, Codex, Cursor, Claude bundles, and downstream integrations stay in sync.

#### Verification
```bash
bash scripts/convert.sh --tool all
bash scripts/smoke.sh
```

---

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
[View Full Migration Guide](MIGRATION.md)

---
© 2026 Galyarder Labs. Galyarder Framework. Engineering. Marketing. Distribution.
