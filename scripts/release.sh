#!/usr/bin/env bash
# release.sh - drive a Forge Anything release (this repo's actual flow).
#
# This repo releases with semver; package.json is the version source.
# Pushing a v<version> tag triggers .github/workflows/release.yml, which
# builds the prebuilt `forge` binaries for 5 targets and creates the GitHub
# Release (notes generated from merged PRs). There is no npm publish, no
# canary, no Docker image, and no `releases/` directory; the changelog is
# the root CHANGELOG.md.
#
# Usage:
#   release.sh --print-version     Print the version from package.json
#   release.sh --check             Verify tree, changelog, and gates
#   release.sh --dry-run           Check + print the release plan (default)
#   release.sh stable [--live]     Same as --dry-run; --live also creates
#                                  the local tag v<version> (never pushes)
#   release.sh --help
#
# Compatibility notes: the release skill was copied from a different project
# and still describes its calver/canary/npm flow. For this repo:
#   - `stable` is accepted as a subcommand for the skill's invocations.
#   - `--date YYYY-MM-DD` is accepted but ignored: this repo versions with
#     semver, not calendar versions.
#   - `master` in the skill means `main` here.
#
# Safety: nothing is pushed and no tag is created unless --live is given.
# Even then the tag is created locally only; pushing it (which triggers the
# release workflow) is a separate, explicit step the operator runs.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

# cargo lives outside PATH on the maintainer VM; pick it up if needed.
if ! command -v cargo >/dev/null 2>&1 && [[ -x "$HOME/.cargo/bin/cargo" ]]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

usage() {
    cat <<'EOF'
Usage: release.sh [--print-version | --check | --dry-run | stable [--live]] [--date YYYY-MM-DD] [--help]

Drive a Forge Anything release.

  --print-version   Print the version from package.json and exit.
  --check           Verify the working tree is clean, CHANGELOG.md has an
                    entry for the version, manifests are in sync, and the
                    local gates pass (fmt, clippy, cargo test, smoke.sh).
  --dry-run         Run --check, then print the release plan without
                    creating a tag. This is the default when no action
                    is given.
  stable [--live]   Same as --dry-run. With --live, also create the local
                    tag v<version> (annotated). Nothing is ever pushed
                    by this script; pushing the tag triggers the release
                    workflow, and the operator runs that step explicitly.
  --date YYYY-MM-DD Accepted for compatibility with the release skill;
                    ignored, because this repo versions with semver.
  --help            Show this help and exit.
EOF
}

version() {
    python3 -c "import json; print(json.load(open('package.json'))['version'])"
}

failures=0
step() {
    local name="$1"; shift
    if "$@" >/tmp/forge-release-step.log 2>&1; then
        echo "  [PASS] $name"
    else
        echo "  [FAIL] $name"
        sed 's/^/    /' /tmp/forge-release-step.log | tail -5
        failures=$((failures + 1))
    fi
}

cmd_check() {
    local ver="$1"
    failures=0
    echo "Release check for v$ver:"
    echo ""

    echo "Preconditions..."
    if [[ -z "$(git status --porcelain)" ]]; then
        echo "  [PASS] working tree is clean (including untracked files)"
    else
        echo "  [FAIL] working tree is not clean:"
        git status --porcelain | sed 's/^/    /'
        failures=$((failures + 1))
    fi
    if grep -q "## \[$ver\]" CHANGELOG.md; then
        echo "  [PASS] CHANGELOG.md has an entry for [$ver]"
    else
        echo "  [FAIL] CHANGELOG.md has no entry for [$ver]"
        failures=$((failures + 1))
    fi

    echo ""
    echo "Manifest sync..."
    step "plugin manifests in sync (sync-plugin-version.py --check)" \
        python3 scripts/sync-plugin-version.py --check

    echo ""
    echo "Local gates (same as CI rust.yml + smoke.sh)..."
    for crate in forge-scaffold forge; do
        step "$crate: cargo fmt --check" \
            bash -c "cd crates/$crate && cargo fmt --check"
        step "$crate: cargo clippy --all-targets -- -D warnings" \
            bash -c "cd crates/$crate && cargo clippy --all-targets -- -D warnings"
        step "$crate: cargo test --locked" \
            bash -c "cd crates/$crate && cargo test --locked"
    done
    step "smoke.sh (8 checks)" bash scripts/smoke.sh

    echo ""
    if [[ "$failures" -ne 0 ]]; then
        echo "CHECK FAILED: $failures check(s) failed. Fix them before releasing."
        return 1
    fi
    echo "CHECK PASSED: tree, changelog, manifests, and gates are green."
}

cmd_plan() {
    local ver="$1"
    echo ""
    echo "Release plan for v$ver:"
    echo "  1. Tag:   git tag -a v$ver -m \"Forge Anything $ver\"  (local only)"
    echo "  2. Push:  git push origin v$ver"
    echo "     Pushing the tag triggers .github/workflows/release.yml, which"
    echo "     builds the forge binary for 5 targets and creates the GitHub"
    echo "     Release with SHA256SUMS (notes generated from merged PRs)."
    echo "  3. Verify: curl the install script and check the new version:"
    echo "     FORGE_VERSION=$ver ./install.sh --prefix /tmp/forge-$ver-check"
    echo "     /tmp/forge-$ver-check/forge --version"
    echo "  The GitHub Release is created by the workflow; use"
    echo "  scripts/create-github-release.sh only for the manual path."
}

ACTION="dry-run"
DATE=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        stable) ACTION="dry-run"; shift ;;
        --print-version) ACTION="print-version"; shift ;;
        --check) ACTION="check"; shift ;;
        --dry-run) ACTION="dry-run"; shift ;;
        --live) ACTION="live"; shift ;;
        --date)
            [[ $# -ge 2 ]] || { echo "release.sh: --date needs a value" >&2; exit 1; }
            DATE="$2"; shift 2 ;;
        --date=*) DATE="${1#--date=}"; shift ;;
        -h|--help) usage; exit 0 ;;
        *)
            echo "release.sh: unknown argument: $1" >&2
            usage >&2
            exit 1 ;;
    esac
done

if [[ -n "$DATE" ]]; then
    echo "release.sh: note: --date $DATE is accepted for compatibility; this repo versions with semver (package.json), so the date does not change the version." >&2
fi

VER="$(version)"
TAG="v$VER"

case "$ACTION" in
    print-version)
        echo "$VER"
        ;;
    check)
        cmd_check "$VER"
        ;;
    dry-run)
        cmd_check "$VER"
        cmd_plan "$VER"
        ;;
    live)
        cmd_check "$VER"
        if git rev-parse -q --verify "refs/tags/$TAG" >/dev/null; then
            echo "release.sh: tag $TAG already exists locally; refusing to overwrite it." >&2
            exit 1
        fi
        if git ls-remote --tags origin "$TAG" | grep -q .; then
            echo "release.sh: tag $TAG already exists on origin; refusing to overwrite it." >&2
            exit 1
        fi
        git tag -a "$TAG" -m "Forge Anything $VER"
        echo ""
        echo "Created local tag $TAG."
        echo "It is NOT pushed. To trigger the release workflow, run:"
        echo "  git push origin $TAG"
        cmd_plan "$VER"
        ;;
esac
