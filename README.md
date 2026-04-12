<p align="center">
  <img src="public/header.jpg" width="600" alt="Galyarder Framework">
</p>

<h1 align="center">Galyarder Framework</h1>

<p align="center">Agentic Skills & Agent Framework for AI Assistants</p>

<p align="center">
  Galyarder Framework provides <strong>40 specialized agents</strong> and <strong>132 production-ready skills</strong> for AI assistants.<br>
  Install in Claude Code, Cursor, Gemini, Codex, or any agentic tool and get a full workforce of specialized agents<br>
  covering engineering, security, growth, legal, and more.
</p>

<p align="center">Built for the <strong>1-Man Army</strong> — one founder with the leverage of an entire company.</p>

---

## How it works

It starts from the moment you fire up your coding agent. As soon as it sees that you're building something, it *doesn't* just jump into trying to write code. Instead, it steps back and asks you what you're really trying to do. 

Once it's teased a spec out of the conversation, it shows it to you in chunks short enough to actually read and digest. 

After you've signed off on the design, your agent puts together an implementation plan that's clear enough for an enthusiastic junior engineer with poor taste, no judgement, no project context, and an aversion to testing to follow. It emphasizes true red/green TDD, YAGNI (You Aren't Gonna Need It), and DRY. 

Next up, once you say "go", it launches a *subagent-driven-development* process, routing each engineering task through the host's available delegation model while preserving the same review and orchestration workflow. On some hosts this appears as named agent dispatch; on others it is implemented through native subagents using Galyarder role prompts. It's not uncommon for Claude to be able to work autonomously for a couple hours at a time without deviating from the plan you put together.

Finally, Galyarder Framework shifts into **Marketing Mode**, triggering skills for SEO, CRO, and Remotion (Video) to ensure what you built actually achieves market fit.

There's a bunch more to it, but that's the core of the system. The workflow philosophy stays consistent across hosts, while runtime mechanics such as installation, command invocation, and subagent dispatch vary by platform. Once installed correctly for your host, your coding agent can follow the same Galyarder workflow.

## Sponsorship

If Galyarder Framework has helped you do stuff that makes money and you are so inclined, I'd greatly appreciate it if you'd consider [sponsoring my opensource work](https://github.com/sponsors/galyarderlabs).

Thanks! 

- Galyarder Labs

## Installation

Galyarder is a multi-platform agent framework with host-specific installation and runtime adapters. Installation varies by platform:

### Claude Code / Copilot CLI

Register the Galyarder marketplace first:

```bash
/plugin marketplace add galyarderlabs/galyarder-framework
```

Then install the plugin:

```bash
/plugin install galyarder-framework@galyarderlabs-marketplace
```

### Cursor (via Plugin Marketplace)

In Cursor Agent chat, install from marketplace:

```text
/add-plugin galyarder-framework
```

### Gemini CLI

Install the extension directly from the repository:

```bash
gemini extensions install https://github.com/galyarderlabs/galyarder-framework
```

To update:

```bash
gemini extensions update galyarder-framework
```

### Codex

Tell Codex:

```
Fetch and follow instructions from https://raw.githubusercontent.com/galyarderlabs/galyarder-framework/refs/heads/main/.codex/INSTALL.md
```

**Detailed docs:** [docs/README.codex.md](docs/README.codex.md)

### OpenCode

Tell OpenCode:

```
Fetch and follow instructions from https://raw.githubusercontent.com/galyarderlabs/galyarder-framework/refs/heads/main/.opencode/INSTALL.md
```

**Detailed docs:** [docs/README.opencode.md](docs/README.opencode.md)

## Recommended MCP Stack

For peak "1-Man Army" efficiency, we recommend the following MCP servers:

- **[[RTK](https://github.com/rtk-ai/rtk)]**: Mandatory proxy for all shell commands to save 60-90% tokens.
- **[[Linear](https://linear.app/docs/mcp)]**: For real-time project management and issue tracking.
- **[[Stitch](https://stitch.withgoogle.com/docs/mcp/setup)]**: For rapid UI generation and design token management.
- **[[BrowserOS](https://docs.browseros.com/features/use-with-claude-code)]**: For automated browser testing and external service integration.
- **[[Context7](https://context7.com/docs/resources/all-clients)]**: For up-to-date documentation and API references.
- **[[Sequential Thinking](https://mcpservers.org/servers/modelcontextprotocol/sequentialthinking)]**: For deconstructing complex architectural problems.

## What's Inside

### Two Deployment Options

**Option 1: Standalone (Chat-Based)**
- Install Framework in AI assistant (Claude Code, Cursor, Gemini)
- Chat directly with galyarder-specialist
- Agents execute through conversation
- Tasks tracked in Linear (optional)
- Reports in Obsidian (optional)

**With Dashboard (Galyarder HQ)**

For visual management, connect Framework to [Galyarder HQ](https://github.com/galyarderlabs/galyarder-hq) — the control plane for running AI-native companies.

### Organization Structure

Galyarder Framework operates as a **digital company** with clear departments and reporting lines:

- **Executive:** galyarder-specialist (CEO/Orchestrator)
- **Founder Office:** fundraising-operator (Capital & investor relations)
- **Product:** product-manager, planner (Requirements & roadmap)
- **Engineering:** super-architect, elite-developer, qa-automation-engineer (Implementation & quality)
- **Security:** security-guardian, perseus, cyber-intel (Threat analysis & pentesting)
- **Growth:** growth-strategist, conversion-engineer, retention-specialist (Acquisition & retention)
- **Operations:** devops-engineer, release-manager (Infrastructure & deployment)
- **Legal/Finance:** legal-counsel, finops-manager (Compliance & cost optimization)
- **Knowledge:** obsidian-architect (Documentation & memory)

See [Organization Chart](docs/ORG_CHART.md) for full structure.

### Agents

Galyarder Framework distributes tasks to specialized C-Suite agents as well as deep engineering engines.

**The C-Suite (1-Man Army Edition)**
- **`galyarder-specialist`** - Master workflow manager and orchestrator.
- **`obsidian-architect`** - Digital Garden & Visual Architect. Manages Canvas mapping, technical KB, and automated journaling.
- **`product-manager`** - Linear ticket management and ROI prioritization.
- **`analytics-architect`** - Tracking schema and KPI enforcement.
- **`finops-manager`** - Cloud cost optimization and pricing strategy.
- **`legal-counsel`** - TOS/Privacy, GDPR audit, and AI governance.
- **`super-architect`** - System design and Vertical Slice planning.
- **`interface-designer`** - Module interface and API design specialist.
- **`ui-ux-designer`** - UI generation via **Stitch** and design system enforcement.
- **`experimentation-engineer`** - A/B testing and statistical evidence.
- **`elite-developer`** - Implementation, TDD, and complex debugging.
- **`vercel-react-expert`** - React/Next.js and Vercel performance optimization.
- **`qa-automation-engineer`** - Live auditing and E2E testing via **BrowserOS**.
- **`security-guardian`** - Zero-trust security audits, IDOR/SSRF remediation.
- **`perseus`** - Advanced offensive security, red teaming, and pentesting.
- **`cyber-intel`** - External threat intelligence and data leak monitoring.
- **`devops-engineer`** - CI/CD, Docker, and zero-downtime deployment.
- **`revenue-architect`** - Monetization and pricing strategy.
- **`conversion-engineer`** - Onboarding CRO and paywall optimization.
- **`growth-engineer`** - Engineering-as-marketing and referral loops.
- **`growth-strategist`** - SEO dominance and high-signal copywriting.
- **`retention-specialist`** - LTV, CRM, and psychological onboarding.
- **`social-strategist`** - Social media and distribution hype.
- **`remotion-engineer`** - Programmatic video generation using React.
- **`release-manager`** - Versioning, changelogs, and launch orchestration.
- **`support-lead`** - User education, FAQ automation, and troubleshooting.

**New Agents (v1.6.0)**
- **`mcp-builder`** - MCP server development specialist. Builds tools that extend AI agent capabilities.
- **`sre`** - Site reliability engineering. SLOs, error budgets, observability, toil reduction.
- **`chief-of-staff`** - Founder coordination. Filters noise, routes decisions, owns the space between functions.
- **`rapid-prototyper`** - Ultra-fast POC and MVP. Validates ideas before they become expensive commitments.
- **`sales-engineer`** - Pre-sales technical specialist. Wins the technical decision before the deal closes.

**Engineering Engines**
- **architect**, **build-error-resolver**, **code-reviewer**, **doc-updater**, **e2e-runner**, **planner**, **refactor-cleaner**, **security-reviewer**, **tdd-guide**.

### Commands

Galyarder Framework provides short-hand commands for rapid execution:
- **/brainstorm** - Socratic design refinement and intent exploration.
- **/plan** - Initialize implementation planning with vertical slices.
- **/tdd** - Start a test-driven development session.
- **/review** - Perform a principal-level code review.
- **/cybersecurity** - Advanced offensive security audit and attack simulation.
- **/analytics** - Design tracking schemas and define KPIs.
- **/finops** - Audit cloud costs and AI token efficiency.
- **/legal** - Generate TOS/Privacy and audit compliance.
- **/release** - Manage versioning and launch orchestration.
- **/build-fix** - Systematically fix build and type errors.
- **/triage** - Diagnose bugs and create reproduction fix plans.
- **/marketing** - Optimize copy and growth strategies.
- **/video** - Generate programmatic marketing videos.
- **/deploy** - Automate infrastructure and deployment.
- **/seo** - Audit SEO and inject schema markup.
- **/cro** - Optimize onboarding and paywall funnels.
- **/docs** - Update project documentation and codemaps.
- **/e2e** - Generate and run end-to-end user journey tests.
- **/clean** - Remove dead code and refactor for maintainability.

Command UX depends on the host. Some platforms expose these as native slash
commands or plugin commands, while others map them through host-specific config
or prompting conventions. Check the platform-specific install docs for the exact
invocation model.

### Skills Library

- **Elite Design Collection**: 50+ high-fidelity `DESIGN.md` specifications from industry leaders (Vercel, Stripe, Linear, etc.) located in `rules/design/`.
- **Security & Intel**: `executing-red-team-exercise`, `monitoring-darkweb-sources`, `tracking-threat-actor-infrastructure`, `testing-for-xss-vulnerabilities-with-burpsuite`.
- **Business & Legal**: `legal-tos-privacy`, `gdpr-compliance`, `iso-42001-ai-governance`, `saas-finops-optimization`, `finance-based-pricing-advisor`.
- **Founder & Fundraising**: `founder-context`, `pitch-deck`, `investor-research`, `fundraising-email`, `data-room`, `board-update`, `accelerator-application`, `market-research`, `lead-scoring`, `founder-thought-leadership`.
- **Testing & Debugging**: `test-driven-development` (RED-GREEN-REFACTOR cycle), `systematic-debugging` (4-phase root cause), `verification-before-completion`.
- **Growth & Marketing**: `seo-audit`, `schema-markup`, `onboarding-cro`, `marketing-psychology`, `copywriting`, `viral-referral-loops`.
- **Product Management**: `linear-ticket-management`, `prd-to-plan`, `prd-to-issues`, `write-a-prd`, `ubiquitous-language`.
- **Collaboration & Documentation**: `brainstorming`, `writing-plans`, `executing-plans`, `subagent-driven-development`, `obsidian-cli`, `json-canvas`, `obsidian-bases`, `obsidian-markdown`, `defuddle`.
- **Video & Content**: `remotion-best-practices`, `video-generation`, `email-sequence`.
- **Meta**: `writing-skills`, `using-galyarder-framework`.

## Philosophy

- **Test-Driven Development** — Write tests first, always.
- **Context Economy** — Use `rtk` proxy for all terminal operations.
- **Math Over Magic** — Base decisions on data, ROI, and psychological leverage.
- **Code to Market** — Code is a liability until it achieves market fit.

## Contributing

Skills live directly in this repository. To contribute:

1. Fork the repository.
2. Create a branch for your skill.
3. Follow the `writing-skills` skill for creating and testing new skills.
4. Submit a PR.

See `skills/writing-skills/SKILL.md` for the complete guide.

## Galyarder HQ

For visual management of your AI workforce, connect Framework to [Galyarder HQ](https://github.com/galyarderlabs/galyarder-hq) — the control plane for running AI-native companies.

Galyarder HQ provides:
- Web UI for company management
- Visual org chart
- Task monitoring and assignment
- Cost tracking and budget enforcement
- Multi-company support
- Heartbeat-based autonomous execution

Framework works standalone OR with Galyarder HQ. Your choice.

## Updating

Skills update automatically when you update the plugin:

**Claude Code / Copilot CLI:**
```bash
/plugin update galyarder-framework@galyarderlabs-marketplace
```

**Gemini CLI:**
```bash
gemini extensions update galyarder-framework
```

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Support

- **Issues**: https://github.com/galyarderlabs/galyarder-framework/issues
- **Marketplace**: https://github.com/galyarderlabs/galyarder-framework
