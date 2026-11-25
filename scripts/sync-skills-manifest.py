#!/usr/bin/env python3
"""Sync skills.json with the skills/ directory.

Usage:
  python3 scripts/sync-skills-manifest.py          # rewrite skills.json
  python3 scripts/sync-skills-manifest.py --check  # exit 1 on drift, change nothing

The manifest maps each skill directory (one with a SKILL.md) to its path.
The check compares the generated manifest against the committed skills.json
byte for byte, so a stale manifest fails CI instead of shipping silently.
"""

import json
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent


def build_manifest() -> dict:
    skills_dir = REPO_ROOT / "skills"
    manifest = {}
    if skills_dir.exists():
        for item in sorted(skills_dir.iterdir()):
            if item.is_dir() and (item / "SKILL.md").exists():
                manifest[item.name] = f"skills/{item.name}/SKILL.md"
    return manifest


def render(manifest: dict) -> str:
    return json.dumps(manifest, indent=2) + "\n"


def main() -> None:
    check = "--check" in sys.argv[1:]
    manifest_path = REPO_ROOT / "skills.json"
    rendered = render(build_manifest())

    if check:
        current = manifest_path.read_text(encoding="utf-8") if manifest_path.exists() else ""
        if current == rendered:
            print("skills.json: already in sync")
            return
        wanted = json.loads(rendered)
        got = json.loads(current) if current.strip() else {}
        missing = sorted(set(wanted) - set(got))
        extra = sorted(set(got) - set(wanted))
        changed = sorted(k for k in set(wanted) & set(got) if wanted[k] != got[k])
        print("skills.json: out of sync with skills/")
        if missing:
            print(f"  missing: {', '.join(missing)}")
        if extra:
            print(f"  extra: {', '.join(extra)}")
        if changed:
            print(f"  changed: {', '.join(changed)}")
        print("Run `python3 scripts/sync-skills-manifest.py`.")
        sys.exit(1)

    with open(manifest_path, "w", encoding="utf-8") as f:
        f.write(rendered)

    print(f"Manifest successfully synced to {manifest_path}")


if __name__ == "__main__":
    main()
