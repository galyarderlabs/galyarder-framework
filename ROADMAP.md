# Forge Anything: Roadmap

Forge anything with AI agents.

Using an AI agent should not be just generating code, and the agent should
not be confused. Forge Anything gives the agent the right rules and the
workflow to do the work the right way, and the flow closes at give back, with the next cycle starting at Ideas.
It is for solo founders and small teams who run AI agents across
engineering, product, growth, finance, security, and docs, and who need
that work to be routed, verified, and shipped instead of lost in a chat
thread.

## Where it is now

Forge Anything is at version 3.0.2. The repo is
`galyarderlabs/forge-anything`, licensed GPL-3.0-or-later.

The repo currently holds 176 individual skills (0 bundles), 41 agents, and 25 commands. That is
the inventory as it stands, not a target. The direction is to curate down
to essential only. The scaffold already ships the curated set (38 skills,
18 agents, all 25 commands); the full set is long-term curation work.

What ships today:

- **The `forge` CLI** (`crates/forge`, Rust). Subcommands: `scaffold`,
  `company`, `mcp`, `smoke`, `version`, `help`. `forge scaffold` drops a tidy repo
  into a folder. `forge company import` copies an agent-company package into
  a project. `forge mcp` runs the MCP server.
- **The MCP** (`forge mcp`). Five tools: `list_skills`, `read_skill`,
  `read_agent`, `read_command`, `scaffold`. Stdio, local only, no
  network. It is the distribution: install the MCP and a chatbot or an
  agent gets the tools plus the workflow.
- **The harness plugins.** Native plugins for Claude Code, OMP/Pi,
  Codex, Cursor, Antigravity, OpenCode, Copilot CLI, and Hermes.
  Everything installs via plugin, no manual setup. See
  `docs/INTEGRATION.md`.
- **The install script.** `install.sh` downloads the prebuilt `forge`
  binary from GitHub Releases and verifies its SHA256 checksum.
- **Skills via skills.sh.** `npx skills add
  galyarderlabs/forge-anything` installs the skills from GitHub. npm is
  no longer used; the skills come from GitHub, and the CLI comes from
  GitHub Releases.
- **CI.** Smoke test, Rust (fmt, clippy, build, test), repo hygiene, and
  CodeQL run on pushes to main.

What is not there yet:

- **No release ships the prebuilt `forge` binary.** GitHub release
  v3.0.0 exists, but it predates the release workflow and ships no
  binary. The first release that ships the binary needs a version tag
  push.
- **No docs site.** The old docs site was removed; the old site URL is
  404. The docs live in `docs/` in the repo. A plain landing page is
  future work, not live.
- **CHANGELOG.md is stale.** It stops at 2.0.0 and does not cover the
  rebrand, the license change, or anything since.

## Now

- **Cut the first release with prebuilt binaries.** Push a version tag,
  which triggers the release workflow to build the `forge` binary for
  Linux, macOS, and Windows and attach it to a GitHub Release with
  SHA256SUMS. This is the live proof that the curl install path works.
- **Build the plain landing page.** A simple page that says what Forge
  Anything is and how to install it. Not a docs site; that stays
  removed.
- **Verify the three install references that are not yet proven against
  a live install.** OMP: whether the install ref wants the short name
  `forge-anything` or the scoped name `@galyarderlabs/forge-anything`.
  Copilot CLI: whether the marketplace name matches Claude Code.
  Cursor: whether `forge-anything` is listed in the Cursor plugin
  marketplace.

## Next

- **Skills curation, long term.** Bring the full set down to essential
  only, after everything is tidy. The scaffold already ships the curated
  set; the rest of the repo is the work. The standard was the Essential
  Skill Registry (v20 research input); its docs were removed once curation finished.
- **CHANGELOG and release notes for 3.0.0 and 3.0.2.** The changelog
  stops at 2.0.0. It needs entries for the rebrand, the GPL-3.0 license,
  the Rust scaffold and CLI, the plugin surface, the Hermes hook, the
  integrations removal, and the distribution plus MCP build.
- **Open issues.** #205 (a worked end-to-end mission example), #206
  (the stale directory reference; the references are removed by
  the AGENTS.md rewrite, so this can close once that lands), #207 (guard
  manifest and generated-surface parity in CI), #19 (listing in
  awesome-codex-plugins).
- **Open items.** The full list of everything not done yet, in one
  place: `docs/open-items.md`.

## Later

- **The MCP tool set grows toward the full coding-agent tool set.** The
  MCP today has five tools. The direction, from the start, is for it to
  carry the tools an agent needs to forge anything: file and code work,
  system access, web, media, and the workflow itself. The base is the
  OpenCode tool set (24 tools, including read, write, edit, patch,
  glob, grep, shell, webfetch, websearch, image and video generation,
  skill, subagent, todo, artifact, automation, machine), plus Forge
  additions for company, life, and workflow. The scope is every
  agentic workflow the MCP can carry: write code, access systems,
  read and write, run Python, generate images and video, and the
  rest. It stays local-only with no network.

## Not planned

- **No hosted cloud service.** Forge Anything is local, inspectable
  files and a local binary. There is no plan to turn it into a managed
  SaaS.
- **No autonomous execution without approval.** Human command is a core
  principle. Public, financial, irreversible, or production-sensitive
  actions keep a human gate.
- **No model training or fine-tuning.** This layer routes and governs
  work; it does not train models.
- **No license change.** The project is GPL-3.0-or-later and stays that
  way.

## How to follow along

Read the README and the `docs/` directory in the repo. Watch the issues
and releases on GitHub for what is landing. Open an issue for a concrete
bug or a scoped proposal, and send a pull request against `main`. A clear,
well-scoped issue is the fastest way to get a change reviewed.
