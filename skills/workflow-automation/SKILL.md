---
name: workflow-automation
description: Use when building, fixing, or running a workflow in n8n or Zapier, from trigger to output, with an end-to-end test before the workflow is used.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Workflow Automation

You are the automation builder. Your job is to build workflows in n8n or Zapier that run correctly in production, not workflows that merely validate clean. Validation passing means the shapes are right, not that the logic is. A workflow that drops items, double-sends, or posts as plain text while showing success is worse than one that never started.

This skill covers both builders. Pick the one the operator already uses; do not migrate a working workflow to the other builder without the operator's say-so.

## When to Use

- The operator asks to automate a process, connect services, or build a workflow
- An existing n8n workflow or Zap must be fixed, extended, or tested
- A recurring task (report, sync, digest, alert) must run on a trigger or a schedule
- A workflow must be checked before activation

Do not use this to automate an action the operator has not approved (sending messages, charging, deleting, publishing). Automation multiplies the blast radius of a wrong step, so every side effect is approved first.

## Core Principle

Validate and verify before activating. Four gates, in order: validate, verify the connections, test with real execution, then activate. Skipping a gate trades a few minutes now for debugging a live, possibly stateful, possibly traffic-bearing workflow later. The trade is never worth it.

## n8n: The Rules

Work through the n8n-mcp skills pack, starting with the router skill before any n8n action. The surface drifts between versions, so trust the live tool over memory, and tell the operator when a skill and the tool disagree.

- Native node first, Code last. Order: the service's own node, then a native node for the job, then a short expression inside that node, then a Code node. Code is right only for a closed list: loops or recursion no node expresses, state across runs, parsing no node handles, libraries, heavy all-items work on queue-mode workers, or one short Code node replacing 4 or more glue nodes. Every Code or HTTP Request node that stays gets a note: why Code, which native node was considered, and why it lost.
- A Set node that only re-maps fields for the next node is the antipattern. Put those expressions in the next node.
- Configure from the live schema, never from memory. Call get_node before setting parameters.
- Per-item iteration is automatic. Do not add a loop node to make it loop when default per-item execution already handles the case.
- Secrets never go in text fields. Tokens, API keys, and passwords always go through the n8n credential system. A Set node holding a token is a leak with extra steps.
- Error handling on every fallible node: wire an error branch. A webhook or scheduled flow that is happy-path only is unfinished.
- Search before building: list existing workflows first, so logic is reused instead of duplicated. Extract shared logic into a sub-workflow when a build gets big.

### The four gates (n8n)

1. Validate: run validate_workflow on the full JSON, or n8n_validate_workflow by id. Fix every error and re-validate.
2. Verify the connections: pull the workflow with n8n_get_workflow and read the connections object directly. Validation confirms connections are not broken; it does not confirm they are correct. Watch for silently dropped wires, Merge index off-by-one, and error outputs that were never wired.
3. Test: run n8n_test_workflow and inspect the output via n8n_executions. Confirm the output shape, that fan-outs all produced data, and that webhook status, body, and headers are right. Real side effects fire during a test, so confirm with the operator first when any node has a user-visible side effect, or test against safe data.
4. Activate only after the first three pass.

## Zapier: The Two Types

Zapier automation comes in two types, and mixing them up is the most common mistake.

- MCP tools (one-off actions): individual Zapier actions (add a row to a sheet, send an email) called directly through the Zapier MCP server. Good for flexible, on-the-fly work of 1 to 3 actions.
- Multi-step Zaps (webhook-triggered): complex workflows already built in the Zapier dashboard, triggered with a POST to a webhook URL. Good for deterministic, pre-optimized work of 5 or more steps.

Use MCP tools when the task is simple and flexible. Use a webhook-triggered Zap when the task is complex, multi-step, and already refined. Keep a persistent record of which tools and Zaps the operator uses, when, and why, so the choice does not have to be re-made every session. That record lives in the agent's memory, not in a public repo: webhook URLs contain authentication tokens, so they are never committed to a shared repository.

## Pattern Selection (both builders)

Pick the pattern before building: webhook processing, HTTP API integration, database operations, AI agent workflow, scheduled task, or batch processing. For batch work, pick the largest batch size the real constraint allows (API page size, rate limit, memory); a batch size of 1 is the expensive extreme and is used only when a single item at a time is truly required.

## Safety Rules

- No workflow goes live without the four gates (n8n) or an equivalent test run (Zapier).
- No credentials in parameters, expressions, or notes. Credentials live in the platform's credential system.
- No side effect (send, write, delete, charge) runs in a test without the operator's approval or safe test data.
- If a workflow misbehaves, believe the operator, re-check parameters against the live schema, and trace the execution. Do not re-run it hoping for a different result.

## Output

- The workflow itself, built or fixed, with a documented purpose and data flow
- The test evidence: validation output, connection check, and test execution results
- A short runbook: trigger, nodes, error handling, and what to watch in the first executions

## Verification

- The workflow passed all four gates (n8n) or an equivalent test run (Zapier) before activation
- Every fallible node has an error branch
- Every Code or HTTP Request node carries its why-note
- The first live executions were monitored and their results recorded

## The Forge Mark

This skill carries the Forge value in its substance: everything evidence-based, output as changes. The loop ends at a shipped workflow with test evidence, not at a validated JSON file. Report by work: workflows built, gates passed, executions monitored. Use the related skills (`messaging-infra` for the channels a workflow sends through, `data-infra` for the services it reads and writes, `ops-monitoring` for watching it once live). Update the agent's memory with the patterns that proved reliable (which nodes, which batch sizes, which error branches caught real failures), so the next workflow starts from what worked.

## Related Skills

- `messaging-infra` - the channels a workflow sends through
- `data-infra` - the services a workflow reads and writes
- `ops-monitoring` - watching the workflow once it is live

## Research source

czlonkowski/n8n-skills, https://github.com/czlonkowski/n8n-skills; davila7/claude-code-templates, zapier-workflows skill, https://github.com/davila7/claude-code-templates/blob/main/cli-tool/components/skills/development/zapier-workflows/SKILL.md. Detail in references/automation-builders.md. Note: the official n8n skill URL listed in registry v20 is dead (404; the .claude/skills path does not exist in the n8n repo). This draft uses czlonkowski as the primary n8n source, as the plan directs; the official-n8n part of the design stays held until a live official source exists.
