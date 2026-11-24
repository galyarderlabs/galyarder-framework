# Hermes Agent Tool Mapping

Skills speak in actions; on Hermes they resolve to these tools:

## Tools

| Action skills request | Hermes tool |
|---|---|
| Read a file | `read_file` |
| Create a new file | `write_file` |
| Edit a file (targeted patch) | `patch` |
| Run a shell command | `terminal` |
| Search file contents | `search_files` |
| Find files by name | `terminal` with `find` |
| Fetch a URL / read a webpage | `web_extract(urls=[...])` |
| Search the web | `web_search(query=...)` |
| Dispatch a subagent | `delegate_task(goal=..., context=..., toolsets=[...], role="leaf")` |
| Task tracking | `todo` tool |
| Invoke a skill | `skill_view("skill-name")` (list with `skills_list`) |

## Instructions file

A skill's "instructions file" is `AGENTS.md` in the project directory, or `~/.hermes/SOUL.md` globally.

## Subagent dispatch

Use `delegate_task` for parallel or sequential workstreams; if it is unavailable, do the work inline rather than inventing tool calls.

## Task tracking

Use the `todo` tool for task tracking (multi-agent boards: `hermes kanban` CLI if available); treat older `TodoWrite` references as the task-tracking action.
