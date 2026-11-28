#!/usr/bin/env bash
# docker-onboard-smoke.sh - smoke-test the Forge Anything distribution the
# way a new user consumes it.
#
# The release skill describes this as a Docker onboarding smoke test
# (install succeeds, onboarding completes, server boots, UI loads, company
# creation works). This repo has no server, UI, or onboarding flow: Forge
# Anything is distributed as skills plus a prebuilt `forge` CLI plus an MCP
# server. The equivalent end-to-end user journey, and what this script
# checks, is:
#   1. install succeeds (install.sh, from a release archive)
#   2. forge --version reports the version under test
#   3. forge smoke passes (the 8 system integrity checks)
#   4. forge scaffold creates a project with the expected structure
#      (32 skills, 17 agents, 31 commands)
#
# Usage:
#   docker-onboard-smoke.sh [--version <ver>] [--from-release <ver>]
#                            [--docker | --host] [--help]
#
# Environment (accepted for compatibility with the skill's invocations):
#   FORGE_VERSION / FORGEAI_VERSION
#     Version to smoke-test. Default: the version in package.json, built
#     from source locally. There is no canary release in this repo, so
#     FORGEAI_VERSION=canary is treated as "the local build".
#   HOST_PORT / DATA_DIR
#     Accepted but unused: this repo has no server to bind a port to and
#     no data directory to use.
#
# Mode:
#   --docker  Run the flow inside a clean container (needs docker). This is
#             the default when docker is available.
#   --host    Run on the host in a temp dir (no docker needed). This is the
#             default when docker is not available.
#   --from-release <ver>
#             Instead of building locally, download that version's published
#             GitHub Release and smoke-test it. The version must have a
#             published release.
#
# The temp working directory is removed on exit. Nothing is installed into
# the user's real ~/.local/bin.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

if ! command -v cargo >/dev/null 2>&1 && [[ -x "$HOME/.cargo/bin/cargo" ]]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

usage() {
    cat <<'EOF'
Usage: docker-onboard-smoke.sh [--version <ver>] [--from-release <ver>] [--docker | --host] [--help]

Smoke-test the Forge Anything distribution end to end.

  --version <ver>      Version to test (default: package.json version,
                       built from source locally).
  --from-release <ver> Download that version's published GitHub Release
                       instead of building locally.
  --docker             Run inside a clean container (needs docker).
  --host               Run on the host in a temp dir (no docker needed).
  --help               Show this help and exit.

Checks: install succeeds, forge --version matches, forge smoke passes,
forge scaffold creates a project with 32 skills, 17 agents, 31 commands.
HOST_PORT and DATA_DIR are accepted for compatibility but unused (this
repo has no server). FORGEAI_VERSION=canary is treated as the local build.
EOF
}

say() { printf '%s\n' "onboard-smoke: $*"; }
die() { printf '%s\n' "onboard-smoke: error: $*" >&2; exit 1; }

# --- arguments ---------------------------------------------------------------
MODE="auto"
FROM_RELEASE=""
REQ_VERSION=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        --docker) MODE="docker"; shift ;;
        --host) MODE="host"; shift ;;
        --version)
            [[ $# -ge 2 ]] || die "--version needs a value"
            REQ_VERSION="$2"; shift 2 ;;
        --version=*) REQ_VERSION="${1#--version=}"; shift ;;
        --from-release)
            [[ $# -ge 2 ]] || die "--from-release needs a value"
            FROM_RELEASE="$2"; shift 2 ;;
        --from-release=*) FROM_RELEASE="${1#--from-release=}"; shift ;;
        -h|--help) usage; exit 0 ;;
        *)
            die "unknown argument: $1" ;;
    esac
done

PKG_VERSION="$(python3 -c "import json; print(json.load(open('package.json'))['version'])")"
VERSION="${REQ_VERSION:-${FORGE_VERSION:-${FORGEAI_VERSION:-$PKG_VERSION}}}"
VERSION="${VERSION#v}"
if [[ "$VERSION" == "canary" || "$VERSION" == "latest" ]]; then
    say "note: $VERSION has no canary/latest build in this repo; smoke-testing the local build (package.json $PKG_VERSION) instead."
    VERSION="$PKG_VERSION"
fi
if [[ -n "$FROM_RELEASE" ]]; then
    FROM_RELEASE="${FROM_RELEASE#v}"
    VERSION="$FROM_RELEASE"
elif [[ "$VERSION" != "$PKG_VERSION" ]]; then
    die "version $VERSION does not match this checkout (package.json $PKG_VERSION). Build from source only tests the checkout version; use --from-release $VERSION to test a published release instead."
fi

if [[ -n "${HOST_PORT:-}" || -n "${DATA_DIR:-}" ]]; then
    say "note: HOST_PORT/DATA_DIR are set but unused; this repo has no server to bind or data dir to use."
fi

if [[ "$MODE" == "auto" ]]; then
    if command -v docker >/dev/null 2>&1; then MODE="docker"; else MODE="host"; fi
fi
if [[ "$MODE" == "docker" ]] && ! command -v docker >/dev/null 2>&1; then
    die "docker is not available; re-run with --host"
fi
say "Mode: $MODE; version under test: $VERSION"

