#!/bin/sh
# Forge Anything — install the prebuilt `forge` CLI binary.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/galyarderlabs/forge-anything/main/install.sh | sh
#
# Installs the matching prebuilt binary from the latest GitHub Release
# (or a specific version) into ~/.local/bin, verifying its SHA256
# checksum against the release's SHA256SUMS first.
#
# Options:
#   --help              Show this help and exit.
#   --version <ver>     Install a specific version, e.g. 3.0.2 (default: latest).
#   --prefix <dir>      Install directory (default: ~/.local/bin).
#
# Environment variables (same effect as the flags):
#   FORGE_VERSION       Version to install, e.g. 3.0.2 (default: latest).
#   FORGE_INSTALL_DIR   Install directory (default: ~/.local/bin).
#   FORGE_RELEASE_BASE_URL
#                       Override the download base URL (used for testing).
#                       Default: https://github.com/galyarderlabs/forge-anything/releases/latest/download
#                       or .../releases/download/v<version> for a pinned version.
#
# Requires: curl, tar (or unzip on Windows), sha256sum or shasum.
# No Rust toolchain is needed. To build from source instead, see
# docs/QUICK_START.md.

set -eu

REPO="galyarderlabs/forge-anything"
VERSION="${FORGE_VERSION:-latest}"
PREFIX="${FORGE_INSTALL_DIR:-$HOME/.local/bin}"

