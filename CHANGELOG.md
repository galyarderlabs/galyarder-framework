# Changelog

All notable changes to Galyarder Framework will be documented in this file.

## [1.6.0] - 2026-04-12

### Added
- **5 new agents:**
  - `mcp-builder` — MCP server development specialist
  - `sre` — Site reliability engineering, SLOs, error budgets
  - `chief-of-staff` — Founder coordination and clarity
  - `rapid-prototyper` — Ultra-fast POC and MVP validation
  - `sales-engineer` — Pre-sales technical specialist
- Total: 40 agents, 132 skills

### Fixed
- All plugin configs updated to root paths (no `framework/` prefix)
- Gemini extension paths fixed
- FUNDING.yml removed (pending GitHub Sponsors enrollment)
- Removed all Dashboard CI workflows (Docker, e2e, release-smoke)


### Changed
- Separated Framework from Dashboard into independent repos
- Dashboard moved to [Galyarder HQ](https://github.com/galyarderlabs/galyarder-hq)
- Framework is now standalone — agents and skills at root level
- Updated README to reflect standalone Framework positioning
- Fixed all symlinks for Antigravity, Codex, and OpenCode


### Added
- **Dashboard Integration:** Complete integration layer between Framework and Dashboard
  - Framework adapter (`dashboard/packages/adapters/galyarder-framework/`)
  - Agent loader (loads 34 agents from Framework)
  - Skill executor (executes 100+ skills)
  - Orchestrator (routes tasks to departments)
  - Test script for validation
- **Documentation:**
  - Organization chart with 8 departments (`docs/ORG_CHART.md`)
  - Integration guide (`docs/INTEGRATION.md`)
  - Unified platform architecture (`docs/UNIFIED_PLATFORM.md`)
  - Quick start guide (`docs/QUICK_START.md`)
  - Dashboard vs Framework explanation (`docs/DASHBOARD_VS_FRAMEWORK.md`)
  - Integration complete summary (`docs/INTEGRATION_COMPLETE.md`)
- **Obsidian Templates:**
  - Integration status report template
  - Updated vision document with deployment options
- **Deployment Options:**
  - Standalone mode (conversational via AI assistant)
  - Dashboard mode (web UI with visual management)

### Changed
- Updated README with deployment options and integration info
- Enhanced organization structure documentation
- Clarified Framework vs Dashboard relationship

### Technical
- Agent loading from markdown files
- Skill parsing and registry system
- Task routing via orchestrator
- Dashboard-compatible adapter interface

## [1.3.0] - Previous Release

### Added
- Fundraising operator and founder office skills
- Obsidian architecture and knowledge management
- Security and threat intelligence agents
- Growth and marketing specialists

## [1.2.0] - Previous Release

### Added
- Core engineering agents
- Product management workflow
- Test-driven development skills
- Systematic debugging framework

## [1.1.0] - Previous Release

### Added
- Initial agent framework
- Basic skill library
- Workflow orchestration
- Command shortcuts

## [1.0.0] - Initial Release

### Added
- Core framework structure
- Agent system
- Skill system
- Documentation

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.3.1] - 2026-04-06

### Changed
- **Official Rebranding**: Renamed project to **Galyarder Framework**.
- **Marketing Positioning**: Focused on "Skills" as the primary value proposition in README and taglines.
- **Internal Cleanup**: Updated all manifest files, slugs, and skill directory names to reflect the new brand.

## [1.3.0] - 2026-04-06

### Added
- **Obsidian Visual Integration**: Integrated Obsidian as the primary visual and knowledge-base layer.
  - New Agent: `obsidian-architect` for Digital Garden and Visual Architecture management.
  - 5 New Skills: `defuddle`, `json-canvas`, `obsidian-bases`, `obsidian-cli`, and `obsidian-markdown`.
  - Automated Pipeline Integration: Obsidian is now a core participant in Discovery (Dashboard Init), Architecture (Visual Mapping), and Engineering (Automated Activity Logging) phases.
- **Project-Level Codex Discovery**: Added `AGENTS.md` and `.codex/config.toml` to the project root to improve specialist and command discovery in OpenAI Codex.

