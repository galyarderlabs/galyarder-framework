<p align="center">
  <img src="public/logo.png" width="200" alt="Galyarder Agent Framework Logo">
</p>

# Galyarder Agent Framework

Galyarder Agent Framework is a high-fidelity cognitive layer designed to transform standard AI coding assistants into a multi-disciplinary, autonomous workforce. It unifies elite software engineering, behavioral marketing psychology, and strategic product orchestration into a single, cohesive system.

Built for the **1-Man Army** (Solo Founder), Galyarder enforces a strict lifecycle that ensures what you build is mathematically sound, production-ready, and optimized for market success.

## How it works

It starts from the moment you fire up your coding agent. As soon as it sees that you're building something, it *doesn't* just jump into trying to write code. Instead, it steps back and asks you what you're really trying to do. 

Once it's teased a spec out of the conversation, it shows it to you in chunks short enough to actually read and digest. 

After you've signed off on the design, your agent puts together an implementation plan that's clear enough for an enthusiastic junior engineer with poor taste, no judgement, no project context, and an aversion to testing to follow. It emphasizes true red/green TDD, YAGNI (You Aren't Gonna Need It), and DRY. 

Next up, once you say "go", it launches a *subagent-driven-development* process, having agents work through each engineering task, inspecting and reviewing their work, and continuing forward. It's not uncommon for Claude to be able to work autonomously for a couple hours at a time without deviating from the plan you put together.

Finally, Galyarder Agent Framework shifts into **Marketing Mode**, triggering skills for SEO, CRO, and Remotion (Video) to ensure what you built actually achieves market fit.

There's a bunch more to it, but that's the core of the system. And because the skills trigger automatically, you don't need to do anything special. Your coding agent just has Galyarder Agent Framework.

## Sponsorship

If Galyarder Agent Framework has helped you do stuff that makes money and you are so inclined, I'd greatly appreciate it if you'd consider [sponsoring my opensource work](https://github.com/sponsors/galyarderlabs).

Thanks! 

- Galyarder Labs

## Installation

Galyarder is a multi-platform plugin system. Installation varies by platform:

### Claude Code / Copilot CLI

Register the Galyarder marketplace first:

```bash
/plugin marketplace add galyarderlabs/galyarder-agent-framework
```

Then install the plugin:

```bash
/plugin install galyarder-agent-framework@galyarderlabs-marketplace
```

### Cursor (via Plugin Marketplace)

In Cursor Agent chat, install from marketplace:

```text
/add-plugin galyarder-agent-framework
```

### Gemini CLI

Install the extension directly from the repository:

```bash
gemini extensions install https://github.com/galyarderlabs/galyarder-agent-framework
```

To update:

```bash
gemini extensions update galyarder-agent-framework
```

### Codex

Tell Codex:

```
Fetch and follow instructions from https://raw.githubusercontent.com/galyarderlabs/galyarder-agent-framework/refs/heads/main/.codex/INSTALL.md
```

**Detailed docs:** [docs/README.codex.md](docs/README.codex.md)

### OpenCode

Tell OpenCode:

```
Fetch and follow instructions from https://raw.githubusercontent.com/galyarderlabs/galyarder-agent-framework/refs/heads/main/.opencode/INSTALL.md
```

**Detailed docs:** [docs/README.opencode.md](docs/README.opencode.md)

## Recommended MCP Stack

For peak "1-Man Army" efficiency, we recommend the following MCP servers:

- **[[RTK (Rust Token Killer)](https://github.com/rtk-ai/rtk)]**: Mandatory proxy for all shell commands to save 60-90% tokens.
- **[[Linear](https://linear.app/docs/mcp)]**: For real-time project management and issue tracking.
- **[[Stitch](https://stitch.withgoogle.com/docs/mcp/setup)]**: For rapid UI generation and design token management.
- **[[BrowserOS](https://docs.browseros.com/features/use-with-claude-code)]**: For automated browser testing and external service integration.
- **[[Context7](https://context7.com/docs/resources/all-clients)]**: For up-to-date documentation and API references.
- **[[Sequential Thinking](https://mcpservers.org/servers/modelcontextprotocol/sequentialthinking)]**: For deconstructing complex architectural problems.
- **[[Neon](https://github.com/neondatabase/mcp-server-neon)] / [[Supabase](https://supabase.com/docs/guides/getting-started/mcp)]**: For serverless database management.
- **[[PostHog](https://posthog.com/docs/model-context-protocol)]**: For product analytics and event tracking.

## What's Inside

### Agents

Galyarder Agent Framework distributes tasks to specialized C-Suite agents as well as deep engineering engines.

**The C-Suite (Solo Founder Edition)**
- **`galyarder-specialist`** - Master workflow manager and orchestrator.
- **`product-manager`** - Linear ticket management and ROI prioritization.
- **`super-architect`** - System design and Vertical Slice planning.
- **`interface-designer`** - Module interface and API design specialist.
- **`ui-ux-designer`** - UI generation via **Stitch** and design system enforcement.
- **`elite-developer`** - Implementation, TDD, and complex debugging.
- **`vercel-react-expert`** - React/Next.js and Vercel performance optimization.
- **`qa-automation-engineer`** - Live auditing and E2E testing via **BrowserOS**.
- **`security-guardian`** - Zero-trust security audits, IDOR/SSRF remediation.
- **`devops-engineer`** - CI/CD, Docker, and zero-downtime deployment.
- **`revenue-architect`** - Monetization and pricing strategy.
- **`growth-strategist`** - Conversion optimization and SEO.
- **`social-strategist`** - Social media and distribution hype.
- **`remotion-engineer`** - Programmatic video generation using React.

**Engineering Engines**
- **architect**, **build-error-resolver**, **code-reviewer**, **doc-updater**, **e2e-runner**, **planner**, **refactor-cleaner**, **security-reviewer**, **tdd-guide**.

### Commands

Galyarder Agent Framework provides short-hand commands for rapid execution:
- **/brainstorm** - Socratic design refinement and intent exploration.
- **/plan** - Initialize implementation planning with vertical slices.
- **/tdd** - Start a test-driven development session.
- **/review** - Perform a principal-level code review.
- **/build-fix** - Systematically fix build and type errors.
- **/triage** - Diagnose bugs and create reproduction fix plans.
- **/linear** - Sync PRDs and ideas to Linear tickets.
- **/marketing** - Optimize copy and growth strategies.
- **/video** - Generate programmatic marketing videos.
- **/deploy** - Automate infrastructure and deployment.
- **/seo** - Audit SEO and inject schema markup.
- **/cro** - Optimize onboarding and paywall funnels.
- **/docs** - Update project documentation and codemaps.
- **/e2e** - Generate and run end-to-end user journey tests.
- **/clean** - Remove dead code and refactor for maintainability.

### Skills Library

- **Elite Design Collection**: 50+ high-fidelity `DESIGN.md` specifications from industry leaders (Vercel, Stripe, Linear, etc.) located in `rules/design/`.
- **Testing**: `test-driven-development` (RED-GREEN-REFACTOR cycle), `testing-anti-patterns`.
- **Debugging**: `systematic-debugging` (4-phase root cause), `verification-before-completion`, `defense-in-depth`.
- **Collaboration**: `brainstorming`, `writing-plans`, `executing-plans`, `subagent-driven-development`, `dispatching-parallel-agents`.
- **Engineering Excellence**: `vercel-react-best-practices`, `web-design-guidelines`, `code-review-expert`, `interface-designer`.
- **Growth & Marketing**: `seo-audit`, `schema-markup`, `onboarding-cro`, `marketing-psychology`, `copywriting`, `paywall-upgrade-cro`, `audit-website`, `copy-editing`, `launch-strategy`.
- **Product Management**: `linear-ticket-management`, `prd-to-plan`, `prd-to-issues`, `write-a-prd`, `ubiquitous-language`.
- **Video**: `remotion-best-practices`, `video-generation`.
- **Meta**: `writing-skills`, `using-galyarder-agent-framework`.

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

## Updating

Skills update automatically when you update the plugin:

**Claude Code / Copilot CLI:**
```bash
/plugin update galyarder-agent-framework@galyarderlabs-marketplace
```

**Gemini CLI:**
```bash
gemini extensions update galyarder-agent-framework
```

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Support

- **Issues**: https://github.com/galyarderlabs/galyarder-agent-framework/issues
- **Marketplace**: https://github.com/galyarderlabs/galyarder-agent-framework
