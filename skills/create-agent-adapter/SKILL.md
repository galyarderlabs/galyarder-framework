---
name: create-agent-adapter
description: >
  Technical guide for creating a new Forge Anything agent adapter. Use when building
  a new adapter package, adding support for a new AI coding tool (e.g. a new
  CLI agent, API-based agent, or custom process), or when modifying the adapter
  system. Covers the required interfaces, module structure, registration points,
  and conventions derived from the existing claude-local and codex-local adapters.
---
## Forge Anything operating protocols


- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

## 1. Architecture Overview


```
packages/adapters/<name>/
  src/
    index.ts            # Shared metadata (type, label, models, agentConfigurationDoc)
    server/
      index.ts          # Server exports: execute, sessionCodec, parse helpers
      execute.ts        # Core execution logic (AdapterExecutionContext -> AdapterExecutionResult)
      parse.ts          # Stdout/result parsing for the agent's output format
    ui/
      index.ts          # UI exports: parseStdoutLine, buildConfig
      parse-stdout.ts   # Line-by-line stdout -> TranscriptEntry[] for the run viewer
      build-config.ts   # CreateConfigValues -> adapterConfig JSON for agent creation form
    cli/
      index.ts          # CLI exports: formatStdoutEvent
      format-event.ts   # Colored terminal output for `forge run --watch`
  package.json
  tsconfig.json
```

Three separate registries consume adapter modules:

| Registry | Location | Interface |
|----------|----------|-----------|
| Server | `server/src/adapters/registry.ts` | `ServerAdapterModule` |
| UI | `ui/src/adapters/registry.ts` | `UIAdapterModule` |
| CLI | `cli/src/adapters/registry.ts` | `CLIAdapterModule` |

---

## 2. Shared Types (`@forge-anything/adapter-utils`)

See `references/shared-types.md` for the full shared type definitions.

---

## 2.1 Adapter Environment Test Contract

See `references/environment-test-contract.md` for the environment test contract.

---

## 3. Step-by-Step: Creating a New Adapter


### 3.1 Create the Package

```
packages/adapters/<name>/
  package.json
  tsconfig.json
  src/
    index.ts
    server/index.ts
    server/execute.ts
    server/parse.ts
    ui/index.ts
    ui/parse-stdout.ts
    ui/build-config.ts
    cli/index.ts
    cli/format-event.ts
```

**package.json**  must use the four-export convention:

```json
{
  "name": "@forge-anything/adapter-<name>",
  "version": "0.0.1",
  "private": true,
  "type": "module",
  "exports": {
    ".": "./src/index.ts",
    "./server": "./src/server/index.ts",
    "./ui": "./src/ui/index.ts",
    "./cli": "./src/cli/index.ts"
  },
  "dependencies": {
    "@forge-anything/adapter-utils": "workspace:*",
    "picocolors": "^1.1.1"
  },
  "devDependencies": {
    "typescript": "^5.7.3"
  }
}
```

### 3.2 Root `index.ts`  Adapter Metadata

This file is imported by **all three** consumers (server, UI, CLI). Keep it dependency-free (no Node APIs, no React).

```ts
export const type = "my_agent";        // snake_case, globally unique
export const label = "My Agent (local)";

export const models = [
  { id: "model-a", label: "Model A" },
  { id: "model-b", label: "Model B" },
];

export const agentConfigurationDoc = `# my_agent agent configuration
...document all config fields here...
`;
```

**Required exports:**
- `type`  the adapter type key, stored in `agents.adapter_type`
- `label`  human-readable name for the UI
- `models`  available model options for the agent creation form
- `agentConfigurationDoc`  markdown describing all `adapterConfig` fields (used by LLM agents configuring other agents)

**Writing `agentConfigurationDoc` as routing logic:**

The `agentConfigurationDoc` is read by LLM agents (including Forge Anything agents that create other agents). Write it as **routing logic**, not marketing copy. Include concrete "use when" and "don't use when" guidance so an LLM can decide whether this adapter is appropriate for a given task.

```ts
export const agentConfigurationDoc = `# my_agent agent configuration

Adapter: my_agent

Use when:
- The agent needs to run MyAgent CLI locally on the host machine
- You need session persistence across runs (MyAgent supports thread resumption)
- The task requires MyAgent-specific tools (e.g. web search, code execution)

Don't use when:
- You need a simple one-shot script execution (use the "process" adapter instead)
- The agent doesn't need conversational context between runs (process adapter is simpler)
- MyAgent CLI is not installed on the host

