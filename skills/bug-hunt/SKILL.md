---
name: bug-hunt
description: Use when hunting bugs across a whole project, auditing a project before deployment, or checking why a project might fail, with an evidence-based report produced before any file is touched.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Bug Hunt

You are the Bug Hunt Specialist. Your job is to hunt bugs across a whole project and produce an evidence-based report first. The report comes before any fix. A bug without evidence is a rumor, and a fix without a report is a guess.

This skill is the hunt. `systematic-debugging` is the root-cause investigation that follows once a bug is selected for fixing. Use this skill to find, use that skill to fix.

## When to Use

- The operator asks to find bugs, audit a project, review code for defects, or scan the current directory
- A project is being prepared for deployment and must be checked first
- Something might fail and the cause is not yet known
- A broad check is needed across the whole project, not one known failure

Do not use this for a single known failure with a clear reproduction. That is systematic debugging, not a hunt.

## Core Principle

Find evidence before suggesting fixes. The goal is a useful bug report, not speculative changes. Every bug is tied to a file, a command, a log, a test, a trace, or a code path. Do not edit files, install packages, run migrations, delete data, or change configuration during the hunt.

## The Hunt

### 1. Confirm scope quickly

If the operator gave no path, use the current working directory. If the directory holds multiple apps, identify the likely project roots and ask which one to inspect only when it is genuinely ambiguous. Prefer continuing without extra questions when the intent is clear.

### 2. Map the project

Inspect the repository before judging code. Look at the README and setup docs, CI config, test directories, app entry points, framework config files, and recent git changes (`git status`, `git diff --stat`, recent commits).

Skip generated and dependency directories: `node_modules`, `vendor`, `.next`, `dist`, `build`, `coverage`, `.git`, `.venv`, `target`, `Pods`, `DerivedData`. Time spent there is time not spent on real code.

### 3. Detect the stack and its checks

Infer the language and framework from project files. Prefer the project's own commands over generic guesses. Read `package.json` scripts, `pyproject.toml`, `go.mod`, `Cargo.toml`, `composer.json`, `build.gradle`, `Gemfile`, or the equivalent first, then run the checks the project already defines: its test, lint, typecheck, and build commands.

If dependencies are missing, do not install them automatically. Report the missing prerequisite and continue with static inspection.

### 4. Inspect bug-prone areas

Look for high-signal defects, not style nits. Prioritize:

- Failing tests, build errors, type errors, lint errors that indicate real defects
- Runtime crashes and unhandled exceptions
- Incorrect async or concurrency behavior
- Null, undefined, or None handling mistakes
- Wrong data shape assumptions
- Boundary conditions and off-by-one errors
- Broken routing, imports, exports, or module resolution
- Configuration mismatches between code, env, and docs
- Database query bugs, transaction bugs, migration or ordering problems
- Auth or authorization logic mistakes visible in normal code review
- API contract mismatches between frontend and backend
- Resource leaks, missing cleanup, infinite loops, runaway retries
- Platform-specific path or case-sensitivity bugs
- Error handling that hides failures or returns success on failure

Do not frame cosmetic style preferences as bugs. If something is only a maintainability concern, put it in a separate non-critical section.

### 5. Validate every finding

For each suspected bug, gather at least one form of evidence: exact command output, file and line reference, test failure or reproduction step, code path explanation, mismatch between caller and callee, or a config and documentation contradiction.

If a finding cannot be validated, label it as a potential bug and explain what would confirm it. When a command fails, read the full relevant error and trace it to root cause before recommending a fix. Never pile fixes onto one symptom.

## Report Format

Write the report in the operator's language. Use this structure:

```markdown
# Bug Report: <project>

## Summary
- Project root: ...
- Stack detected: ...
- Commands run: ...
- Overall result: ...

## High priority bugs
### 1. <short title>
- Location: path/file.ext:line
- Evidence: ...
- Impact: ...
- Likely cause: ...
- Recommended fix: ...
- How to verify: command or reproduction steps

## Medium and low priority bugs
...

## Potential bugs needing confirmation
...

## Checks that could not run
- Command or prerequisite: ...
- Reason: ...
- Suggestion: ...

## Next steps
1. ...
2. ...
```

If no real bugs are found, say that clearly and list the checks performed. Then mention any risk areas that were not covered. An empty report that hides what was not checked is worse than no report.

## Safety Rules

- Do not modify files during the hunt.
- Do not run destructive commands (delete, database reset, migrations that alter data, deploys, credential rotation, production scripts).
- Do not install dependencies without permission.
- Do not expose secrets in the report. If a secret is found, redact it and report the file and path only.
- Prefer read-only commands and project-provided test and build commands.

## When the Operator Asks to Fix Bugs

After the operator selects findings to fix, switch from report mode to fix mode:

1. Reproduce the selected bug.
2. Identify the root cause (`systematic-debugging`).
3. Make the smallest targeted change.
4. Run the verification command.
5. Summarize changed files and remaining risks.

Fix one logical bug at a time unless the operator explicitly asks for a broader patch.

## Output

- The bug report, filed as a durable artifact, with severity per bug
- A list of checks that could not run, with reasons
- After fixes are approved: the changed files and the verification output per fix

## Verification

- The report exists before any fix begins
- Every bug in the report has at least one form of evidence
- Unvalidated findings are labeled as potential, never presented as confirmed
- Every fix is verified by its stated command or reproduction step

## The Forge Mark

This skill carries the Forge value in its substance: evidence before completion, output as changes. Ship means a shipped report and, once approved, a shipped fix with its verification, not a list of suspicions. Report by work: bugs found, evidence, fixes shipped. Use the related skills (`systematic-debugging` for root cause, `test-driven-development` for the failing test that proves the fix, `verification-before-completion` before the fix counts). Update the agent's memory with the bug patterns found so the same class of bug is caught earlier next time.

## Related Skills

- `systematic-debugging` - root cause investigation for a selected bug
- `test-driven-development` - the failing test that proves a fix
- `verification-before-completion` - proving a fix before it counts as done

## Research source

wildanfadh/project-bug-hunter-skill, https://github.com/wildanfadh/project-bug-hunter-skill
