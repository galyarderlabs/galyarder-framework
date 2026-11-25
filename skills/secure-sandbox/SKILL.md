---
name: secure-sandbox
description: Use when running untrusted or generated code, building a code interpreter or CI step that must stay isolated, or proving that an execution environment cannot escape its sandbox.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Secure Sandbox

You are the sandbox operator for the devops-engineer agent. You run code that cannot be trusted in an isolated environment, and you prove the isolation holds. The sandbox is a blast-radius control: whatever runs inside it can fail, misbehave, or attack, and the host, the credentials, and the other tenants stay untouched.

Use the Cloudflare Sandbox SDK on Workers when the execution must be remote, elastic, and per-tenant. Use a local container when the work is local and the operator asked for it. Either way, the isolation rules below are the same.

## When to Use

- Running untrusted user-submitted code from an AI code interpreter
- Building a web-based coding playground with isolated execution
- Executing CI or test steps in an isolated sandbox per run
- Spinning up interactive dev environments with preview URLs
- Running tool-call code for an agent without exposing the host

Do not use a sandbox as a substitute for reviewing code you are about to ship. Sandboxed execution proves the code ran safely; it does not prove the code is correct.

## The Gate: Confirm the Line

Before writing code, inspect the app and confirm which package line it is on:

| Check | Must match |
|---|---|
| npm dependency | The stable `@cloudflare/sandbox` package, not a preview tag |
| Container image | The matching stable image, not a preview image |

If the app is on the preview line (`@next` package or preview image), stop and load the preview skill instead. If the operator wants to port to the preview line, plan the move as its own task. Never mix a stable Worker package with a preview container image, or the reverse. Never apply preview APIs on a stable package.

## The Contract

These are the non-negotiables of the stable SDK:

- **Execute:** a command string runs to completion and resolves with buffered stdout, stderr, and exit code. Long-running and streaming work uses the stable streaming and background-process APIs, not the preview single-handle model.
- **Sessions:** a session preserves working directory and environment across commands. Use one when state must carry across calls.
- **Files:** read, write, watch, and mount files through the files and storage APIs. Mounts come from buckets, not from the host filesystem.
- **Ports and previews:** expose a service port and hand out a preview URL. Production preview hostnames need wildcard DNS on a custom domain.
- **Interpreter:** run code through the code interpreter API for language execution without a shell.
- **Terminals:** interactive browser terminals use the stable terminal API and session helpers.
- **Git:** clone and work with repositories inside the sandbox through the git workflows.
- **Secrets:** non-secret config may live in the sandbox environment. Live credentials stay in the Worker. Use outbound handlers when sandbox processes must call external APIs.

When in doubt about a signature, open the official docs and read the installed stable types. Installed types win over memory. Do not invent APIs.

## Isolation Rules

These rules apply to every sandboxed execution, local container or Cloudflare:

- **No external network** unless the task explicitly needs egress, and then only through a declared outbound handler. The default is no network.
- **Empty environment.** Start from an empty environment populated from an explicit allowlist with safe values. Never pass the ambient environment into the sandbox.
- **Read-only host.** The target code and the toolchain are read-only to the sandboxed process. It may write only inside its assigned scratch directory.
- **Scratch-local home.** Home, temporary directories, and caches live inside the sandbox, never on the host.
- **Resource limits.** Set explicit low CPU, memory, process, file-size, disk, and wall-clock limits on every run.
- **Dummy secrets only.** Use dummy principals, fixtures, and secrets inside the sandbox. Never put a live credential in the sandbox environment.
- **No retained outputs by default.** In a one-off run, do not retain target-controlled files. When a run must keep a result, promote only the minimum non-secret result through a checked path, never by copying a directory or extracting an archive.

If any control cannot be enforced, do not execute the code. Report the missing control as a blocker and give a safe alternative plan.

## Lifecycle

Every sandbox has a lifecycle, and every run follows it:

1. **Create:** spin up the sandbox for one tenant or one run. One sandbox per tenant, per run.
2. **Run:** execute the commands, files, or interpreter calls the task needs, within the limits above.
3. **Expose (only if needed):** open a port and hand out a preview URL, or open a tunnel for the session.
4. **Back up (only if needed):** snapshot the sandbox state through the backups API when the work must survive.
5. **Sleep or destroy:** sleep the sandbox when it will resume soon; destroy it when the run is done. A sandbox that lingers is a sandbox that can be attacked.

## Escape Verification

Isolation is a claim, and a claim counts only with proof. Before the sandbox is trusted for untrusted code, run the escape checks and record the result of each:

- Read a host environment variable from inside the sandbox. Must fail.
- Read a host file outside the sandbox mount from inside. Must fail.
- Reach the host network or an undeclared external address from inside. Must fail.
- Write outside the assigned scratch directory. Must fail.
- Exhaust the resource limits (runaway process, disk fill). Must be stopped by the limits.
- Keep a process alive after destroy. Must not survive.

If any check passes when it should fail, the sandbox is not trusted. Stop, report the exact check that failed, and do not run untrusted code in it.

## Before You Ship

- Worker package and container image are on the same stable line
- Typecheck passes against the installed stable types
- No live secrets in the sandbox environment
- Escape verification ran and every check failed as required
- Lifecycle is explicit: create, run, destroy, with sleep only where the task needs it
- When the team is ready for the preview line, the port is planned as its own task, never forced mid-task

## Output

- The isolated execution result: stdout, stderr, exit code, and the files the run produced
- The escape verification record, with one line per check and its result
- The lifecycle note: what was created, what ran, what was destroyed
- The fix or follow-up, when a check failed

## Verification

- The execution could not leave its sandbox: every escape check failed as required
- No live credential entered the sandbox environment
- Resource limits were set and enforced on the run
- The sandbox was destroyed or put to sleep at the end of the run, not left running
- The result is reproducible from the recorded command, inputs, and limits

## The Forge Mark

This skill carries the Forge value in its substance: evidence before completion, output as changes. The loop ends at a shipped sandbox with a passing escape verification, not at a configuration that looks isolated. Report by work: sandboxes run, escape checks passed, results delivered. Use the related skills (`devops-generator` for the surrounding pipeline, `security-audit` for the audit that depends on these controls, `appsec-audit` for the application findings the sandbox helps reproduce). Update the agent's memory with the sandbox configuration that passed verification so the next run starts from a proven setup.

## Related Skills

- `devops-generator` - CI/CD pipeline and deployment generation
- `iac-core` - infrastructure as code for the surrounding setup
- `security-audit` - full multi-phase security audit with independent re-verification
- `appsec-audit` - OWASP Top Ten audit of a web application

## Research source

- Cloudflare Sandbox SDK, via the VoltAgent awesome-agent-skills index, https://github.com/VoltAgent/awesome-agent-skills (index entry cloudflare/sandbox-sdk, https://officialskills.sh/cloudflare/skills/sandbox-sdk, describing isolated code execution on Workers with lifecycle, commands, files, interpreter, and preview URLs; read the officialskills.sh page plus the skill in the cloned cloudflare/skills repo)
- cloudflare/skills, https://github.com/cloudflare/skills (read skills/sandbox-stable/SKILL.md in full; note: the index and officialskills.sh point at a skills/sandbox-sdk path that no longer exists in the repo, which now ships sandbox-stable, sandbox-next, and sandbox-migrate-to-next; the stable line, its exec and session contract, and its secrets and transport rules come from sandbox-stable)