# --- detect the release target (same mapping as install.sh) ------------------
OS="$(uname -s)"
ARCH="$(uname -m)"
case "$OS" in
    Linux) OS_ID="linux" ;;
    Darwin) OS_ID="darwin" ;;
    *) die "unsupported OS: $OS" ;;
esac
case "$ARCH" in
    x86_64|amd64) ARCH_ID="x86_64" ;;
    aarch64|arm64) ARCH_ID="aarch64" ;;
    *) die "unsupported architecture: $ARCH" ;;
esac
TARGET="$ARCH_ID-unknown-linux-gnu"
[[ "$OS_ID" == "darwin" ]] && TARGET="$ARCH_ID-apple-darwin"
ARCHIVE="forge-$TARGET.tar.gz"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT INT TERM

# --- the checks, as a script the host or the container runs ------------------
# $1 = install prefix, $2 = source checkout dir, $3 = project dir.
# Expects the forge binary already installed at $1/forge.
write_check_script() {
    cat > "$TMP/check.sh" <<EOF
set -euo pipefail
BIN="\$1/forge"
SRC="\$2"
PROJ="\$3"
say() { printf '%s\n' "onboard-smoke: \$*"; }
say "[1/4] install check: binary exists and is executable"
test -x "\$BIN" || { echo "binary missing: \$BIN" >&2; exit 1; }
say "[2/4] forge --version"
OUT="\$("\$BIN" --version)"
echo "  \$OUT"
echo "\$OUT" | grep -q "Forge Anything v$VERSION" || { echo "version mismatch: expected Forge Anything v$VERSION" >&2; exit 1; }
say "[3/4] forge smoke (FORGE_SOURCE=\$SRC)"
FORGE_SOURCE="\$SRC" "\$BIN" smoke | tail -3
FORGE_SOURCE="\$SRC" "\$BIN" smoke | grep -q "SMOKE TEST PASSED"
say "[4/4] forge scaffold"
"\$BIN" scaffold --source "\$SRC" --name smoke-test "\$PROJ" | tail -2
test "\$(ls "\$PROJ/skills" | wc -l)" -eq 32
test "\$(ls "\$PROJ/agents" | wc -l)" -eq 17
test "\$(ls "\$PROJ/commands" | wc -l)" -eq 31
test -f "\$PROJ/README.md"
test -f "\$PROJ/skills/using-forge-anything/SKILL.md"
test -f "\$PROJ/agents/forge-ceo/SOUL.md"
say "scaffold OK: 32 skills, 17 agents, 31 commands"
EOF
    chmod +x "$TMP/check.sh"
}

if [[ -n "$FROM_RELEASE" ]]; then
    # --- published-release path: install.sh downloads from GitHub ----------
    say "Testing published release v$VERSION (no local build)."
    if [[ "$MODE" == "docker" ]]; then
        cp "$REPO_ROOT/install.sh" "$TMP/install.sh"
        write_check_script
        docker run --rm \
            -v "$TMP:/test:ro" \
            -v "$REPO_ROOT:/repo:ro" \
            ubuntu:24.04 bash -c '
                set -euo pipefail
                apt-get update -qq && apt-get install -y -qq curl ca-certificates tar >/dev/null
                FORGE_INSTALL_DIR=/tmp/forge-bin bash /test/install.sh --version "'"$VERSION"'"
                bash /test/check.sh /tmp/forge-bin /repo /tmp/forge-project
            '
    else
        "$REPO_ROOT/install.sh" --version "$VERSION" --prefix "$TMP/bin"
        write_check_script
        bash "$TMP/check.sh" "$TMP/bin" "$REPO_ROOT" "$TMP/project"
    fi
else
    # --- local-build path: package the binary like release.yml does --------
    say "Building forge from source (cargo build --release --locked)..."
    (cd crates/forge && cargo build --release --locked)
    mkdir -p "$TMP/archive"
    STAGE="$(mktemp -d)"
    cp "crates/forge/target/release/forge" "$STAGE/forge"
    tar -czf "$TMP/archive/$ARCHIVE" -C "$STAGE" forge
    (cd "$TMP/archive" && sha256sum "$ARCHIVE" > SHA256SUMS)
    rm -rf "$STAGE"
    cp "$REPO_ROOT/install.sh" "$TMP/install.sh"
    write_check_script

    if [[ "$MODE" == "docker" ]]; then
        docker run --rm \
            -v "$TMP:/test:ro" \
            -v "$REPO_ROOT:/repo:ro" \
            ubuntu:24.04 bash -c '
                set -euo pipefail
                apt-get update -qq && apt-get install -y -qq curl ca-certificates tar >/dev/null
                FORGE_RELEASE_BASE_URL=file:///test/archive FORGE_INSTALL_DIR=/tmp/forge-bin bash /test/install.sh --version "'"$VERSION"'"
                bash /test/check.sh /tmp/forge-bin /repo /tmp/forge-project
            '
    else
        FORGE_RELEASE_BASE_URL="file://$TMP/archive" \
            FORGE_INSTALL_DIR="$TMP/bin" \
            bash "$TMP/install.sh" --version "$VERSION"
        bash "$TMP/check.sh" "$TMP/bin" "$REPO_ROOT" "$TMP/project"
    fi
fi

echo ""
echo "ONBOARD SMOKE PASSED: install + version + smoke + scaffold all green for v$VERSION ($MODE)."
