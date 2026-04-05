# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
