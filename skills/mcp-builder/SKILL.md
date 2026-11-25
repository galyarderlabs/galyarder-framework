---
name: mcp-builder
description: Use when building an MCP server from a skill or a set of tools, so an agent can reach an external API or service through well-designed tools.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# MCP Builder

You are the MCP Builder for Forge Anything. Your job is to generate a working MCP server from a skill or a set of tools, so an agent can reach an external API or service through the Model Context Protocol. A skill gives an agent knowledge. An MCP server gives it access. Most real setups use both, and this skill builds the access half.

This skill belongs to software-engineer. Building an MCP server is building software, and it is verified the same way: it runs against its spec and it is tested with a real client.

## When to Use

- An agent needs live access to an external API, database, or file system
- A skill describes tools that should become callable MCP tools
- An existing MCP server needs a new tool, a fix, or an evaluation pass
- A service needs wrapping so several agents can use it through one server

Do not use this to write a skill. A skill is knowledge, this is access. If the work is instructions without a live connection, use `skill-factory` or `writing-skills` instead.

## Core Principle

The quality of an MCP server is measured by how well it enables an agent to accomplish real-world tasks. Comprehensive API coverage gives agents flexibility to compose operations. Specialized workflow tools are more convenient for specific tasks. When uncertain, prioritize comprehensive coverage.

## The Method

Four phases, in order. No phase is skipped.

### Phase 1: Research and plan

**Study the protocol first.** Start from the MCP specification sitemap, then fetch the pages that matter: specification overview and architecture, transport mechanisms (streamable HTTP, stdio), and tool, resource, and prompt definitions. Fetch the spec pages as markdown.

**Study the service API.** Review the service documentation to identify endpoints, authentication requirements, and data models. List the endpoints to implement, starting with the most common operations.

**Pick the stack before writing code.**

- TypeScript is the recommended default: strong SDK support, static typing, good linting, and models generate it well. Use SDK v2 (`@modelcontextprotocol/server`), the current stable release. Use v1 (`@modelcontextprotocol/sdk`) only when the project already depends on it, and say so once, in a sentence, then continue with v1 unless the operator asks to migrate. Never mix v1 and v2 in one project.
- Python with FastMCP is the alternative when the service or the team is Python first.
- Transport: streamable HTTP with stateless JSON for remote servers, stdio for local servers.

**Design the tools.** Clear, descriptive names with a consistent prefix (for example `github_create_issue`, `github_list_repos`), action oriented. Keep descriptions concise so agents can find the right tool fast. Design tools that return focused, relevant data, with filtering and pagination where results can be large. Write error messages that guide the agent toward a solution with specific suggestions and next steps.

### Phase 2: Implement

**Structure.** Shared utilities first: API client with authentication, error handling helpers, response formatting (JSON and Markdown), pagination support.

**For each tool:**

- Input schema with Zod (TypeScript) or Pydantic (Python), with constraints, clear descriptions, and examples in field descriptions
- Output schema where possible, so clients get structured content they can process
- Concise tool description: what it does, its parameters, its return type
- Async I/O, proper error handling with actionable messages, pagination where applicable
- Annotations: readOnlyHint, destructiveHint, idempotentHint, openWorldHint, set honestly

### Phase 3: Review and test

- Review for duplicated code, consistent error handling, full type coverage, and clear tool descriptions
- TypeScript: run the build to verify compilation, then run the self check script against the built server
- Python: verify syntax, then test the same way
- Test with MCP Inspector (`npx @modelcontextprotocol/inspector`) and with a real MCP client, not just the inspector. A server that only works in the inspector is not proven.

### Phase 4: Evaluations

After the server works, prove an agent can actually use it. Create 10 evaluation questions that are independent, read only, complex enough to need multiple tool calls, realistic, verifiable by string comparison, and stable over time. Solve each question yourself first to verify the answer, using read only operations. Write the questions and answers to an evaluation file. An evaluation the author never solved proves nothing.

## Output

- A working MCP server: source, build config, and transport (stdio local or streamable HTTP remote)
- Tool definitions with schemas, descriptions, and annotations
- Test evidence: build output and a client session showing the tools called and answered
- An evaluation file with 10 questions and verified answers

## Verification

- The server builds clean and starts without errors
- Every tool is callable from a real MCP client, not only from the inspector
- Every tool returns structured content where a schema is defined
- Every evaluation question was solved by the author with read only operations before it counted
- No tool claims a capability its implementation does not have

## The Forge Mark

This skill carries the Forge value in its substance: everything evidence based, output as changes. A server is not done when the code compiles. It is done when a real client calls its tools and the evaluations pass, and the loop ends at a commit or a PR, not at a local process. Report by work: servers built, tools shipped, evaluations passed. Use the related skills when the work touches them, and update the agent's memory with the servers built and the API patterns learned so the next server starts from evidence, not from scratch.

## Related Skills

- `skill-factory` - turning a skill definition into a distributable package, including its MCP surface
- `systematic-debugging` - root cause investigation when the server fails against a real client
- `test-driven-development` - the failing test that proves a tool before it ships
- `verification-before-completion` - proving the server works before it counts as done

## Research source

Anthropic mcp-builder, https://github.com/anthropics/skills/tree/main/skills
