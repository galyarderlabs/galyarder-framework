#!/usr/bin/env python3
from __future__ import annotations

import argparse
import os
import shutil
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent.parent
BUNDLE_ROOT = REPO_ROOT / "Bundle"

PERSONA_DIRS = [
    REPO_ROOT / "Executive" / "personas",
]

AGENT_DIRS = [
    REPO_ROOT / "Executive" / "agents",
    REPO_ROOT / "Engineering" / "agents",
    REPO_ROOT / "Growth" / "agents",
    REPO_ROOT / "Security" / "agents",
    REPO_ROOT / "Product" / "agents",
    REPO_ROOT / "Infrastructure" / "agents",
    REPO_ROOT / "Legal-Finance" / "agents",
    REPO_ROOT / "Knowledge" / "agents",
]

SKILL_DIRS = [
    REPO_ROOT / "Executive" / "skills",
    REPO_ROOT / "Engineering" / "skills",
    REPO_ROOT / "Growth" / "skills",
    REPO_ROOT / "Growth" / "design",
    REPO_ROOT / "Security" / "skills",
    REPO_ROOT / "Product" / "skills",
    REPO_ROOT / "Infrastructure" / "skills",
    REPO_ROOT / "Legal-Finance" / "skills",
    REPO_ROOT / "Knowledge" / "skills",
]

COMMAND_DIRS = [
    REPO_ROOT / "Engineering" / "commands",
    REPO_ROOT / "Growth" / "commands",
    REPO_ROOT / "Security" / "commands",
    REPO_ROOT / "Product" / "commands",
    REPO_ROOT / "Infrastructure" / "commands",
    REPO_ROOT / "Legal-Finance" / "commands",
    REPO_ROOT / "Knowledge" / "commands",
]

DESIGN_DIRS = [
    REPO_ROOT / "Growth" / "design",
]


def reset_path(path: Path) -> None:
    if path.is_symlink() or path.is_file():
        path.unlink()
    elif path.is_dir():
        shutil.rmtree(path)


def link_markdown_files(source_dirs: list[Path], target_dir: Path) -> None:
    target_dir.mkdir(parents=True, exist_ok=True)
    for source_dir in source_dirs:
        if not source_dir.exists():
            continue
        for src in sorted(source_dir.glob("*.md")):
            dest = target_dir / src.name
            if dest.exists() or dest.is_symlink():
                reset_path(dest)
            dest.symlink_to(os.path.relpath(src, start=target_dir))


def link_dirs(source_dirs: list[Path], target_dir: Path) -> None:
    target_dir.mkdir(parents=True, exist_ok=True)
    for source_dir in source_dirs:
        if not source_dir.exists():
            continue
        for src in sorted(source_dir.iterdir()):
            if not src.is_dir():
                continue
            dest = target_dir / src.name
            if dest.exists() or dest.is_symlink():
                reset_path(dest)
            dest.symlink_to(os.path.relpath(src, start=target_dir))


def link_markdown_as_skill_dirs(source_dirs: list[Path], target_dir: Path) -> None:
    target_dir.mkdir(parents=True, exist_ok=True)
    for source_dir in source_dirs:
        if not source_dir.exists():
            continue
        for src in sorted(source_dir.glob("*.md")):
            dest_dir = target_dir / src.stem
            if dest_dir.exists() or dest_dir.is_symlink():
                reset_path(dest_dir)
            dest_dir.mkdir(parents=True, exist_ok=True)
            dest = dest_dir / "SKILL.md"
            if dest.exists() or dest.is_symlink():
                reset_path(dest)
            dest.symlink_to(os.path.relpath(src, start=dest_dir))


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--bundle-root", default=str(BUNDLE_ROOT))
    args = parser.parse_args()

    bundle_root = Path(args.bundle_root).resolve()
    bundle_root.mkdir(parents=True, exist_ok=True)

    link_markdown_files(PERSONA_DIRS, bundle_root / "personas")
    link_markdown_files(PERSONA_DIRS + AGENT_DIRS, bundle_root / "agents")
    link_dirs(SKILL_DIRS, bundle_root / "skills")
    link_markdown_as_skill_dirs(DESIGN_DIRS, bundle_root / "skills")
    link_markdown_files(COMMAND_DIRS, bundle_root / "commands")

    print(f"Host bundle built at {bundle_root}")


if __name__ == "__main__":
    main()
