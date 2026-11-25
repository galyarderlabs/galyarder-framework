# Automation Builders (research notes)

Attribution: czlonkowski/n8n-skills (https://github.com/czlonkowski/n8n-skills) for n8n, and davila7/claude-code-templates, zapier-workflows skill (https://github.com/davila7/claude-code-templates/blob/main/cli-tool/components/skills/development/zapier-workflows/SKILL.md) for Zapier. The Forge draft restates both in its own words and adds the Forge rules: four gates before activation, a why-note on every Code or HTTP node, and a runbook as the shipped output.

## n8n: the pack structure

The czlonkowski pack is a router plus specialist skills: using-n8n-mcp-skills (router), n8n-mcp-tools-expert, n8n-workflow-patterns, n8n-node-configuration, n8n-expression-syntax, n8n-validation-expert, n8n-code-javascript, n8n-code-python, n8n-code-tool, n8n-error-handling, n8n-binary-and-data, n8n-subworkflows, n8n-agents, n8n-multi-instance, n8n-self-hosting. The router's three non-negotiables: invoke the relevant skill before any n8n action; validate AND verify before activating; secrets never go in text fields.

## n8n: the six core patterns

Webhook processing (most common), HTTP API integration, database operations, AI agent workflow, scheduled tasks, batch processing. Common triggers in the source's statistics: webhook 35 percent, schedule 28 percent, manual 22 percent, service triggers 15 percent. Average workflow complexity: simple (3 to 5 nodes) 42 percent, medium (6 to 10) 38 percent, complex (11+) 20 percent.

## n8n: traps the source names

- Node-type form trap: get_node and validate_node take SHORT form (nodes-base.set); workflow JSON takes LONG form (n8n-nodes-base.set). Mixing them is a common silent mistake.
- A Filter with a broken condition drops every item and still shows success, because JS errors inside {{ }} resolve silently to null.
- Merge defaults to 2 inputs; a third source silently drops unless numberInputs is set.
- SplitInBatches outputs: main[0] is done (fires once), main[1] is each batch. Always add a Limit 1 node after the done output.
- After a loop, $('Node Inside Loop').all() returns only the last batch's items; accumulate across iterations with $getWorkflowStaticData('global').
- Dry-run tolerance: when API write nodes are disabled for a dry run, downstream verification nodes receive the request body instead of the response, so verification must detect that shape.

## Zapier: the two types

- MCP tools: 8,000+ individual Zapier actions via the Zapier MCP server (https://mcp.zapier.com/mcp/servers). Flexible, on-the-fly, but no memory of which tools the operator uses or why.
- Multi-step Zaps: complex workflows built in the Zapier dashboard, triggered by POST to a webhook URL (Webhooks by Zapier, Catch Hook). Deterministic and pre-optimized, but not visible to the MCP.

The source skill's fix is persistent memory: remember tool preferences ("use Google Sheets for expenses, Notion for tasks"), know when and why to use each tool, trigger multi-step Zaps by name, and self-learn by updating its own reference files (zaps.md, mcp-patterns.md) when the operator teaches it something.

## Zapier: security warning in the source

Webhook URLs contain authentication tokens. The source warns: install globally, never commit skill files with real webhook URLs to public repos, regenerate webhook URLs if exposed, use Zapier's webhook authentication features when available.

## What the Forge draft takes from this

The n8n discipline (router first, native node first, validate and verify, four gates) and the Zapier two-type split with persistent tool memory. The draft does not copy either skill's text. It adds the Forge rules: no live workflow without gates, no side effect in a test without approval or safe data, and a runbook as the shipped output.
