import os
import sys

CHANGELOG_HEADER = """## [1.9.7] - 2026-04-22
### Fixed
- **Legacy Purge**: Permanently removed all legacy "Paperclip" references from Agent Adapter documentation, manifests, and skill logic. Standardized all packages under the `@galyarder` scope.

## [1.9.6] - 2026-04-22
### Changed
- **Migration Guide**: Updated the `MIGRATION.md` guide to document the transition to the Unified CLI and NPM distribution model.

## [1.9.5] - 2026-04-22
### Fixed
- **Infrastructure Mismatch**: Added the missing `Infrastructure` department to the `galyarder scaffold` command to ensure full architectural parity with system smoke tests.

## [1.9.4] - 2026-04-22
### Added
- **Physical Skill Bundles**: Implemented physical directory entry points for each department (Engineering, Growth, etc.) to enable seamless `npx skills add` integration.

## [1.9.3] - 2026-04-22
### Added
- **Skills.sh Integration**: Created the `skills.json` manifest and auto-sync engine to enable agentic skill injection via the `skills.sh` standard.

## [1.9.2] - 2026-04-22
### Fixed
- **NPM Registry Preparation**: Adjusted installation links to favor the official `galyarder-framework` package name and optimized package size via `.npmignore`.

## [1.9.0] - 2026-04-22
### Added
- **Unified Framework CLI**: Implemented the `galyarder` Node.js CLI to consolidate all shell scripts into a single, high-fidelity entry point.
- **NPM Distribution**: Transformed the framework into a first-class NPM package for global installation.
"""

RELEASE_NOTES_HEADER = """## [v1.9.7] - 2026-04-22
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
"""

def update_file(file_path, new_header):
    if not os.path.exists(file_path):
        return
    
    with open(file_path, "r") as f:
        content = f.read()
    
    lines = content.split('\n')
    header_line = -1
    for i, line in enumerate(lines):
        if line.startswith("## [") or line.startswith("# Release Notes"):
            if "# Changelog" in line or "# Release Notes" in line:
                continue
            header_line = i
            break
    
    if header_line != -1:
        new_content = "\n".join(lines[:header_line]) + "\n" + new_header + "\n" + "\n".join(lines[header_line:])
    else:
        new_content = content + "\n" + new_header
        
    with open(file_path, "w") as f:
        f.write(new_content)

update_file("CHANGELOG.md", CHANGELOG_HEADER)
update_file("RELEASE-NOTES.md", RELEASE_NOTES_HEADER)
print("✅ CHANGELOG.md and RELEASE-NOTES.md updated successfully.")
