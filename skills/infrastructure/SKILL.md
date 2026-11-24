---
name: infrastructure
description: "Consolidated Forge Anything Infrastructure intelligence bundle."
---

# FORGE INFRASTRUCTURE BUNDLE

This bundle contains 2 high-integrity SOPs for the Infrastructure department.


---
## SKILL: release-changelog
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Release Changelog Skill

Generate the user-facing changelog for the **stable** Forge Anything release.

## Versioning Model

Forge Anything uses **calendar versioning (calver)**:

- Stable releases: `YYYY.MDD.P` (e.g. `2026.318.0`)
- Canary releases: `YYYY.MDD.P-canary.N` (e.g. `2026.318.1-canary.0`)
- Git tags: `vYYYY.MDD.P` for stable, `canary/vYYYY.MDD.P-canary.N` for canary

There are no major/minor/patch bumps. The stable version is derived from the
intended release date (UTC) plus the next same-day stable patch slot.

Output:

- `releases/vYYYY.MDD.P.md`

Important rules:

- even if there are canary releases such as `2026.318.1-canary.0`, the changelog file stays `releases/v2026.318.1.md`
- do not derive versions from semver bump types
- do not create canary changelog files

## Step 0  Idempotency Check

Before generating anything, check whether the file already exists:

```bash
ls releases/vYYYY.MDD.P.md 2>/dev/null
```

If it exists:

1. read it first
2. present it to the reviewer
3. ask whether to keep it, regenerate it, or update specific sections
4. never overwrite it silently

## Step 1  Determine the Stable Range

Find the last stable tag:

```bash
git tag --list 'v*' --sort=-version:refname | head -1
git log v{last}..HEAD --oneline --no-merges
```

The stable version comes from one of:

- an explicit maintainer request
- `./scripts/release.sh stable --date YYYY-MM-DD --print-version`
- the release plan already agreed in `doc/RELEASING.md`

Do not derive the changelog version from a canary tag or prerelease suffix.
Do not derive major/minor/patch bumps from API intent  calver uses the date and same-day stable slot.

## Step 2  Gather the Raw Inputs

Collect release data from:

1. git commits since the last stable tag
2. `.changeset/*.md` files
3. merged PRs via `gh` when available

Useful commands:

```bash
git log v{last}..HEAD --oneline --no-merges
git log v{last}..HEAD --format="%H %s" --no-merges
ls .changeset/*.md | grep -v README.md
gh pr list --state merged --search "merged:>={last-tag-date}" --json number,title,body,labels
```

## Step 3  Detect Breaking Changes

Look for:

- destructive migrations
- removed or changed API fields/endpoints
- renamed or removed config keys
- `BREAKING:` or `BREAKING CHANGE:` commit signals

Key commands:

```bash
git diff --name-only v{last}..HEAD -- packages/db/src/migrations/
git diff v{last}..HEAD -- packages/db/src/schema/
git diff v{last}..HEAD -- server/src/routes/ server/src/api/
git log v{last}..HEAD --format="%s" | rg -n 'BREAKING CHANGE|BREAKING:|^[a-z]+!:' || true
```

If breaking changes are detected, flag them prominently  they must appear in the
Breaking Changes section with an upgrade path.

## Step 4  Categorize for Users

Use these stable changelog sections:

- `Breaking Changes`
- `Highlights`
- `Improvements`
- `Fixes`
- `Upgrade Guide` when needed

Exclude purely internal refactors, CI changes, and docs-only work unless they materially affect users.

Guidelines:

- group related commits into one user-facing entry
- write from the user perspective
- keep highlights short and concrete
- spell out upgrade actions for breaking changes

### Inline PR and contributor attribution

When a bullet item clearly maps to a merged pull request, add inline attribution at the
end of the entry in this format:

```
- **Feature name**  Description. ([#123](https://github.com/galyarderlabs/forge-anything/pull/123), @contributor1, @contributor2)
```

Rules:

- Only add a PR link when you can confidently trace the bullet to a specific merged PR.
  Use merge commit messages (`Merge pull request #N from user/branch`) to map PRs.
- List the contributor(s) who authored the PR. Use GitHub usernames, not real names or emails.
- If multiple PRs contributed to a single bullet, list them all: `([#10](url), [#12](url), @user1, @user2)`.
- If you cannot determine the PR number or contributor with confidence, omit the attribution
  parenthetical  do not guess.
- Core maintainer commits that don't have an external PR can omit the parenthetical.

## Step 5  Write the File

Template:

