---
name: release-changelog
description: >
  Draft the Forge Anything release entry for the root CHANGELOG.md from the
  commits and merged PRs since the last version tag. Use when the release
  needs its changelog entry written, not merely to discuss versioning.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Release Changelog Skill

Draft the user-facing changelog entry for a Forge Anything release. The entry lives in the root `CHANGELOG.md` under `## [<version>] - <YYYY-MM-DD>`. There is no `releases/` directory and no calver: the version is semver from `package.json`.

Write from the user perspective: what changed for someone installing or using Forge Anything. Group related commits into one user-facing entry. Exclude purely internal refactors, CI changes, and docs-only work unless they materially affect users.

## Step 0  Idempotency check

Before writing anything, check whether `CHANGELOG.md` already has an entry for the version:

```bash
grep -n "## \[<version>\]" CHANGELOG.md
```

If it exists, read it first, present it to the reviewer, and ask whether to keep it, regenerate it, or update specific sections. Never overwrite it silently.

## Step 1  Determine the range

Find the last version tag:

```bash
git tag --list 'v*' --sort=-version:refname | head -1
git log <last-tag>..HEAD --oneline --no-merges
```

The range is the last tag to HEAD (or to the candidate SHA for the release). The version comes from `package.json`, never from a date or a canary tag.

## Step 2  Gather the raw inputs

Collect release data from:

1. git commits since the last version tag
2. merged PRs via `gh` when available

Useful commands:

```bash
git log <last-tag>..HEAD --oneline --no-merges
git log <last-tag>..HEAD --format="%H %s" --no-merges
gh pr list --state merged --search "merged:>={last-tag-date}" --json number,title,body,labels
```

This repo has no changesets. Do not look for `.changeset` files.

## Step 3  Detect breaking changes

Look for:

- destructive migrations
- removed or changed API fields, endpoints, or config keys
- renamed or removed commands, skills, or agents
- `BREAKING:` or `BREAKING CHANGE:` commit signals

Flag breaking changes prominently under `### Breaking Changes`, with an upgrade path. If there are none, omit the section.

## Step 4  Categorize for users

Use the sections the changelog already uses:

- `### Breaking Changes` (only when there are any)
- `### Added`
- `### Changed`
- `### Fixed`
- `### Migration` (only when a migration needs steps)

Omit empty sections. Do not add a contributors section and do not add PR links: the changelog carries neither.

## Step 5  Write the entry

Insert the entry at the top of `CHANGELOG.md`, under the `# Changelog` heading and its intro line, above the previous version's entry. Template:

```markdown
## [<version>] - <YYYY-MM-DD>

### Added

### Changed

### Fixed
```

Keep highlights short and concrete. Spell out upgrade actions for breaking changes.

## Step 6  Review before release

Before handing it off:

1. confirm the heading is the version only, with the release date
2. confirm there is no calver or canary language anywhere in the entry
3. confirm any breaking changes have an upgrade path
4. present the draft for human sign-off

This skill never publishes anything. It only prepares the changelog entry.

## The Forge Mark

This skill carries the Forge value in its substance: no AI slop, flow ideas to give back, everything evidence-based, output as changes. Ship means a `CHANGELOG.md` entry for the version with breaking changes flagged and upgrade paths spelled out, not a summary of commits in chat. An entry derived from a canary tag or written to a `releases/` file does not ship. Report by work: range determined, commits and PRs gathered, breaking changes flagged with upgrade paths, entry written and reviewed. Use the related skills (`release` when the entry feeds a release, `verification-before-completion` before the draft is handed off as ready). Update release-manager memory with the version, the breaking changes and their upgrade paths, so the next changelog starts from what is proven.