Core fields:
- cwd (string, required): absolute working directory for the agent process
...
`;
```

Adding explicit negative cases improves adapter selection accuracy. One concrete anti-pattern is worth more than three paragraphs of description.

### 3.3 Server Module

#### `server/execute.ts`  The Core

This is the most important file. It receives an `AdapterExecutionContext` and must return an `AdapterExecutionResult`.

**Required behavior:**

1. **Read config**  extract typed values from `ctx.config` using helpers (`asString`, `asNumber`, `asBoolean`, `asStringArray`, `parseObject` from `@forge-anything/adapter-utils/server-utils`)
2. **Build environment**  call `buildForgeEnv(agent)` then layer in `FORGE_RUN_ID`, context vars (`FORGE_TASK_ID`, `FORGE_WAKE_REASON`, `FORGE_WAKE_COMMENT_ID`, `FORGE_APPROVAL_ID`, `FORGE_APPROVAL_STATUS`, `FORGE_LINKED_ISSUE_IDS`), user env overrides, and auth token
3. **Resolve session**  check `runtime.sessionParams` / `runtime.sessionId` for an existing session; validate it's compatible (e.g. same cwd); decide whether to resume or start fresh
4. **Render prompt**  use `renderTemplate(template, data)` with the template variables: `agentId`, `companyId`, `runId`, `company`, `agent`, `run`, `context`
5. **Call onMeta**  emit adapter invocation metadata before spawning the process
6. **Spawn the process**  use `runChildProcess()` for CLI-based agents or `fetch()` for HTTP-based agents
7. **Parse output**  convert the agent's stdout into structured data (session id, usage, summary, errors)
8. **Handle session errors**  if resume fails with "unknown session", retry with a fresh session and set `clearSession: true`
9. **Return AdapterExecutionResult**  populate all fields the agent runtime supports

**Environment variables the server always injects:**

| Variable | Source |
|----------|--------|
| `FORGE_AGENT_ID` | `agent.id` |
| `FORGE_COMPANY_ID` | `agent.companyId` |
| `FORGE_API_URL` | Server's own URL |
| `FORGE_RUN_ID` | Current run id |
| `FORGE_TASK_ID` | `context.taskId` or `context.issueId` |
| `FORGE_WAKE_REASON` | `context.wakeReason` |
| `FORGE_WAKE_COMMENT_ID` | `context.wakeCommentId` or `context.commentId` |
| `FORGE_APPROVAL_ID` | `context.approvalId` |
| `FORGE_APPROVAL_STATUS` | `context.approvalStatus` |
| `FORGE_LINKED_ISSUE_IDS` | `context.issueIds` (comma-separated) |
| `FORGE_API_KEY` | `authToken` (if no explicit key in config) |

#### `server/parse.ts`  Output Parser

Parse the agent's stdout format into structured data. Must handle:

- **Session identification**  extract session/thread ID from init events
- **Usage tracking**  extract token counts (input, output, cached)
- **Cost tracking**  extract cost if available
- **Summary extraction**  pull the agent's final text response
- **Error detection**  identify error states, extract error messages
- **Unknown session detection**  export an `is<Agent>UnknownSessionError()` function for retry logic

**Treat agent output as untrusted.** The stdout you're parsing comes from an LLM-driven process that may have executed arbitrary tool calls, fetched external content, or been influenced by prompt injection in the files it read. Parse defensively:
- Never `eval()` or dynamically execute anything from output
- Use safe extraction helpers (`asString`, `asNumber`, `parseJson`)  they return fallbacks on unexpected types
- Validate session IDs and other structured data before passing them through
- If output contains URLs, file paths, or commands, do not act on them in the adapter  just record them

#### `server/index.ts`  Server Exports

```ts
export { execute } from "./execute.js";
export { testEnvironment } from "./test.js";
export { parseMyAgentOutput, isMyAgentUnknownSessionError } from "./parse.js";

// Session codec  required for session persistence
export const sessionCodec: AdapterSessionCodec = {
  deserialize(raw) { /* raw DB JSON -> typed params or null */ },
  serialize(params) { /* typed params -> JSON for DB storage */ },
  getDisplayId(params) { /* -> human-readable session id string */ },
};
```

#### `server/test.ts`  Environment Diagnostics

Implement adapter-specific preflight checks used by the UI test button.

Minimum expectations:

1. Validate required config primitives (paths, commands, URLs, auth assumptions)
2. Return check objects with deterministic `code` values
3. Map severity consistently (`info` / `warn` / `error`)
4. Compute final status:
   - `fail` if any `error`
   - `warn` if no errors and at least one warning
   - `pass` otherwise

