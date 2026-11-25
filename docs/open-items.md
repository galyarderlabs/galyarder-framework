# Open items — Forge Anything

The full list of everything not done yet, in one place. Update it when
an item closes or changes. Sources: the curation plan, ROADMAP, PRD,
GitHub issues, and Galih's calls.

## Contents / curation (blocks the release)

- [ ] Curation plan decisions: 15 open questions (plan section 6; Q16
  answered). Needs Galih.
- [ ] Curation execution (LAST work): agent folders, 95 Forge-native
  skill designs, scaffold department templates, release skill prose
  rewrite (it still describes the old FORGEAI flow). Needs plan
  approval first.
- [ ] Scaffold curated lists (38 skills / 18 agents) still from issue
  #212, pre-registry. Changes when the plan is approved.
- [ ] Registry v20 remainder not sent (truncated mid-A8), so v20 is not
  saved. Needs Galih.
- [ ] Registry URLs without sources (v14: data-scientist, sql-queries,
  dbt, meeting-notes; v15: zapier-workflows, biohacking-advisor).
  Needs Galih or research.
- [ ] Registry v20 URL fixes (rag-architect correct path,
  community-management dead 410). Only if v20 is saved.
- [ ] fitness-nutrition URL still HTTP 500; Locke and Latham citation
  still 404.
- [ ] `skills/social-content/references/reverse-engineering.md` has two
  leaked sections (Technical Integrity, Corporate Reporting).
- [ ] Pi bootstrap reads `skills/forge` (818 KB) instead of
  `using-forge-anything` (8 KB). Candidate for the curation pass.
- [ ] Banned-term cleanup in skill/agent/command bodies: Obsidian
  (32 files), Linear (31), sequentialthinking/context7, "rout"
  (39 files).

## MCP + CLI

- [ ] MCP full tool set (OpenCode 24 tools as base plus Forge
  additions). Now 5 tools. Needs a design go.
- [ ] MCP company import tool. Now CLI-only.
- [ ] MCP HTTP transport + auth (now stdio-only). Needed for deploy.
- [ ] CLI deploy (Cloudflare tunnel, domain auto settings, URL, key
  generation). Needs HTTP transport first.
- [ ] Company import does not surface company skills/agents at the
  project root.

## Release

- [ ] First public release tag. Waits until the contents are right
  (Galih, 25 Nov 2026: no release while the contents are not yet
  right).
- [ ] `--from-release` untestable until the first binary release.

## Hooks + issues

- [ ] Codex hook fire proof. Needs Galih's Codex login/API key plus a
  canary run.
- [ ] #213 Dependabot ws (high CVE-2026-48779, medium CVE-2026-45736).
  Opened as an issue per Galih, not fixed.
- [ ] #205 end-to-end example, #206 personas/, #207 CI parity, #19
  awesome-codex-plugins listing.

## Other

- [ ] Plain landing page. Not started.
- [ ] Backups in `~/workspace/forge-anything-unclear-docs/`. Keep or
  delete, Galih's call.
- [ ] Three install refs accepted as-is (OMP short name, Copilot
  marketplace, Cursor listing). Galih tests OMP himself.
