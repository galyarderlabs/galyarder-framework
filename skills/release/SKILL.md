---
name: release
description: >
  Coordinate a Forge Anything release: semver from package.json, checks and
  gates through scripts/release.sh, and a version tag that triggers the
  release workflow to build the prebuilt forge binaries and create the
  GitHub Release. Use when leadership asks to ship a release, not merely
  to discuss versioning.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Release Coordination Skill

Run the Forge Anything maintainer release workflow: one version, one tag, one GitHub Release with the prebuilt binaries.

This skill coordinates:

- the version decision and the CHANGELOG.md entry
- verification through `scripts/release.sh --check`
- local tag creation through `scripts/release.sh stable --live`
- the tag push, which triggers `.github/workflows/release.yml`
- verification of the built binaries and the GitHub Release
- the install check from the published release

There is no npm publish, no canary, no Docker image, and no `releases/` directory. The changelog is the root `CHANGELOG.md`, and the version comes from `package.json`.

## Trigger

Use this skill when leadership asks for:

- "do a release"
- "ship the release"
- "cut the release"
- "tag the release"

## Preconditions

Before proceeding, verify all of the following:

1. The working tree is clean, including untracked files. `release.sh --check` verifies this; commit or stash first.
2. `package.json` holds the version to ship, and `CHANGELOG.md` has an entry for that version.
3. The operator has approved the release. A tag push is public and irreversible in effect: it triggers the release workflow.

If any precondition fails, stop and report the blocker.

## Step 0  Release model

Forge Anything releases with semver:

1. `package.json` is the only version source. The tag is `v<version>` (for example `v3.0.2`).
2. Pushing the tag triggers `.github/workflows/release.yml`, which builds the `forge` CLI for 5 targets (Linux x86_64 and aarch64, macOS x86_64 and aarch64, Windows x86_64), smoke-checks each binary it can run, and creates the GitHub Release with the 5 archives plus `SHA256SUMS`. Release notes are generated from merged PRs.
3. `install.sh` installs the prebuilt binary from the latest GitHub Release (or a specific version), verifying its SHA256 against `SHA256SUMS`.
4. There is no npm publish, no canary, no Docker image, no `releases/` directory, no `workflow_dispatch`, and no pnpm. The branch is `main`, not `master`. Do not use the old calver and canary wording in any release work.

## Step 1  Decide the version

Read the version to ship:

```bash
./scripts/release.sh --print-version
```

If the version is not the one to ship, bump it first:

1. Edit the `version` field in `package.json`.
2. Add a `CHANGELOG.md` entry headed `## [<version>] - <YYYY-MM-DD>` describing the changes. Use `release-changelog` to draft it from the commits and merged PRs since the last version tag.
3. Sync the plugin manifests to the new version:

```bash
python3 scripts/sync-plugin-version.py
python3 scripts/sync-plugin-version.py --check
```

Never reuse a version that already has a tag or a GitHub Release. `release.sh --live` refuses to create a tag that exists locally or on origin.

## Step 2  Run the check

```bash
./scripts/release.sh --check
```

It verifies:

- the working tree is clean, including untracked files
- `CHANGELOG.md` has an entry for the version
- the plugin manifests are in sync with `package.json`
- the local gates pass: `cargo fmt`, `cargo clippy --all-targets -- -D warnings`, and `cargo test --locked` for both crates, plus `scripts/smoke.sh`

If anything fails, fix it and rerun the check. Do not tag a failing tree.

## Step 3  Dry run

```bash
./scripts/release.sh --dry-run
```

This runs the check, then prints the release plan: the tag to create, the push command, and what the workflow will build. `stable` without `--live` does the same. Review the plan with the operator before anything is tagged. This step creates and pushes nothing.

## Step 4  Create the tag

```bash
./scripts/release.sh stable --live
```

This runs the check again, then creates the local annotated tag `v<version>`. It creates nothing else and pushes nothing. If the tag already exists locally or on origin, it refuses; bump the version instead of overwriting a tag.

## Step 5  Push the tag and watch the workflow

```bash
git push origin v<version>
```

This is the step that triggers the release workflow, and it is the operator's explicit step: the script never pushes. Then watch the run until the build job finishes for all 5 targets and the release job creates the GitHub Release:

```bash
gh run list --branch main --limit 4
```

If the workflow fails, fix the cause on `main` and ship a new patch version. Never move a tag to a different commit, and never reuse a version.

## Step 6  Verify the published release

1. Confirm the GitHub Release exists for the tag, with all 5 archives plus `SHA256SUMS`.
2. Install from it in a scratch prefix and check the version:

```bash
FORGE_VERSION=<version> ./install.sh --prefix /tmp/forge-<version>-check
/tmp/forge-<version>-check/forge --version
```

3. Smoke-test the published binaries end to end:

```bash
./scripts/docker-onboard-smoke.sh --from-release <version>
```

This downloads the published release and checks the install, the reported version, `forge smoke`, and a scaffold. It only works once a published release with assets exists: the first binary release is what proves this path. If no release assets exist yet, say so instead of claiming the check ran.
4. Confirm the default path: a plain `./install.sh` installs the version marked latest.

## Step 7  Manual paths (only when the workflow did not create the release)

If the workflow ran but no GitHub Release exists, create it manually:

```bash
./scripts/create-github-release.sh <version> [--dry-run]
```

Notes come from the `CHANGELOG.md` entry for the version, or from merged PRs if the entry is missing. The script refuses when a release already exists for the tag, or when the tag does not exist yet.

If a bad release is marked latest, roll the latest marker back:

```bash
./scripts/rollback-latest.sh <last-good-version> [--dry-run]
```

It only moves the latest marker. It does not delete the bad release and does not move any tag. Fix forward with a new release afterwards.

## Failure handling

- Check fails: fix the cause, rerun the check, do not tag.
- Tag exists: bump the version, do not overwrite the tag.
- Workflow fails: fix on `main`, ship a new patch version. Never move a tag.
- Release exists but an archive is missing: do not republish the same version. Fix the build and ship a new patch version.
- Bad release already published: roll back the latest marker with `rollback-latest.sh`, then fix forward with a new release.

## Output

When the skill completes, provide:

- version shipped
- tag pushed
- workflow run result
- GitHub Release URL and its assets (5 archives plus `SHA256SUMS`)
- install check result
- `docker-onboard-smoke.sh --from-release` result, or that it could not run because no published assets exist yet
- follow-up status if anything is still open

## The Forge Mark

This skill carries the Forge value in its substance: no AI slop, flow ideas to give back, everything evidence-based, output as changes. Ship means a version tag pushed, a workflow run green, and a GitHub Release with the prebuilt binaries installed and verified, not a version number announced in chat. A release whose check failed or whose binaries were never verified does not ship. Report by work: version decided and changelog entry written, check passed, tag created and pushed, workflow green, release verified from install. Use the related skills (`verification-before-completion` before any publish claim is made, `release-changelog` when the CHANGELOG.md entry must be drafted from commits and PRs, `finishing-a-development-branch` when the release work itself closes a branch). Update release-manager memory with the version, the tag, the workflow result, and the install verification so the next release starts from what is proven.