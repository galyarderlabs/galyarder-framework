---
title: "Release Command | Galyarder Framework"
description: "Orchestrate the launch process, bump versions, and generate changelogs."
---

# :material-folder-zip: Release Command

<p class="domain-label">Infrastructure Command</p>

---

This command invokes the **release-manager** to finalize a production-ready version.

## What This Command Does

1. **Version Management** - Executes `bump-version.sh` using SemVer.
2. **Changelog Generation** - Compiles git logs and Linear tickets into release notes.
3. **Launch Sync** - Coordinates with marketing agents for the release announcement.

---
**Note**: Powered by the `finishing-a-development-branch` and `writing-skills` skills.
