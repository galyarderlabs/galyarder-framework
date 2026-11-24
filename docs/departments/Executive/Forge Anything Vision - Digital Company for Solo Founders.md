# Forge Anything Vision

## Vision
Forge Anything is one whole system for AI agents, for work and for life.

Using an AI agent should not be just generating code, and the agent should not be confused. Forge Anything gives the agent the right rules and the workflow to do the work the right way, so the work is planned, built, checked against evidence, and shipped. The loop ends at distribution. That is the value: rules plus a workflow, in your company, and in your life.

## How it works
The loop is Goal to Ship:

1. **Goal**: say what you want, in plain words.
2. **Plan**: the work gets a plan, with the rules and the workflow that fit it.
3. **Build**: the agent does the work, with tests before anything ships.
4. **Verify**: every claim is checked against evidence before it counts.
5. **Ship**: the work goes out. Distribution is where the loop ends.

The full workflow is in `WORKFLOW.md`.

## What the system is made of
- **Skills**: the rules the agents follow. The scaffold ships a curated essential set; the full repo holds the wider set, which is long-term curation work to bring down to essential only.
- **Agents**: the agents that do the work, with coordinators and department leads.
- **Commands**: shortcuts for common workflows.
- **Hooks**: small checks that run at the right moment in the loop.
- **The `forge` CLI**: scaffolds a project (`forge scaffold`) and serves the MCP server (`forge mcp`).
- **The MCP server**: the distribution. Install the MCP and a chatbot or an agent gets the tools plus the workflow, over stdio, local only, no network.
- **Harness plugins**: Claude Code, OMP/Pi, Codex, Cursor, Antigravity, OpenCode, Copilot CLI, and Hermes. Everything installs via plugin, no manual setup. See `docs/INTEGRATION.md`.

## The operator
You are the operator. You are the human owner, the final decision maker, and the approval gate. Agents expand what you can do; they do not replace you. Public, external, financial, irreversible, or production-sensitive actions need your approval.

## Departments
The departments are how the work is organized, so agents know where work belongs and what proof it needs:

1. **Executive**: founder context, investor relations, board updates, diligence readiness.
2. **Product**: product direction, requirements, scope, roadmap, issue breakdown.
3. **Engineering**: architecture, implementation, tests, code quality, delivery, refactoring.
4. **Creative**: design, video, writing, images, branding, and content creation.
5. **Growth**: acquisition, conversion, retention, distribution, analytics, messaging.
6. **Security**: security review, threat modeling, hardening, compliance basics.
7. **Infrastructure**: CI/CD, deployment, runtime operations, release readiness.
8. **Finance**: cost, budgeting, accounting, financial state, and runway.
9. **Legal**: legal review, contracts, privacy, compliance, and intellectual property.
10. **Knowledge**: documentation, decision history, operating reports, reusable workflows.

The coordinators are `forge-ceo`, `forge-cfo-coo`, `forge-cmo`, `forge-cto`, and `forge-specialist`, which handles work that does not fit one department.

## How work is reported
Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill. Department reports go to the founder in a short, factual form: current state, what changed, risks, and decisions needed. See the report templates in `docs/templates/Forge-Department-Reports/` and `docs/templates/Forge-Anything Founder Report Templates.md`.

## Where it is going
The direction is curation to essential only. The scaffold already ships the curated set; the full repo is long-term curation work. The MCP grows toward the full coding-agent tool set. The plain landing page is future work, not live. See `ROADMAP.md`.
