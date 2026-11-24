# Session Management: Designing for Long Runs

Sessions allow agents to maintain conversation context across runs. The system is **codec-based**  each adapter defines how to serialize/deserialize its session state.

**Design for long runs from the start.** Treat session reuse as the default primitive, not an optimization to add later. An agent working on an issue may be woken dozens of times  for the initial assignment, approval callbacks, re-assignments, manual nudges. Each wake should resume the existing conversation so the agent retains full context about what it has already done, what files it has read, and what decisions it has made. Starting fresh each time wastes tokens on re-reading the same files and risks contradictory decisions.

**Key concepts:**
- `sessionParams` is an opaque `Record<string, unknown>` stored in the DB per task
- The adapter's `sessionCodec.serialize()` converts execution result data to storable params
- `sessionCodec.deserialize()` converts stored params back for the next run
- `sessionCodec.getDisplayId()` extracts a human-readable session ID for the UI
- **cwd-aware resume**: if the session was created in a different cwd than the current config, skip resuming (prevents cross-project session contamination)
- **Unknown session retry**: if resume fails with a "session not found" error, retry with a fresh session and return `clearSession: true` so Forge Anything wipes the stale session

If the agent runtime supports any form of context compaction or conversation compression (e.g. Claude Code's automatic context management, or Codex's `previous_response_id` chaining), lean on it. Adapters that support session resume get compaction for free  the agent runtime handles context window management internally across resumes.

**Pattern** (from both claude-local and codex-local):

```ts
const canResumeSession =
  runtimeSessionId.length > 0 &&
  (runtimeSessionCwd.length === 0 || path.resolve(runtimeSessionCwd) === path.resolve(cwd));
const sessionId = canResumeSession ? runtimeSessionId : null;

// ... run attempt ...

// If resume failed with unknown session, retry fresh
if (sessionId && !proc.timedOut && exitCode !== 0 && isUnknownSessionError(output)) {
  const retry = await runAttempt(null);
  return toResult(retry, { clearSessionOnMissingSession: true });
}
```

---
