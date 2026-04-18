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

<p align="center">Built for the <strong>1-Man Army</strong>  one founder with the leverage of an entire company.</p>

---

## How it works

It starts from the moment you fire up your coding agent. As soon as it sees that you're building something, it *doesn't* just jump into trying to write code. Instead, it steps back and asks you what you're really trying to do. 

Once it's teased a spec out of the conversation, it shows it to you in chunks short enough to actually read and digest. 

After you've signed off on the design, your agent puts together an implementation plan that's clear enough for an enthusiastic junior engineer with poor taste, no judgement, no project context, and an aversion to testing to follow. It emphasizes true red/green TDD, YAGNI (You Aren't Gonna Need It), and DRY. 

Next up, once you say "go", it launches a *subagent-driven-development* process, routing each engineering task through the host's available delegation model while preserving the same review and orchestration workflow. 

This is the **Humans 3.0** protocol in action: the distilled cognitive machinery of humanity's apex operatorssurgically stripped of emotional overhead, hope, and biological fatigueexecuting with deterministic, mathematical precision. It's not uncommon for Claude to be able to work autonomously for a couple hours at a time without deviating from the plan you put together.

Finally, Galyarder Framework shifts into **Marketing Mode**, triggering skills for SEO, CRO, and Remotion (Video) to ensure what you built actually achieves market fit.

There's a bunch more to it, but that's the core of the system. The workflow philosophy stays consistent across hosts, while runtime mechanics such as installation, command invocation, and subagent dispatch vary by platform. Once installed correctly for your host, your coding agent can follow the same Galyarder Framework workflow.

## Sponsorship

If Galyarder Framework has helped you do stuff that makes money and you are so inclined, I'd greatly appreciate it if you'd consider [sponsoring my opensource work](https://github.com/sponsors/galyarderlabs).

Thanks! 

- Galyarder Labs

## Installation

Galyarder Framework is a multi-platform agent framework. For primary platforms, use the official Marketplace/Extension systems. For other tools, use the Galyarder Labs conversion engine.

### 1. Claude Code / Copilot CLI (Official Marketplace)

Standard installation for AI assistants:

```bash
/plugin marketplace add galyarderlabs/galyarder-framework
```

Then install specific domain plugins:

```bash
/plugin install core-agents@galyarderlabs-marketplace       # All 40 operational agents
/plugin install executive-personas@galyarderlabs-marketplace  # 4 High-fidelity directors
/plugin install design-skills@galyarderlabs-marketplace      # 54 Design system specs
/plugin install master-skills@galyarderlabs-marketplace      # 132 Framework skills
```

### 2. Gemini CLI (Official Extension)

Install the full framework:

```bash
gemini extensions install https://github.com/galyarderlabs/galyarder-framework
```

Or install specific domains:

```bash
gemini extensions install https://github.com/galyarderlabs/galyarder-framework/tree/main/agents
gemini extensions install https://github.com/galyarderlabs/galyarder-framework/tree/main/personas
gemini extensions install https://github.com/galyarderlabs/galyarder-framework/tree/main/design
gemini extensions install https://github.com/galyarderlabs/galyarder-framework/tree/main/skills
```

### 3. OpenAI Codex (Official Instructions)

Tell Codex:

```
Fetch and follow instructions from https://raw.githubusercontent.com/galyarderlabs/galyarder-framework/refs/heads/main/.codex/INSTALL.md
```

### 4. Multi-Platform Conversion Engine (Cursor, Aider, Windsurf, etc.)

For platforms without a central marketplace or for **Internal Galyarder Labs Development**, use the conversion engine:

```bash
# 1. Initialize digital company structure
./scripts/scaffold-company.sh

# 2. Convert and install for your specific tool
./scripts/install.sh --tool <cursor|aider|windsurf|opencode|kilocode|augment|antigravity|openclaw|hermes>
```

---

## Technical Integrity: The Karpathy Principles

Galyarder Framework enforces rigid adherence to the following engineering principles to combat AI slop:

1. **Think Before Coding**: Do not guess. If uncertain, STOP and ASK. State assumptions explicitly and surface tradeoffs before implementation.
2. **Simplicity First**: Implement the minimum code required to solve the immediate problem. Reject speculative abstractions and unused configurability.
3. **Surgical Changes**: Modify ONLY what is necessary to fulfill the request. Match existing conventions perfectly. Do not perform adjacent refactoring or unrelated edits.
4. **Goal-Driven Execution**: Define success criteria via test-driven development before writing code. Loop until empirical verification is achieved.

---

## Recommended MCP Stack

For peak "1-Man Army" efficiency, we recommend the following MCP servers:

- [[RTK](https://github.com/rtk-ai/rtk)]: Mandatory proxy for all shell commands to save 60-90% tokens.
- [[Linear](https://linear.app/docs/mcp)]: For real-time project management and issue tracking.
- [[Stitch](https://stitch.withgoogle.com/docs/mcp/setup)]: For rapid UI generation and design token management.
- [[BrowserOS](https://docs.browseros.com/features/use-with-claude-code)]: For automated browser testing and external service integration.
- [[Context7](https://context7.com/docs/resources/all-clients)]: For up-to-date documentation and API references.
- [[Sequential Thinking](https://mcpservers.org/servers/modelcontextprotocol/sequentialthinking)]: For deconstructing complex architectural problems.

---

## What's Inside

### Two Deployment Options

**Option 1: Standalone (Chat-Based)**
- Install Galyarder Framework in AI assistant (Claude Code, Cursor, Gemini)
- Chat directly with galyarder-specialist
- Agents execute through conversation
- Tasks tracked in Linear (optional)
- Reports in Obsidian (optional)

**With Dashboard (Galyarder HQ)**

For visual management, connect Galyarder Framework to [Galyarder HQ](https://github.com/galyarderlabs/galyarder-hq)  the control plane for running AI-native companies.

### Organization Structure

Galyarder Framework operates as a digital company with clear departments and reporting lines:

- **Executive:** galyarder-ceo (Persona), galyarder-specialist (Orchestrator)
- **Technical (CTO Office):** galyarder-cto (Persona), Engineering, Product, Security.
- **Growth (CMO Office):** galyarder-cmo (Persona), Marketing, SEO, Sales.
- **Operations (CFO/COO Office):** galyarder-cfo-coo (Persona), Legal, Finance, Compliance.
- **Knowledge:** obsidian-architect (Documentation & memory)

See [Organization Chart](docs/ORG_CHART.md) for full structure.

### Agents

Galyarder Framework distributes tasks to specialized C-Suite agents as well as deep engineering engines.

**The C-Suite (1-Man Army Edition)**
- **`galyarder-ceo`** - Chief Executive Officer. Strategic vision and master delegation.
- **`galyarder-cto`** - Chief Technology Officer. Technical integrity and architecture.
- **`galyarder-cmo`** - Chief Marketing Officer. Growth and distribution alchemist.
- **`galyarder-cfo-coo`** - Chief Financial & Operating Officer. Efficiency and compliance.
- **`galyarder-specialist`** - Master workflow manager and orchestrator.
- **`obsidian-architect`** - Digital Garden & Visual Architect. Manages Canvas mapping and journaling.
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
- **`mcp-builder`** - MCP server development specialist.
- **`sre`** - Site reliability engineering. SLOs, error budgets, toil reduction.
- **`chief-of-staff`** - Founder coordination and cross-functional processes.
- **`rapid-prototyper`** - Ultra-fast POC and MVP validation.
- **`sales-engineer`** - Pre-sales technical specialist.

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

### Skills Library

- **Elite Design Collection**: 50+ high-fidelity DESIGN.md specifications (Vercel, Stripe, Linear).
- **Security & Intel**: executing-red-team-exercise, monitoring-darkweb-sources, tracking-threat-actor-infrastructure.
- **Business & Legal**: legal-tos-privacy, gdpr-compliance, iso-42001-ai-governance, saas-finops-optimization.
- **Founder & Fundraising**: founder-context, pitch-deck, investor-research, fundraising-email, data-room, board-update.
- **Testing & Debugging**: test-driven-development, systematic-debugging, verification-before-completion.
- **Growth & Marketing**: seo-audit, schema-markup, onboarding-cro, marketing-psychology, copywriting.
- **Product Management**: linear-ticket-management, prd-to-plan, prd-to-issues, write-a-prd.
- **Collaboration & Documentation**: brainstorming, writing-plans, executing-plans, subagent-driven-development.
- **Meta**: writing-skills, using-galyarder-framework.

## Philosophy

- **Test-Driven Development**  Write tests first, always.
- **Context Economy**  Use rtk proxy for all terminal operations.
- **Math Over Magic**  Base decisions on data, ROI, and psychological leverage.
- **Code to Market**  Code is a liability until it achieves market fit.

## Galyarder HQ

For visual management of your AI workforce, connect Galyarder Framework to [Galyarder HQ](https://github.com/galyarderlabs/galyarder-hq).

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Support

- **Issues**: https://github.com/galyarderlabs/galyarder-framework/issues
- **Marketplace**: https://github.com/galyarderlabs/galyarder-framework

---
 2026 Galyarder Labs. Galyarder Framework. Engineering. Marketing. Distribution.