### Fixed
- **OpenCode Compatibility**: Refactored all 34 agent definitions to use the record format for `tools`, ensuring compatibility with OpenCode's strict YAML parser.
- **Validation Cleanup**: Removed legacy `model: inherit` and `model: opus` fields from agent frontmatter to prevent "invalid model" errors in OpenCode and Codex.
- **Branding Consistency**: Removed all legacy references to "Superpowers" from test scripts and internal variables, replacing them with "Galyarder".
- **Shadow Binary Resolution**: Provided documentation and protocols for identifying and removing shadow binaries in global npm environments.

## [1.2.0] - 2026-04-05

### Fixed
- **Manifest Sovereignty**: Implemented cross-platform manifest synchronization. `gemini-extension.json` now uses full explicit mapping, while `.claude-plugin/plugin.json` uses a surgical fix (omitting 'agents') to bypass Claude Code validation errors while maintaining full functionality.
- **Cross-Tool Discovery**: Ensured all agents, skills, and commands are discoverable across Gemini CLI, Claude Code, and Copilot by mirroring agents as skills and explicitly registering command directories.

## [1.1.4] - 2026-04-04

### Fixed
- **Gemini CLI Validation**: Converted agent frontmatter `tools` field to array format to pass Gemini CLI strict validation.
- **Agent Synchronization**: Re-synced all agent definitions to the `skills/` directory to ensure consistency across all access methods.

## [1.1.3] - 2026-04-04

### Changed
- **Narrative Refinement**: Softened the language for RTK and Scratchpad protocols from "Mandatory Rules" to "Environment Standards" to reduce AI resistance in restricted runtimes like Copilot CLI.

## [1.1.2] - 2026-04-04

### Added
- **Copilot CLI Discovery**: Exposed all agents as individual skills in the `skills/` directory, allowing them to be discovered via the `/skills list` command in Copilot.

## [1.1.1] - 2026-04-04

### Fixed
- **Command Registration**: Explicitly registered the `commands/` directory in plugin metadata to ensure shorthand commands (e.g., `/analytics`) are recognized as top-level CLI commands.

## [1.1.0] - 2026-04-04

### Added
- **Full-Scale Roster Expansion**: Added 10 new specialized agents to complete the 1-Man Army lifecycle:
  - `analytics-architect`: Data tracking and KPI design.
  - `finops-manager`: Cloud cost optimization and pricing.
  - `legal-counsel`: TOS/Privacy, GDPR, and AI governance.
  - `growth-engineer`: Engineering-as-marketing and viral loops.
  - `retention-specialist`: CRM and psychological onboarding.
  - `cyber-intel`: External threat intelligence and dark web monitoring.
  - `experimentation-engineer`: A/B testing and CRO.
  - `release-manager`: Launch orchestration and versioning.
  - `support-lead`: FAQ automation and troubleshooting.
- **Elite Security Skills (Localized)**: "Nationalized" 20+ advanced security skills from internal environment to the framework repo, ensuring autonomy for all users.
- **New Command**: Added `/cybersecurity` for direct offensive security audits via Perseus.
- **Universal FinOps Skill**: Created `saas-finops-optimization` specifically for Vercel, Supabase, Neon, and AI Token management.

### Changed
- **Master Orchestrator Update**: Enhanced `galyarder-specialist` to support the expanded 5-phase pipeline including Legal, Finance, and Advanced Intel.
- **Security Guardian Enhancement**: Added localized incident response and recovery protocols.

## [1.0.0] - 2026-04-04

### Added
- **Initial Release**: Full restoration of the high-rigor engineering agents (TDD, Architecture, Systematic Debugging).
- **1-Man Army C-Suite**: Added 13 specialized agents including Product Manager, DevOps Engineer, Revenue Architect, Conversion Engineer, and Social Strategist.
- **Elite Skills Injection**: Integrated 40+ high-fidelity skills for SEO, CRO, Marketing, and Monetization.
- **Remotion Integration**: Built-in React video engine workspace in `/remotion` for programmatic marketing assets.
- **Linear Integration**: Automated issue mapping and lifecycle tracking directly from PRDs.
- **Multi-Platform Support**: Native compatibility for Claude Code, Cursor, Copilot CLI, Gemini CLI, and OpenCode.
- **MCP Stack Optimization**: Pre-configured support for Context7, Linear, Stitch, BrowserOS, and Sequential Thinking.
- **Token Economy**: Implementation of the `rtk` (Rust Token Killer) prefix requirement for all terminal operations.
ns.