usage() {
    cat <<EOF
Usage: install.sh [--version <ver>] [--prefix <dir>] [--help]

Install the prebuilt Forge Anything CLI (\`forge\`) from GitHub Releases.

  --version <ver>   Version to install, e.g. 3.0.2 (default: latest release).
  --prefix <dir>    Install directory (default: ~/.local/bin).
  --help            Show this help and exit.

Environment variables FORGE_VERSION and FORGE_INSTALL_DIR do the same.
Example:
  curl -fsSL https://raw.githubusercontent.com/galyarderlabs/forge-anything/main/install.sh | sh
  curl -fsSL https://raw.githubusercontent.com/galyarderlabs/forge-anything/main/install.sh | sh -s -- --version 3.0.2
EOF
}

while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help)
            usage
            exit 0
            ;;
        --version)
            [ $# -ge 2 ] || { echo "install.sh: --version needs a value" >&2; exit 1; }
            VERSION="$2"
            shift 2
            ;;
        --version=*)
            VERSION="${1#--version=}"
            shift
            ;;
        --prefix)
            [ $# -ge 2 ] || { echo "install.sh: --prefix needs a value" >&2; exit 1; }
            PREFIX="$2"
            shift 2
            ;;
        --prefix=*)
            PREFIX="${1#--prefix=}"
            shift
            ;;
        *)
            echo "install.sh: unknown argument: $1" >&2
            usage >&2
            exit 1
            ;;
    esac
done

# Strip a leading "v" so both "3.0.2" and "v3.0.2" work.
VERSION="${VERSION#v}"

say() { printf '%s\n' "forge-install: $*"; }
die() { printf '%s\n' "forge-install: error: $*" >&2; exit 1; }

command -v curl >/dev/null 2>&1 || die "curl is required (https://curl.se)"

# --- Detect OS + arch -------------------------------------------------------
OS="$(uname -s)"
ARCH="$(uname -m)"
case "$OS" in
    Linux)  OS_ID="linux" ;;
    Darwin) OS_ID="darwin" ;;
    MINGW*|MSYS*|CYGWIN*) OS_ID="windows" ;;
    *) die "unsupported OS: $OS" ;;
esac
case "$ARCH" in
    x86_64|amd64) ARCH_ID="x86_64" ;;
    aarch64|arm64) ARCH_ID="aarch64" ;;
    *) die "unsupported architecture: $ARCH" ;;
esac

if [ "$OS_ID" = "windows" ]; then
    TARGET="x86_64-pc-windows-msvc"
    ARCHIVE="forge-$TARGET.zip"
    BINARY="forge.exe"
    command -v unzip >/dev/null 2>&1 || die "unzip is required to install forge on Windows"
elif [ "$OS_ID" = "linux" ]; then
    TARGET="$ARCH_ID-unknown-linux-gnu"
    ARCHIVE="forge-$TARGET.tar.gz"
    BINARY="forge"
    command -v tar >/dev/null 2>&1 || die "tar is required to install forge"
else
    TARGET="$ARCH_ID-apple-darwin"
    ARCHIVE="forge-$TARGET.tar.gz"
    BINARY="forge"
    command -v tar >/dev/null 2>&1 || die "tar is required to install forge"
fi

# --- Resolve the download base URL ------------------------------------------
if [ -n "${FORGE_RELEASE_BASE_URL:-}" ]; then
    BASE_URL="$FORGE_RELEASE_BASE_URL"
elif [ "$VERSION" = "latest" ]; then
    BASE_URL="https://github.com/$REPO/releases/latest/download"
else
    BASE_URL="https://github.com/$REPO/releases/download/v$VERSION"
fi

say "Installing forge ($VERSION) for $TARGET into $PREFIX"

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT INT TERM

# --- Download archive + checksums -------------------------------------------
say "Downloading $BASE_URL/$ARCHIVE"
curl -fsSL -o "$TMPDIR/$ARCHIVE" "$BASE_URL/$ARCHIVE" \
    || die "download failed: $BASE_URL/$ARCHIVE (check the version exists at https://github.com/$REPO/releases)"
curl -fsSL -o "$TMPDIR/SHA256SUMS" "$BASE_URL/SHA256SUMS" \
    || die "download failed: $BASE_URL/SHA256SUMS"

# --- Verify the checksum -----------------------------------------------------
sha256_of() {
    if command -v sha256sum >/dev/null 2>&1; then
        sha256sum "$1" | cut -d' ' -f1
    elif command -v shasum >/dev/null 2>&1; then
        shasum -a 256 "$1" | cut -d' ' -f1
    else
        die "sha256sum or shasum is required to verify the download"
    fi
}

EXPECTED="$(grep " $ARCHIVE\$" "$TMPDIR/SHA256SUMS" | cut -d' ' -f1 || true)"
[ -n "$EXPECTED" ] || die "no checksum for $ARCHIVE in SHA256SUMS"
ACTUAL="$(sha256_of "$TMPDIR/$ARCHIVE")"
[ "$EXPECTED" = "$ACTUAL" ] || die "checksum mismatch for $ARCHIVE (download may be corrupt or tampered with)"
say "Checksum verified (sha256)"

# --- Extract and install ------------------------------------------------------
if [ "$OS_ID" = "windows" ]; then
    (cd "$TMPDIR" && unzip -o -q "$ARCHIVE")
else
    tar -xzf "$TMPDIR/$ARCHIVE" -C "$TMPDIR"
fi
[ -f "$TMPDIR/$BINARY" ] || die "archive did not contain $BINARY"

mkdir -p "$PREFIX"
if [ -w "$PREFIX" ]; then
    cp "$TMPDIR/$BINARY" "$PREFIX/$BINARY"
else
    if command -v sudo >/dev/null 2>&1; then
        say "$PREFIX is not writable; retrying with sudo"
        sudo cp "$TMPDIR/$BINARY" "$PREFIX/$BINARY"
    else
        die "$PREFIX is not writable; re-run with sudo or pass --prefix <writable-dir>"
    fi
fi
chmod +x "$PREFIX/$BINARY"

INSTALLED_VERSION="$("$PREFIX/$BINARY" --version 2>/dev/null || echo "unknown")"
say "Installed $INSTALLED_VERSION to $PREFIX/$BINARY"

case ":$PATH:" in
    *":$PREFIX:"*) ;;
    *)
        say "Note: $PREFIX is not in your PATH. Add it to your shell profile:"
        say "  export PATH=\"\$PATH:$PREFIX\""
        ;;
esac

cat <<EOF

Next steps:
  forge --help        Show the available commands
  forge scaffold      Initialize a new Forge Anything project
  forge --version     Show the installed version

Skills for your AI harness are installed separately (npm is skills-only):
  npx skills add galyarderlabs/forge-anything --skill full
EOF