```markdown
# vYYYY.MDD.P

> Released: YYYY-MM-DD

## Breaking Changes

## Highlights

## Improvements

## Fixes

## Upgrade Guide

## Contributors

Thank you to everyone who contributed to this release!

@username1, @username2, @username3
```

Omit empty sections except `Highlights`, `Improvements`, and `Fixes`, which should usually exist.

The `Contributors` section should always be included. List every person who authored
commits in the release range, @-mentioning them by their **GitHub username** (not their
real name or email). To find GitHub usernames:

1. Extract usernames from merge commit messages: `git log v{last}..HEAD --oneline --merges`  the branch prefix (e.g. `from username/branch`) gives the GitHub username.
2. For noreply emails like `user@users.noreply.github.com`, the username is the part before `@`.
3. For contributors whose username is ambiguous, check `gh api users/{guess}` or the PR page.

**Never expose contributor email addresses.** Use `@username` only.

Exclude bot accounts (e.g. `lockfile-bot`, `dependabot`) from the list. List contributors
in alphabetical order by GitHub username (case-insensitive).

## Step 6  Review Before Release

Before handing it off:

1. confirm the heading is the stable version only
2. confirm there is no `-canary` language in the title or filename
3. confirm any breaking changes have an upgrade path
4. present the draft for human sign-off

This skill never publishes anything. It only prepares the stable changelog artifact.

---
## SKILL: release
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Release Coordination Skill

Run the full Forge Anything maintainer release workflow, not just an npm publish.

This skill coordinates:

- stable changelog drafting via `release-changelog`
- canary verification and publish status from `master`
- Docker smoke testing via `scripts/docker-onboard-smoke.sh`
- manual stable promotion from a chosen source ref
- GitHub Release creation
- website / announcement follow-up tasks

## Trigger

Use this skill when leadership asks for:

- "do a release"
- "ship the release"
- "promote this canary to stable"
- "cut the stable release"

## Preconditions

Before proceeding, verify all of the following:

1. `Infrastructure/skills/release-changelog/SKILL.md` exists and is usable.
2. The repo working tree is clean, including untracked files.
3. There is at least one canary or candidate commit since the last stable tag.
4. The candidate SHA has passed the verification gate or is about to.
5. If manifests changed, the CI-owned `pnpm-lock.yaml` refresh is already merged on `master`.
6. npm publish rights are available through GitHub trusted publishing, or through local npm auth for emergency/manual use.
7. If running through Forge Anything, you have issue context for status updates and follow-up task creation.

If any precondition fails, stop and report the blocker.

## Inputs

Collect these inputs up front:

- whether the target is a canary check or a stable promotion
- the candidate `source_ref` for stable
- whether the stable run is dry-run or live
- release issue / company context for website and announcement follow-up

## Step 0  Release Model

Forge Anything now uses a commit-driven release model:

1. every push to `master` publishes a canary automatically
2. canaries use `YYYY.MDD.P-canary.N`
3. stable releases use `YYYY.MDD.P`
4. the middle slot is `MDD`, where `M` is the UTC month and `DD` is the zero-padded UTC day
5. the stable patch slot increments when more than one stable ships on the same UTC date
6. stable releases are manually promoted from a chosen tested commit or canary source commit
7. only stable releases get `releases/vYYYY.MDD.P.md`, git tag `vYYYY.MDD.P`, and a GitHub Release

Critical consequences:

- do not use release branches as the default path
- do not derive major/minor/patch bumps
- do not create canary changelog files
- do not create canary GitHub Releases

## Step 1  Choose the Candidate

For canary validation:

- inspect the latest successful canary run on `master`
- record the canary version and source SHA

For stable promotion:

1. choose the tested source ref
2. confirm it is the exact SHA you want to promote
3. resolve the target stable version with `./scripts/release.sh stable --date YYYY-MM-DD --print-version`

Useful commands:

```bash
git tag --list 'v*' --sort=-version:refname | head -1
git log --oneline --no-merges
npm view forge-anything@canary version
```

## Step 2  Draft the Stable Changelog

Stable changelog files live at:

- `releases/vYYYY.MDD.P.md`

Invoke `release-changelog` and generate or update the stable notes only.

Rules:

- review the draft with a human before publish
- preserve manual edits if the file already exists
- keep the filename stable-only
- do not create a canary changelog file

## Step 3  Verify the Candidate SHA

Run the standard gate:

```bash
pnpm -r typecheck
pnpm test:run
pnpm build
```

If the GitHub release workflow will run the publish, it can rerun this gate. Still report local status if you checked it.

For PRs that touch release logic, the repo also runs a canary release dry-run in CI. That is a release-specific guard, not a substitute for the standard gate.

