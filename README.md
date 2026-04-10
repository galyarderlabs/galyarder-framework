<p align="center">
  <img src="framework/public/logo.png" width="200" alt="Galyarder Logo">
</p>

# GALYARDER FRAMEWORK

**Digital Company Operating System for Solo Founders**

Galyarder Framework transforms AI coding assistants into a fully structured, autonomous workforce. It provides **35 specialized agents** and **132 execution-grade skills** across the full product lifecycle — from fundraising and product strategy to engineering, security, growth, and legal compliance.

This repository combines two powerful systems:

1. **Galyarder Framework** - Agent workforce and skills library for AI coding assistants
2. **Galyarder Dashboard** - Visual control plane for managing AI companies at scale

Built for the **1-Man Army** - one founder with the leverage of an entire company.

## How it works

It starts from the moment you fire up your coding agent. As soon as it sees that you're building something, it *doesn't* just jump into trying to write code. Instead, it steps back and asks you what you're really trying to do. 

Once it's teased a spec out of the conversation, it shows it to you in chunks short enough to actually read and digest. 

After you've signed off on the design, your agent puts together an implementation plan that's clear enough for an enthusiastic junior engineer with poor taste, no judgement, no project context, and an aversion to testing to follow. It emphasizes true red/green TDD, YAGNI (You Aren't Gonna Need It), and DRY. 

Next up, once you say "go", it launches a *subagent-driven-development* process, routing each engineering task through the host's available delegation model while preserving the same review and orchestration workflow. On some hosts this appears as named agent dispatch; on others it is implemented through native subagents using Galyarder role prompts. It's not uncommon for Claude to be able to work autonomously for a couple hours at a time without deviating from the plan you put together.

Finally, Galyarder Framework shifts into **Marketing Mode**, triggering skills for SEO, CRO, and Remotion (Video) to ensure what you built actually achieves market fit.

There's a bunch more to it, but that's the core of the system. The workflow philosophy stays consistent across hosts, while runtime mechanics such as installation, command invocation, and subagent dispatch vary by platform. Once installed correctly for your host, your coding agent can follow the same Galyarder workflow.

## Two Ways to Use

### Option 1: Standalone Framework (Chat-Based)

Install Framework directly in your AI coding assistant and work through conversation:

- Chat directly with galyarder-specialist
- Agents execute through conversation
- Tasks tracked in Linear (optional)
- Reports in Obsidian (optional)
- No server required

**Best for:** Individual developers who want AI assistance in their existing workflow.

### Option 2: Dashboard + Framework (Web Platform)

Run the complete platform with visual management and orchestration:

- Visual web UI for company management
- Hire agents from Framework library
- Monitor execution in real-time
- Database-backed persistence
- Multi-company support with data isolation
- Heartbeat-based autonomous execution
- Cost tracking and budget enforcement
- Mobile-ready monitoring

**Best for:** Managing multiple AI companies, teams, or running autonomous operations 24/7.

## Galyarder Framework

The Framework provides the agent workforce and skills library.

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

See [Organization Chart](framework/docs/ORG_CHART.md) for full structure.

### Agents

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

Command UX depends on the host. Some platforms expose these as native slash commands or plugin commands, while others map them through host-specific config or prompting conventions. Check the platform-specific install docs for the exact invocation model.

### Skills Library

- **Elite Design Collection**: 50+ high-fidelity `DESIGN.md` specifications from industry leaders (Vercel, Stripe, Linear, etc.) located in `framework/design/`.
- **Security & Intel**: `executing-red-team-exercise`, `monitoring-darkweb-sources`, `tracking-threat-actor-infrastructure`, `testing-for-xss-vulnerabilities-with-burpsuite`.
- **Business & Legal**: `legal-tos-privacy`, `gdpr-compliance`, `iso-42001-ai-governance`, `saas-finops-optimization`, `finance-based-pricing-advisor`.
- **Founder & Fundraising**: `founder-context`, `pitch-deck`, `investor-research`, `fundraising-email`, `data-room`, `board-update`, `accelerator-application`, `market-research`, `lead-scoring`, `founder-thought-leadership`.
- **Testing & Debugging**: `test-driven-development` (RED-GREEN-REFACTOR cycle), `systematic-debugging` (4-phase root cause), `verification-before-completion`.
- **Growth & Marketing**: `seo-audit`, `schema-markup`, `onboarding-cro`, `marketing-psychology`, `copywriting`, `viral-referral-loops`.
- **Product Management**: `linear-ticket-management`, `prd-to-plan`, `prd-to-issues`, `write-a-prd`, `ubiquitous-language`.
- **Collaboration & Documentation**: `brainstorming`, `writing-plans`, `executing-plans`, `subagent-driven-development`, `obsidian-cli`, `json-canvas`, `obsidian-bases`, `obsidian-markdown`, `defuddle`.
- **Video & Content**: `remotion-best-practices`, `video-generation`, `email-sequence`.
- **Meta**: `writing-skills`, `using-galyarder-framework`.

### Philosophy

- **Test-Driven Development** — Write tests first, always.
- **Context Economy** — Use `rtk` proxy for all terminal operations.
- **Math Over Magic** — Base decisions on data, ROI, and psychological leverage.
- **Code to Market** — Code is a liability until it achieves market fit.

## Galyarder Dashboard

The Dashboard provides a visual control plane for managing AI companies at scale.

### Core Features

**Company Management**
- Create and manage multiple AI companies
- Each company has isolated data, agents, and budgets
- Company-scoped access control

**Agent Orchestration**
- Hire agents from Framework library or external adapters
- Visual org chart showing agent hierarchy
- Assign agents to departments and roles
- Configure agent capabilities and permissions

**Task Management**
- Create issues and assign to agents
- Track task status and execution history
- View agent activity in real-time
- Atomic checkout semantics (one agent per task)

**Cost Control**
- Track token usage per company, agent, and task
- Set budget limits with auto-pause on overspend
- Cost projections and burn rate monitoring
- Detailed cost breakdowns

**Autonomous Execution**
- Heartbeat-based agent execution (agents work 24/7)
- Configurable execution intervals
- Automatic task pickup and completion
- Activity logging for all mutations

**Multi-Adapter Support**
- Framework adapter (35 agents + 132 skills)
- Claude, Cursor, Codex, Gemini adapters
- External adapter plugin system
- Custom adapter development

### Architecture

```
galyarder-framework/              # Root = Dashboard
├── framework/                    # Framework (35 agents + 132 skills)
│   ├── agents/                   # Agent definitions (.md)
│   ├── skills/                   # Skill implementations (132 dirs)
│   ├── design/                   # Design specs
│   └── docs/                     # Framework documentation
├── packages/
│   ├── adapters/
│   │   └── galyarder-framework/  # Framework → Dashboard adapter
│   ├── db/                       # Database schema (Drizzle)
│   ├── shared/                   # Shared types and validators
│   └── adapter-utils/            # Adapter utilities
├── server/                       # Express REST API
├── ui/                           # React + Vite board UI
├── cli/                          # Dashboard CLI
└── doc/                          # Dashboard documentation
```

### Technology Stack

**Backend**
- Express.js REST API
- Drizzle ORM with PostgreSQL
- PGlite for embedded dev database
- TypeScript throughout

**Frontend**
- React + Vite
- TanStack Query for data fetching
- Tailwind CSS for styling
- Radix UI components

**Database**
- PostgreSQL in production
- PGlite (embedded) in development
- Drizzle migrations

**Adapters**
- Plugin system for external adapters
- Dynamic loading from `~/.galyarder/adapter-plugins.json`
- Type-safe adapter contracts

## Installation

### Standalone Framework

Install Framework directly in your AI coding assistant:

#### Claude Code / Copilot CLI

```bash
/plugin marketplace add galyarderlabs/galyarder-framework
/plugin install galyarder-framework@galyarderlabs-marketplace
```

#### Cursor

```text
/add-plugin galyarder-framework
```

#### Gemini CLI

```bash
gemini extensions install https://github.com/galyarderlabs/galyarder-framework
```

#### Codex

```
Fetch and follow instructions from https://raw.githubusercontent.com/galyarderlabs/galyarder-framework/refs/heads/main/.codex/INSTALL.md
```

**Detailed docs:** [framework/docs/README.codex.md](framework/docs/README.codex.md)

#### OpenCode

```
Fetch and follow instructions from https://raw.githubusercontent.com/galyarderlabs/galyarder-framework/refs/heads/main/.opencode/INSTALL.md
```

**Detailed docs:** [framework/docs/README.opencode.md](framework/docs/README.opencode.md)

### Dashboard + Framework

Run the complete platform:

```bash
# 1. Install pnpm (if not installed)
npm install -g pnpm

# 2. Clone repository
git clone https://github.com/galyarderlabs/galyarder-framework.git
cd galyarder-framework

# 3. Install dependencies
pnpm install

# 4. Start Dashboard (uses embedded PGlite in dev)
pnpm dev

# 5. Open browser
# http://localhost:3100
```

**Testing guide:** [TESTING.md](TESTING.md)  
**Development guide:** [doc/DEVELOPING.md](doc/DEVELOPING.md)

## Recommended MCP Stack

For peak "1-Man Army" efficiency, we recommend the following MCP servers:

- **[RTK (Rust Token Killer)](https://github.com/rtk-ai/rtk)** - Mandatory proxy for all shell commands to save 60-90% tokens.
- **[Linear](https://linear.app/docs/mcp)** - For real-time project management and issue tracking.
- **[Stitch](https://stitch.withgoogle.com/docs/mcp/setup)** - For rapid UI generation and design token management.
- **[BrowserOS](https://docs.browseros.com/features/use-with-claude-code)** - For automated browser testing and external service integration.
- **[Context7](https://context7.com/docs/resources/all-clients)** - For up-to-date documentation and API references.
- **[Sequential Thinking](https://mcpservers.org/servers/modelcontextprotocol/sequentialthinking)** - For deconstructing complex architectural problems.
- **[Neon](https://github.com/neondatabase/mcp-server-neon) / [Supabase](https://supabase.com/docs/guides/getting-started/mcp)** - For serverless database management.
- **[PostHog](https://posthog.com/docs/model-context-protocol)** - For product analytics and event tracking.

## Development

```bash
# Install dependencies
pnpm install

# Start Dashboard (dev mode with embedded PGlite)
pnpm dev

# Build everything
pnpm build

# Type checking
pnpm typecheck

# Run tests
pnpm test:run

# Database migrations
pnpm db:generate
pnpm db:migrate
```

See [doc/DEVELOPING.md](doc/DEVELOPING.md) for full development guide.

## Contributing

Skills live directly in this repository. To contribute:

1. Fork the repository.
2. Create a branch for your skill or feature.
3. Follow the `writing-skills` skill for creating and testing new skills.
4. Submit a PR.

See `framework/skills/writing-skills/SKILL.md` for the complete guide.

For Dashboard contributions, see [CONTRIBUTING.md](CONTRIBUTING.md) and [AGENTS.md](AGENTS.md).

## Updating

**Framework (Standalone):**

```bash
# Claude Code / Copilot CLI
/plugin update galyarder-framework@galyarderlabs-marketplace

# Gemini CLI
gemini extensions update galyarder-framework
```

**Dashboard + Framework:**

```bash
git pull origin main
pnpm install
pnpm dev
```

## Sponsorship

If Galyarder Framework has helped you do stuff that makes money and you are so inclined, I'd greatly appreciate it if you'd consider [sponsoring my opensource work](https://github.com/sponsors/galyarderlabs).

Thanks! 

- Galyarder Labs

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Support

- **Issues**: https://github.com/galyarderlabs/galyarder-framework/issues
- **Marketplace**: https://github.com/galyarderlabs/galyarder-framework
