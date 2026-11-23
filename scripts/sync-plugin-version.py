#!/usr/bin/env python3
"""Sync plugin manifest versions from package.json.

Copies package.json's version into every plugin manifest, so the version
is declared once (package.json) and every manifest follows it.

Manifests synced:
  - plugin.json (Agent Plugins 1.0, portable)
  - .claude-plugin/plugin.json
  - .codex-plugin/plugin.json
  - .antigravity-plugin/plugin.json
  - .claude-plugin/marketplace.json (metadata.version + plugins[0].version)
  - .hermes-plugin/plugin.yaml (version: line)

Usage:
  python3 scripts/sync-plugin-version.py          # rewrite drifted versions
  python3 scripts/sync-plugin-version.py --check  # exit 1 on drift, change nothing

The rewrite only replaces the version value, to keep key order and
formatting untouched (same approach as mattpocock's sync-plugin-version.mjs).
"""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent

JSON_MANIFESTS = [
    REPO_ROOT / "plugin.json",
    REPO_ROOT / ".claude-plugin" / "plugin.json",
    REPO_ROOT / ".codex-plugin" / "plugin.json",
    REPO_ROOT / ".antigravity-plugin" / "plugin.json",
    REPO_ROOT / ".claude-plugin" / "marketplace.json",
]

YAML_MANIFESTS = [
    REPO_ROOT / ".hermes-plugin" / "plugin.yaml",
]

VERSION_RE = re.compile(r'("version"\s*:\s*")[^"]*(")')
YAML_VERSION_RE = re.compile(r"^(version:\s*).*$", re.MULTILINE)


def read_package_version() -> str:
    return json.loads((REPO_ROOT / "package.json").read_text())["version"]


def json_versions(path: Path) -> list[str]:
    data = json.loads(path.read_text())
    if path.name == "marketplace.json":
        versions = [data["metadata"]["version"]]
        versions += [p["version"] for p in data.get("plugins", [])]
        return versions
    return [data["version"]]


def yaml_version(path: Path) -> str:
    match = YAML_VERSION_RE.search(path.read_text())
    if not match:
        raise SystemExit(f"Could not find a version field in {path}")
    return match.group(0).split(":", 1)[1].strip()


def sync_json(path: Path, version: str, check: bool) -> bool:
    """Return True if the file was (or would be) changed."""
    current = json_versions(path)
    if all(v == version for v in current):
        print(f"{path.relative_to(REPO_ROOT)}: {version} (already in sync)")
        return False
    if check:
        print(
            f"{path.relative_to(REPO_ROOT)}: {', '.join(current)} "
            f"!= package.json {version}. Run `python3 scripts/sync-plugin-version.py`."
        )
        return True
    updated = VERSION_RE.sub(lambda m: f"{m.group(1)}{version}{m.group(2)}", path.read_text())
    path.write_text(updated)
    # Verify the rewrite actually landed.
    if not all(v == version for v in json_versions(path)):
        raise SystemExit(f"Could not replace the version field in {path}")
    print(f"{path.relative_to(REPO_ROOT)}: {', '.join(current)} -> {version}")
    return True


def sync_yaml(path: Path, version: str, check: bool) -> bool:
    """Return True if the file was (or would be) changed."""
    current = yaml_version(path)
    if current == version:
        print(f"{path.relative_to(REPO_ROOT)}: {version} (already in sync)")
        return False
    if check:
        print(
            f"{path.relative_to(REPO_ROOT)}: {current} "
            f"!= package.json {version}. Run `python3 scripts/sync-plugin-version.py`."
        )
        return True
    updated = YAML_VERSION_RE.sub(f"version: {version}", path.read_text(), count=1)
    path.write_text(updated)
    if yaml_version(path) != version:
        raise SystemExit(f"Could not replace the version field in {path}")
    print(f"{path.relative_to(REPO_ROOT)}: {current} -> {version}")
    return True


def main(argv: list[str]) -> int:
    check = "--check" in argv
    version = read_package_version()
    drifted = False
    for path in JSON_MANIFESTS:
        if not path.exists():
            raise SystemExit(f"Missing manifest: {path}")
        drifted |= sync_json(path, version, check)
    for path in YAML_MANIFESTS:
        if not path.exists():
            raise SystemExit(f"Missing manifest: {path}")
        drifted |= sync_yaml(path, version, check)
    if check and drifted:
        return 1
    print(f"All plugin manifests at v{version}.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
