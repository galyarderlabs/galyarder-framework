# Galyarder Migration Guide: v1.7.x -> v1.8.0

Version 1.8.0 introduces a high-integrity flattening of the repository structure. The legacy `framework/` subdirectory has been removed to reduce path depth and improve tool compatibility.

## Path Mapping (Mechanical Migration)

If you have custom scripts or local references, update them according to this mapping:

| Old Path (v1.7.x) | New Path (v1.8.0) |
| :--- | :--- |
| `framework/agents/` | `[Department]/agents/` |
| `framework/skills/` | `[Department]/skills/` |
| `framework/personas/` | `Executive/personas/` |
| `personas/` | `Executive/personas/` |
| `agents/` | `[Department]/agents/` |
| `skills/` | `[Department]/skills/` |
| `.claude/marketplace.json` | `.claude-plugin/marketplace.json` |

## v1.8.15 -> v1.8.16 (The Zero-Slop Hardening)

### 1. Aider Decommission
The `integrations/aider` directory and the 2MB+ `CONVENTIONS.md` monolith have been permanently purged. If you previously relied on Aider, we recommend transitioning to **Claude Code** or **Gemini CLI** for superior context handling.

### 2. Universal Plugin Mapping
To comply with the strict schema requirements of Google, Anthropic, and Microsoft, the following internal mapping is now enforced:
- **Personas** are now located in `agents/`.
- **Aesthetic Law / Design Specs** are now located in `skills/`.
- **Slash Commands** are strictly in `commands/`.

This ensures that tools only see valid directories, preventing "Context Bloat" and installation failures.

1. **Flush Local Symlinks**:
   If using Codex or Gemini locally, remove old symlink directories:
   ```bash
   rm -rf .codex/skills .gemini/skills
   ```

2. **Re-Sync Assets**:
   Run the high-fidelity synchronization scripts:
   ```bash
   python3 scripts/sync-codex-skills.py
   python3 scripts/sync-gemini-skills.py
   ```

3. **Re-Install via Conversion Engine**:
   If using Cursor, re-run the installer to update the `.mdc` files:
   ```bash
   ./scripts/install.sh --tool cursor
   ```

## v1.9.0+: The Unified CLI & NPM Era

Version 1.9.0 represents a major architectural shift in how the Galyarder Framework is distributed and consumed. We have moved from a "Script-First" model to a "Package-First" model.

### 1. Installation Method Migration
Legacy users who cloned the repository manually should transition to the global NPM package for easier updates and path resolution.

| Source Method | Command (New Standard) |
| :--- | :--- |
| **Git Clone** | `npm install -g galyarder-framework` |
| **Direct Pull** | `npx skills add galyarderlabs/galyarder-framework --skill full` |

### 2. Command Unification
We have consolidated all separate shell scripts into a single, high-fidelity Node.js CLI. The old `galyarder-*` aliases are deprecated.

| Legacy Command | New CLI Command |
| :--- | :--- |
| `galyarder-deploy` | `galyarder deploy` |
| `galyarder-scaffold` | `galyarder scaffold` |
| `galyarder-smoke` | `galyarder smoke` |
| `galyarder-convert` | `galyarder convert` |

### 3. Departmental Infrastructure
The number of mandatory departments has been finalized to 8. If your Digital HQ was scaffolded before v1.9.5, you may be missing the **Infrastructure** department.

**To fix:**
```bash
# Update to latest framework
npm install -g galyarder-framework

# Re-run scaffold to inject missing departments/templates
galyarder scaffold
```

### 4. Agentic Skill Injection
You can now pull Galyarder intelligence directly into any agent environment using the `skills.sh` standard. This eliminates the need for manual file copying.

```bash
# Inject the complete Galyarder engineering brain
npx skills add galyarderlabs/galyarder-framework --skill engineering
```

---
© 2026 Galyarder Labs. Galyarder Framework. Engineering. Marketing. Distribution.
