#!/usr/bin/env bash
# rollback-latest.sh - roll the "latest" release back to a good version.
#
# install.sh installs from the GitHub Release marked "latest"
# (https://github.com/galyarderlabs/forge-anything/releases/latest/download),
# so when a release is bad, the rollback is to mark the last good release
# as latest again. This script does exactly that and nothing else: it does
# not delete the bad release, does not move tags, and does not republish
# anything. Fix forward with a new release afterwards.
#
# Usage:
#   rollback-latest.sh <last-good-version> [--dry-run]
#   rollback-latest.sh --help
#
# <last-good-version> is semver with or without a leading "v" (e.g. 3.0.0).
# The target must already have a GitHub Release; a prerelease cannot be
# made latest.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

usage() {
    cat <<'EOF'
Usage: rollback-latest.sh <last-good-version> [--dry-run] [--help]

Roll the "latest" GitHub Release back to a good version.

  <last-good-version>   Semver with or without a leading "v", e.g. 3.0.0.
  --dry-run             Print what would change, without changing anything.
  --help                Show this help and exit.

install.sh downloads from the release marked "latest", so marking the last
good release as latest makes new installs get the good version again. The
bad release is left in place (not deleted); fix forward with a new release.
EOF
}

DRY_RUN=0
VERSION=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run) DRY_RUN=1; shift ;;
        -h|--help) usage; exit 0 ;;
        -*) echo "rollback-latest.sh: unknown argument: $1" >&2; usage >&2; exit 1 ;;
        *)
            if [[ -n "$VERSION" ]]; then
                echo "rollback-latest.sh: unexpected extra argument: $1" >&2
                usage >&2; exit 1
            fi
            VERSION="$1"; shift ;;
    esac
done

[[ -n "$VERSION" ]] || { echo "rollback-latest.sh: a <last-good-version> is required" >&2; usage >&2; exit 1; }
VERSION="${VERSION#v}"
TAG="v$VERSION"

command -v gh >/dev/null 2>&1 || { echo "rollback-latest.sh: gh is required (https://cli.github.com)" >&2; exit 1; }

# The target must already be a published release; there is nothing to
# promote otherwise.
if ! gh release view "$TAG" --json tagName,isPrerelease,isDraft -q .tagName >/dev/null 2>&1; then
    echo "rollback-latest.sh: no GitHub Release exists for $TAG; cannot roll back to it." >&2
    echo "List releases with: gh release list" >&2
    exit 1
fi
if [[ "$(gh release view "$TAG" --json isPrerelease -q .isPrerelease)" == "true" ]]; then
    echo "rollback-latest.sh: $TAG is a prerelease; a prerelease cannot be latest." >&2
    exit 1
fi
if [[ "$(gh release view "$TAG" --json isDraft -q .isDraft)" == "true" ]]; then
    echo "rollback-latest.sh: $TAG is a draft release; a draft cannot be latest." >&2
    exit 1
fi

CURRENT="$(gh release view --json tagName -q .tagName 2>/dev/null || echo "")"
echo "Current latest release: ${CURRENT:-unknown}"
echo "Rollback target:        $TAG"
if [[ "$CURRENT" == "$TAG" ]]; then
    echo "$TAG is already the latest release; nothing to do."
    exit 0
fi

if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "Dry run only. Nothing was changed."
    echo ""
    echo "Would run:"
    echo "  gh release edit \"$TAG\" --latest"
    echo "Then new installs (install.sh) would get $TAG again."
    exit 0
fi

gh release edit "$TAG" --latest
echo ""
echo "Latest release is now $TAG (was ${CURRENT:-unknown})."
echo "Verify with: gh release view --json tagName -q .tagName"
echo "Then fix forward with a new release; the bad release stays in place."
