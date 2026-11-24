#!/usr/bin/env bash
# Check the Antigravity Marketplace logo: a square RGBA PNG at least 128x128
# (the Marketplace minimum), at the path the manifest names. The logo is
# derived from the logo mark (docs/assets/logo.webp, converted to RGBA PNG);
# there is no SVG render script, so no freshness check against a re-render.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
LOGO="$REPO_ROOT/assets/antigravity-logo.png"

fail() { echo "FAIL: $*" >&2; exit 1; }

echo "test-logo: checking Antigravity logo"

[ -f "$LOGO" ] || fail "logo missing at $LOGO"

python3 - "$LOGO" <<'PY'
import struct
import sys

data = open(sys.argv[1], "rb").read()
if data[:8] != b"\x89PNG\r\n\x1a\n":
    raise SystemExit("FAIL: logo is not a PNG")
width, height, bit_depth, color_type = struct.unpack(">IIBB", data[16:26])
if width != height:
    raise SystemExit(f"FAIL: logo is not square ({width}x{height})")
if width < 128:
    raise SystemExit(f"FAIL: logo is smaller than 128x128 ({width}x{height})")
if color_type != 6:
    raise SystemExit(f"FAIL: logo is not RGBA (PNG color type {color_type})")
PY

echo "PASS: Antigravity logo valid"