## Step 4  Validate the Canary

The normal canary path is automatic from `master` via:

- `.github/workflows/release.yml`

Confirm:

1. verification passed
2. npm canary publish succeeded
3. git tag `canary/vYYYY.MDD.P-canary.N` exists

Useful checks:

```bash
npm view forge-anything@canary version
git tag --list 'canary/v*' --sort=-version:refname | head -5
```

## Step 5  Smoke Test the Canary

Run:

```bash
FORGEAI_VERSION=canary ./scripts/docker-onboard-smoke.sh
```

Useful isolated variant:

```bash
HOST_PORT=3232 DATA_DIR=./data/release-smoke-canary FORGEAI_VERSION=canary ./scripts/docker-onboard-smoke.sh
```

Confirm:

1. install succeeds
2. onboarding completes without crashes
3. the server boots
4. the UI loads
5. basic company creation and dashboard load work

If smoke testing fails:

- stop the stable release
- fix the issue on `master`
- wait for the next automatic canary
- rerun smoke testing

## Step 6  Preview or Publish Stable

The normal stable path is manual `workflow_dispatch` on:

- `.github/workflows/release.yml`

Inputs:

- `source_ref`
- `stable_date`
- `dry_run`

Before live stable:

1. resolve the target stable version with `./scripts/release.sh stable --date YYYY-MM-DD --print-version`
2. ensure `releases/vYYYY.MDD.P.md` exists on the source ref
3. run the stable workflow in dry-run mode first when practical
4. then run the real stable publish

The stable workflow:

- re-verifies the exact source ref
- computes the next stable patch slot for the chosen UTC date
- publishes `YYYY.MDD.P` under dist-tag `latest`
- creates git tag `vYYYY.MDD.P`
- creates or updates the GitHub Release from `releases/vYYYY.MDD.P.md`

Local emergency/manual commands:

```bash
./scripts/release.sh stable --dry-run
./scripts/release.sh stable
git push public-gh refs/tags/vYYYY.MDD.P
./scripts/create-github-release.sh YYYY.MDD.P
```

## Step 7  Finish the Other Surfaces

Create or verify follow-up work for:

- website changelog publishing
- launch post / social announcement
- release summary in Forge Anything issue context

These should reference the stable release, not the canary.

## Failure Handling

If the canary is bad:

- publish another canary, do not ship stable

If stable npm publish succeeds but tag push or GitHub release creation fails:

- fix the git/GitHub issue immediately from the same release result
- do not republish the same version

If `latest` is bad after stable publish:

```bash
./scripts/rollback-latest.sh <last-good-version>
```

Then fix forward with a new stable release.

## Output

When the skill completes, provide:

- candidate SHA and tested canary version, if relevant
- stable version, if promoted
- verification status
- npm status
- smoke-test status
- git tag / GitHub Release status
- website / announcement follow-up status
- rollback recommendation if anything is still partially complete

---

# Release Coordination Skill

Run the full Forge Anything maintainer release workflow, not just an npm publish.

This skill coordinates:

- stable changelog drafting via `release-changelog`
- canary verification and publish status from `master`
- Docker smoke testing via `scripts/docker-onboard-smoke.sh`
- manual stable promotion from a chosen source ref
- GitHub Release creation
- website / announcement follow-up tasks

## Trigger

Use this skill when leadership asks for:

- "do a release"
- "ship the release"
- "promote this canary to stable"
- "cut the stable release"

## Preconditions

Before proceeding, verify all of the following:

1. `Infrastructure/skills/release-changelog/SKILL.md` exists and is usable.
2. The repo working tree is clean, including untracked files.
3. There is at least one canary or candidate commit since the last stable tag.
4. The candidate SHA has passed the verification gate or is about to.
5. If manifests changed, the CI-owned `pnpm-lock.yaml` refresh is already merged on `master`.
6. npm publish rights are available through GitHub trusted publishing, or through local npm auth for emergency/manual use.
7. If running through Forge Anything, you have issue context for status updates and follow-up task creation.

If any precondition fails, stop and report the blocker.

## Inputs

Collect these inputs up front:

- whether the target is a canary check or a stable promotion
- the candidate `source_ref` for stable
- whether the stable run is dry-run or live
- release issue / company context for website and announcement follow-up

## Step 0  Release Model

Forge Anything now uses a commit-driven release model:

