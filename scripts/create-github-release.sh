#!/usr/bin/env bash
# create-github-release.sh - create the GitHub Release for a version.
#
# This is the MANUAL path. Normally the release is created by
# .github/workflows/release.yml when a v<version> tag is pushed (it builds
# the 5 platform binaries, SHA256SUMS, and the release with generated
# notes). Use this script only when the workflow did not create the release
# (for example an emergency manual release) and one is still needed.
#
# Usage:
#   create-github-release.sh <version> [--dry-run]
#   create-github-release.sh --help
#
# <version> is semver with or without a leading "v" (e.g. 3.0.2 or v3.0.2).
# Release notes come from the CHANGELOG.md entry for that version; if the
# entry is missing, notes are generated from merged PRs instead.
#
# Safety: refuses to create a release when one already exists for the tag,
# and refuses when the tag does not exist yet (create it with
# scripts/release.sh --live, or push it so the workflow runs).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

usage() {
    cat <<'EOF'
Usage: create-github-release.sh <version> [--dry-run] [--help]

Create the GitHub Release for a version (manual path).

  <version>    Semver with or without a leading "v", e.g. 3.0.2 or v3.0.2.
  --dry-run    Print the gh command that would run, without creating
               anything.
  --help       Show this help and exit.

The release is normally created by .github/workflows/release.yml when the
tag is pushed; this script is only for the manual path. Notes come from
the CHANGELOG.md entry for the version (generated from merged PRs when
the entry is missing). Refuses when the tag does not exist or a release
already exists for it.
EOF
}

DRY_RUN=0
VERSION=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run) DRY_RUN=1; shift ;;
        -h|--help) usage; exit 0 ;;
        -*) echo "create-github-release.sh: unknown argument: $1" >&2; usage >&2; exit 1 ;;
        *)
            if [[ -n "$VERSION" ]]; then
                echo "create-github-release.sh: unexpected extra argument: $1" >&2
                usage >&2; exit 1
            fi
            VERSION="$1"; shift ;;
    esac
done

[[ -n "$VERSION" ]] || { echo "create-github-release.sh: a <version> is required" >&2; usage >&2; exit 1; }
VERSION="${VERSION#v}"
TAG="v$VERSION"

command -v gh >/dev/null 2>&1 || { echo "create-github-release.sh: gh is required (https://cli.github.com)" >&2; exit 1; }

# The tag must exist first: a release without a tag is not a release.
if ! git rev-parse -q --verify "refs/tags/$TAG" >/dev/null \
    && ! git ls-remote --tags origin "$TAG" | grep -q .; then
    echo "create-github-release.sh: tag $TAG does not exist locally or on origin." >&2
    echo "Create it with: ./scripts/release.sh --live   (then push it so the workflow runs)" >&2
    exit 1
fi

# Never create a duplicate release: the workflow usually already did this.
if gh release view "$TAG" >/dev/null 2>&1; then
    echo "create-github-release.sh: a GitHub Release already exists for $TAG; refusing to duplicate it." >&2
    echo "See it with: gh release view $TAG" >&2
    exit 1
fi

NOTES_FILE="$(mktemp)"
trap 'rm -f "$NOTES_FILE"' EXIT
USE_GENERATED_NOTES=0
if grep -q "## \[$VERSION\]" CHANGELOG.md; then
    # The heading line carries a date suffix ("## [3.0.2] - 2026-11-23"),
    # so match it as a prefix, not an exact line.
    awk -v ver="$VERSION" '
        $0 ~ "^## \\[" ver "\\]" { in_section = 1; next }
        in_section && /^## \[/ { exit }
        in_section { print }
    ' CHANGELOG.md > "$NOTES_FILE"
    # Trim leading blank lines left by the heading skip.
    sed -i '/./,$!d' "$NOTES_FILE"
    if [[ ! -s "$NOTES_FILE" ]]; then
        USE_GENERATED_NOTES=1
    fi
else
    USE_GENERATED_NOTES=1
fi

if [[ "$USE_GENERATED_NOTES" -eq 1 ]]; then
    echo "create-github-release.sh: no CHANGELOG.md entry for [$VERSION]; notes will be generated from merged PRs." >&2
fi

if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "Dry run only. Nothing was created."
    echo ""
    echo "Would run:"
    if [[ "$USE_GENERATED_NOTES" -eq 1 ]]; then
        echo "  gh release create \"$TAG\" --title \"Forge Anything $TAG\" --generate-notes"
    else
        echo "  gh release create \"$TAG\" --title \"Forge Anything $TAG\" --notes-file <CHANGELOG.md section for [$VERSION]>"
        echo ""
        echo "Notes preview (first 10 lines):"
        head -10 "$NOTES_FILE" | sed 's/^/    /'
    fi
    exit 0
fi

if [[ "$USE_GENERATED_NOTES" -eq 1 ]]; then
    gh release create "$TAG" --title "Forge Anything $TAG" --generate-notes
else
    gh release create "$TAG" --title "Forge Anything $TAG" --notes-file "$NOTES_FILE"
fi
echo "Created GitHub Release $TAG."
echo "See it with: gh release view $TAG"
