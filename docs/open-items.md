# Open items: Forge Anything

The full list of everything not done yet, in one place. Update it when
an item closes or changes. Sources: the curation plan, ROADMAP, PRD,
GitHub issues, and Galih's calls.

## Contents / curation (blocks the release)

- [ ] Curation plan decisions: Q1-Q5 and Q9 ANSWERED and executed
  25 Nov 2026 (Galih 16:16: 7 new departments, cut 28 + narrow 4,
  41 drafts applied). Q6 (trading cluster 2 agents, defi-audit stays
  with security-guardian) and Q13 (video-analyst stays separate)
  ANSWERED 25 Nov 2026 (Galih 16:47). Still open: Q14 (first design
  slice; answered in practice by waves 1-5 in order), Q15 (18 proposed
  commands, which first), Q17 (A16 split stands: agent-ops to
  Infrastructure, gamedev to Creative, scientific to Knowledge).
  Q17 agents ANSWERED 25 Nov 2026 (Galih 17:24): ai-researcher folds
  into research, team-orchestrator folds into forge-specialist
  (56 agents become 54); agent-ops, game-developer and
  scientific-researcher stay separate.
  Needs Galih for Q15.
- [x] Curation execution (LAST work): agent folders DONE 26 Nov 2026
  (Galih 13:02: "lanjut, bikin folder agent"): 54 folders, each
  README.md + SOUL.md + MEMORY.md (files fully capitalized 26 Nov 2026;
  folders stay lowercase slugs); 41 old single .md files removed;
  forge-cfo-coo split, 6 agents merged into software-engineer,
  renames videomaker + qa-engineer applied, ai-researcher and
  team-orchestrator folded (no folders). Souls restructured per agent
  26 Nov 2026 (16 section patterns, Receive first dropped); READMEs +
  MEMORY.md fixed 27 Nov 2026 (fb352a39: Research source lines removed,
  "Galih" 0 occurrences in agents/, MEMORY.md 4 patterns by value);
  souls verified against their actual research sources 27 Nov 2026
  (46 of 54 rewritten: wrong severity scales and missing frameworks
  fixed, e.g. code-reviewer now Critical/Required/Optional/Nit with
  the five-dimension framework; 8 no-registry-row agents unchanged).
  Release skill prose rewrite
  still open (it still describes the old FORGEAI flow). Skills part
  DONE 26 Nov 2026:
  115 Forge-native designs written, 115 in the repo. community-ops
  completed 26 Nov 2026 (Galih 07:38: replacement source
  coreyhaines31/community-marketing v2.0.5, dead absolutelyskilled
  URL replaced). Scaffold department
  templates DONE: 17 departments seeded.
- [x] Forge value paragraph on all 175 skills: DONE 26 Nov 2026
  (Galih 07:18: the value is mandatory, add it). The 67 pre-curation
  skills got their `## The Forge Mark` (commit f433f8f1); the bootstrap
  file was trimmed to stay under the 10,000-char Hermes limit
  (9,778 assembled after the trim).
- [ ] Scaffold curated lists (33 skills / 18 agents) still from issue
  #212, pre-registry. Count moved 38 to 33 in the Phase 2 fix (9
  deleted skills replaced by their successors). Changes when the plan
  is approved.
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
- [ ] fitness-nutrition URL still HTTP 500 (4th check, 25 Nov 2026);
  Locke and Latham citation still 404 (25 Nov 2026).
- [x] `skills/social-content/references/reverse-engineering.md` leaked
  sections (Technical Integrity, Corporate Reporting). Resolved by
  deletion: the whole `social-content` skill was cut 25 Nov 2026,
  the file no longer exists.
- [x] Pi bootstrap reads `skills/forge` (818 KB) instead of
  `using-forge-anything` (8 KB). FIXED 25 Nov 2026:
  `.pi/extensions/forge-anything.ts` now loads
  `skills/using-forge-anything/SKILL.md`; Pi test 6/6 passing.
- [x] Bundle drift (6 of 10 bundles did not match sync-bundles.py
  regen): resolved by DELETION, not regen, 25 Nov 2026 — all 18 bundle
  dirs + `scripts/sync-bundles.py` removed (commit 4ad7ac51);
  `skills.json` regenerated to 175 entries, 0 bundles. Scaffold source
  marker moved to `skills/using-forge-anything/SKILL.md`.
- [ ] Banned-term cleanup in skill/agent/command bodies (recounted
  25 Nov 2026 after the cut, case-insensitive file count): Obsidian
  (37 files), Linear (47), sequentialthinking/context7 (3).

## MCP + CLI

- [ ] MCP full tool set (OpenCode 24 tools as base plus Forge
  additions). Now 4 tools. Needs a design go.
- [x] Agent-read MCP tool — CLOSED 26 Nov 2026 (Galih's order: only
  its own test called it; a skills-only MCP is coherent). The tool is
  removed, not open. MCP now 4 tools: `list_skills`, `read_skill`,
  `read_command`, `scaffold`.
- [ ] MCP company import tool. Now CLI-only.
- [ ] MCP HTTP transport + auth (now stdio-only). Needed for deploy.
- [ ] CLI deploy (Cloudflare tunnel, domain auto settings, URL, key
  generation). Needs HTTP transport first.
- [ ] Company import does not surface company skills/agents at the
  project root.

## Release

- [ ] First public release tag. Contents are now right (curation
  executed 25 Nov 2026: 7 departments, cut done, 41 drafts applied);
  the tag itself still waits on Galih's word (Galih, 25 Nov 2026:
  no release while the contents are not yet right).
- [ ] `--from-release` untestable until the first binary release.

## Hooks + issues

- [ ] Codex hook fire proof. Needs Galih's Codex login/API key plus a
  canary run.
- [x] #213 Dependabot ws (high CVE-2026-48779, medium CVE-2026-45736).
  CLOSED 25 Nov 2026: the vulnerable `ws` copy lived only in the
  vendored `tests/brainstorm-server/node_modules/` for the skipped
  brainstorm-server tests; that directory was deleted, so `ws` is gone
  from the repo entirely. The brainstorm server itself (Node built-ins
  only) was kept.
- [x] #206 personas/ — CLOSED 25 Nov 2026: the live docs no longer
  describe `personas/` as canonical runtime (only the historical
  CHANGELOG.md / RELEASE-NOTES.md mention it, and history is not
  rewritten); the only other mention was this file's own list.
- [x] #207 CI parity — CLOSED 25 Nov 2026: `sync-skills-manifest.py`
  gained a `--check` mode (exit 1 on drift, changes nothing) wired into
  the smoke-test workflow; the old docs/skills/ and integrations/
  mirrors the issue cited are already deleted, and plugin versions were
  already checked.
- [ ] #205 end-to-end example, #19 awesome-codex-plugins listing.

## Other

- [ ] Plain landing page. Not started.
- [ ] Backups in `~/workspace/forge-anything-unclear-docs/`. Keep or
  delete, Galih's call.
- [ ] Three install refs accepted as-is (OMP short name, Copilot
  marketplace, Cursor listing). Galih tests OMP himself.