1. every push to `master` publishes a canary automatically
2. canaries use `YYYY.MDD.P-canary.N`
3. stable releases use `YYYY.MDD.P`
4. the middle slot is `MDD`, where `M` is the UTC month and `DD` is the zero-padded UTC day
5. the stable patch slot increments when more than one stable ships on the same UTC date
6. stable releases are manually promoted from a chosen tested commit or canary source commit
7. only stable releases get `releases/vYYYY.MDD.P.md`, git tag `vYYYY.MDD.P`, and a GitHub Release

Critical consequences:

- do not use release branches as the default path
- do not derive major/minor/patch bumps
- do not create canary changelog files
- do not create canary GitHub Releases

## Step 1  Choose the Candidate

For canary validation:

- inspect the latest successful canary run on `master`
- record the canary version and source SHA

For stable promotion:

1. choose the tested source ref
2. confirm it is the exact SHA you want to promote
3. resolve the target stable version with `./scripts/release.sh stable --date YYYY-MM-DD --print-version`

Useful commands:

```bash
git tag --list 'v*' --sort=-version:refname | head -1
git log --oneline --no-merges
npm view forge-anything@canary version
```

## Step 2  Draft the Stable Changelog

Stable changelog files live at:

- `releases/vYYYY.MDD.P.md`

Invoke `release-changelog` and generate or update the stable notes only.

Rules:

- review the draft with a human before publish
- preserve manual edits if the file already exists
- keep the filename stable-only
- do not create a canary changelog file

## Step 3  Verify the Candidate SHA

Run the standard gate:

```bash
pnpm -r typecheck
pnpm test:run
pnpm build
```

If the GitHub release workflow will run the publish, it can rerun this gate. Still report local status if you checked it.

For PRs that touch release logic, the repo also runs a canary release dry-run in CI. That is a release-specific guard, not a substitute for the standard gate.

## Step 4  Validate the Canary

The normal canary path is automatic from `master` via:

- `.github/workflows/release.yml`

Confirm:

1. verification passed
2. npm canary publish succeeded
3. git tag `canary/vYYYY.MDD.P-canary.N` exists

Useful checks:

```bash
npm view forge-anything@canary version
git tag --list 'canary/v*' --sort=-version:refname | head -5
```

## Step 5  Smoke Test the Canary

Run:

```bash
FORGEAI_VERSION=canary ./scripts/docker-onboard-smoke.sh
```

Useful isolated variant:

```bash
HOST_PORT=3232 DATA_DIR=./data/release-smoke-canary FORGEAI_VERSION=canary ./scripts/docker-onboard-smoke.sh
```

Confirm:

1. install succeeds
2. onboarding completes without crashes
3. the server boots
4. the UI loads
5. basic company creation and dashboard load work

If smoke testing fails:

- stop the stable release
- fix the issue on `master`
- wait for the next automatic canary
- rerun smoke testing

## Step 6  Preview or Publish Stable

The normal stable path is manual `workflow_dispatch` on:

- `.github/workflows/release.yml`

Inputs:

- `source_ref`
- `stable_date`
- `dry_run`

Before live stable:

1. resolve the target stable version with `./scripts/release.sh stable --date YYYY-MM-DD --print-version`
2. ensure `releases/vYYYY.MDD.P.md` exists on the source ref
3. run the stable workflow in dry-run mode first when practical
4. then run the real stable publish

The stable workflow:

- re-verifies the exact source ref
- computes the next stable patch slot for the chosen UTC date
- publishes `YYYY.MDD.P` under dist-tag `latest`
- creates git tag `vYYYY.MDD.P`
- creates or updates the GitHub Release from `releases/vYYYY.MDD.P.md`

Local emergency/manual commands:

```bash
./scripts/release.sh stable --dry-run
./scripts/release.sh stable
git push public-gh refs/tags/vYYYY.MDD.P
./scripts/create-github-release.sh YYYY.MDD.P
```

## Step 7  Finish the Other Surfaces

Create or verify follow-up work for:

- website changelog publishing
- launch post / social announcement
- release summary in Forge Anything issue context

These should reference the stable release, not the canary.

## Failure Handling

If the canary is bad:

- publish another canary, do not ship stable

If stable npm publish succeeds but tag push or GitHub release creation fails:

- fix the git/GitHub issue immediately from the same release result
- do not republish the same version

If `latest` is bad after stable publish:

```bash
./scripts/rollback-latest.sh <last-good-version>
```

Then fix forward with a new stable release.

## Output

When the skill completes, provide:

- candidate SHA and tested canary version, if relevant
- stable version, if promoted
- verification status
- npm status
- smoke-test status
- git tag / GitHub Release status
- website / announcement follow-up status
- rollback recommendation if anything is still partially complete
