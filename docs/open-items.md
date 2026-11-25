# Open items: Forge Anything

The full list of everything not done yet, in one place. Update it when
an item closes or changes. Sources: the curation plan, ROADMAP, PRD,
GitHub issues, and Galih's calls.

## Contents / curation (blocks the release)

- [ ] Curation plan decisions: 14 open questions (plan section 6; Q10
  and Q12 answered by v20, Q16 answered earlier, Q17 added for A16).
  Needs Galih.
- [ ] Curation execution (LAST work): agent folders, 115 Forge-native
  skill designs (117 v20 rows; 4 reference rows need no design),
  scaffold department templates, release skill prose
  rewrite (it still describes the old FORGEAI flow). Needs plan
  approval first.
- [ ] Scaffold curated lists (38 skills / 18 agents) still from issue
  #212, pre-registry. Changes when the plan is approved.
- [x] Registry v20 saved as the standard (25 Nov 2026, full file
  received, 121 rows counted). Replaces v15.
- [x] Registry URLs without sources: all 6 (v14 data-scientist,
  sql-queries, dbt, meeting-notes; v15 zapier-workflows,
  biohacking-advisor) now have URLs in v20, all checked HTTP 200
  on 25 Nov 2026.
- [ ] Registry URL problems recorded in the review (rag-architect wrong
  path, community-management dead, n8n-conventions dead). The registry
  text is verbatim, so the URLs are not edited in place; the correct
  paths live in the review and the plan.
- [ ] Registry rekap count discrepancy (118 claimed vs 121 counted;
  4 restores claimed vs 7 named). Recorded in the review; needs a
  closure sweep before the NOL GAP claim is trusted.
- [ ] fitness-nutrition URL still HTTP 500 (3rd check, 25 Nov 2026);
  Locke and Latham citation still 404 (25 Nov 2026).
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