This operation should be lightweight and side-effect free.

### 3.4 UI Module

#### `ui/parse-stdout.ts`  Transcript Parser

Converts individual stdout lines into `TranscriptEntry[]` for the run detail viewer. Must handle the agent's streaming output format and produce entries of these kinds:

- `init`  model/session initialization
- `assistant`  agent text responses
- `thinking`  agent thinking/reasoning (if supported)
- `tool_call`  tool invocations with name and input
- `tool_result`  tool results with content and error flag
- `user`  user messages in the conversation
- `result`  final result with usage stats
- `stdout`  fallback for unparseable lines

```ts
export function parseMyAgentStdoutLine(line: string, ts: string): TranscriptEntry[] {
  // Parse JSON line, map to appropriate TranscriptEntry kind(s)
  // Return [{ kind: "stdout", ts, text: line }] as fallback
}
```

#### `ui/build-config.ts`  Config Builder

Converts the UI form's `CreateConfigValues` into the `adapterConfig` JSON blob stored on the agent.

```ts
export function buildMyAgentConfig(v: CreateConfigValues): Record<string, unknown> {
  const ac: Record<string, unknown> = {};
  if (v.cwd) ac.cwd = v.cwd;
  if (v.promptTemplate) ac.promptTemplate = v.promptTemplate;
  if (v.model) ac.model = v.model;
  ac.timeoutSec = 0;
  ac.graceSec = 15;
  // ... adapter-specific fields
  return ac;
}
```

#### UI Config Fields Component

Create `ui/src/adapters/<name>/config-fields.tsx` with a React component implementing `AdapterConfigFieldsProps`. This renders adapter-specific form fields in the agent creation/edit form.

Use the shared primitives from `ui/src/components/agent-config-primitives`:
- `Field`  labeled form field wrapper
- `ToggleField`  boolean toggle with label and hint
- `DraftInput`  text input with draft/commit behavior
- `DraftNumberInput`  number input with draft/commit behavior
- `help`  standard hint text for common fields

The component must support both `create` mode (using `values`/`set`) and `edit` mode (using `config`/`eff`/`mark`).

### 3.5 CLI Module

#### `cli/format-event.ts`  Terminal Formatter

Pretty-prints stdout lines for `forge run --watch`. Use `picocolors` for coloring.

```ts
import pc from "picocolors";

export function printMyAgentStreamEvent(raw: string, debug: boolean): void {
  // Parse JSON line from agent stdout
  // Print colored output: blue for system, green for assistant, yellow for tools
  // In debug mode, print unrecognized lines in gray
}
```

---

## 4. Registration Checklist


After creating the adapter package, register it in all three consumers:

### 4.1 Server Registry (`server/src/adapters/registry.ts`)

```ts
import { execute as myExecute, sessionCodec as mySessionCodec } from "@forge-anything/adapter-my-agent/server";
import { agentConfigurationDoc as myDoc, models as myModels } from "@forge-anything/adapter-my-agent";

const myAgentAdapter: ServerAdapterModule = {
  type: "my_agent",
  execute: myExecute,
  sessionCodec: mySessionCodec,
  models: myModels,
  supportsLocalAgentJwt: true,  // true if agent can use Forge Anything API
  agentConfigurationDoc: myDoc,
};

// Add to the adaptersByType map
const adaptersByType = new Map<string, ServerAdapterModule>(
  [..., myAgentAdapter].map((a) => [a.type, a]),
);
```

### 4.2 UI Registry (`ui/src/adapters/registry.ts`)

```ts
import { myAgentUIAdapter } from "./my-agent";

const adaptersByType = new Map<string, UIAdapterModule>(
  [..., myAgentUIAdapter].map((a) => [a.type, a]),
);
```

With `ui/src/adapters/my-agent/index.ts`:

```ts
import type { UIAdapterModule } from "../types";
import { parseMyAgentStdoutLine } from "@forge-anything/adapter-my-agent/ui";
import { MyAgentConfigFields } from "./config-fields";
import { buildMyAgentConfig } from "@forge-anything/adapter-my-agent/ui";

export const myAgentUIAdapter: UIAdapterModule = {
  type: "my_agent",
  label: "My Agent",
  parseStdoutLine: parseMyAgentStdoutLine,
  ConfigFields: MyAgentConfigFields,
  buildAdapterConfig: buildMyAgentConfig,
};
```

### 4.3 CLI Registry (`cli/src/adapters/registry.ts`)

```ts
import { printMyAgentStreamEvent } from "@forge-anything/adapter-my-agent/cli";

const myAgentCLIAdapter: CLIAdapterModule = {
  type: "my_agent",
  formatStdoutEvent: printMyAgentStreamEvent,
};

// Add to the adaptersByType map
```

---

## 5. Session Management  Designing for Long Runs

See `references/session-management.md` for session design for long runs.

---

## 6. Server-Utils Helpers


Import from `@forge-anything/adapter-utils/server-utils`:

| Helper | Purpose |
|--------|---------|
| `asString(val, fallback)` | Safe string extraction |
| `asNumber(val, fallback)` | Safe number extraction |
| `asBoolean(val, fallback)` | Safe boolean extraction |
| `asStringArray(val)` | Safe string array extraction |
| `parseObject(val)` | Safe `Record<string, unknown>` extraction |
| `parseJson(str)` | Safe JSON.parse returning `Record` or null |
| `renderTemplate(tmpl, data)` | `{{path.to.value}}` template rendering |
| `buildForgeEnv(agent)` | Standard `FORGE_*` env vars |
| `redactEnvForLogs(env)` | Redact sensitive keys for onMeta |
| `ensureAbsoluteDirectory(cwd)` | Validate cwd exists and is absolute |
| `ensureCommandResolvable(cmd, cwd, env)` | Validate command is in PATH |
| `ensurePathInEnv(env)` | Ensure PATH exists in env |
| `runChildProcess(runId, cmd, args, opts)` | Spawn with timeout, logging, capture |

---

## 7. Conventions and Patterns

See `references/conventions-and-patterns.md` for naming, config, prompt, error-handling, logging, and skills-injection conventions.

---

## 8. Security Considerations

See `references/security-considerations.md` for security considerations for the adapter boundary.

---

## 9. TranscriptEntry Kinds Reference


The UI run viewer displays these entry kinds:

| Kind | Fields | Usage |
|------|--------|-------|
| `init` | `model`, `sessionId` | Agent initialization |
| `assistant` | `text` | Agent text response |
| `thinking` | `text` | Agent reasoning/thinking |
| `user` | `text` | User message |
| `tool_call` | `name`, `input` | Tool invocation |
| `tool_result` | `toolUseId`, `content`, `isError` | Tool result |
| `result` | `text`, `inputTokens`, `outputTokens`, `cachedTokens`, `costUsd`, `subtype`, `isError`, `errors` | Final result with usage |
| `stderr` | `text` | Stderr output |
| `system` | `text` | System messages |
| `stdout` | `text` | Raw stdout fallback |

---

## 10. Testing


Create tests in `server/src/__tests__/<adapter-name>-adapter.test.ts`. Test:

1. **Output parsing**  feed sample stdout through your parser, verify structured output
2. **Unknown session detection**  verify the `is<Agent>UnknownSessionError` function
3. **Config building**  verify `buildConfig` produces correct adapterConfig from form values
4. **Session codec**  verify serialize/deserialize round-trips

---

## 11. Minimal Adapter Checklist


- [ ] `packages/adapters/<name>/package.json` with four exports (`.`, `./server`, `./ui`, `./cli`)
- [ ] Root `index.ts` with `type`, `label`, `models`, `agentConfigurationDoc`
- [ ] `server/execute.ts` implementing `AdapterExecutionContext -> AdapterExecutionResult`
- [ ] `server/test.ts` implementing `AdapterEnvironmentTestContext -> AdapterEnvironmentTestResult`
- [ ] `server/parse.ts` with output parser and unknown-session detector
- [ ] `server/index.ts` exporting `execute`, `testEnvironment`, `sessionCodec`, parse helpers
- [ ] `ui/parse-stdout.ts` with `StdoutLineParser` for the run viewer
- [ ] `ui/build-config.ts` with `CreateConfigValues -> adapterConfig` builder
- [ ] `ui/src/adapters/<name>/config-fields.tsx` React component for agent form
- [ ] `ui/src/adapters/<name>/index.ts` assembling the `UIAdapterModule`
- [ ] `cli/format-event.ts` with terminal formatter
- [ ] `cli/index.ts` exporting the formatter
- [ ] Registered in `server/src/adapters/registry.ts`
- [ ] Registered in `ui/src/adapters/registry.ts`
- [ ] Registered in `cli/src/adapters/registry.ts`
- [ ] Added to workspace in root `pnpm-workspace.yaml` (if not already covered by glob)
- [ ] Tests for parsing, session codec, and config building
