#!/usr/bin/env python3
from __future__ import annotations

import argparse
import os
import shutil
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent.parent
INTEGRATIONS_GEMINI = REPO_ROOT / "integrations" / "gemini"
BUNDLE_ROOT = REPO_ROOT / "Gemini"
DESIGN_GLOB = "design-md-*.md"

AGENT_SOURCE_DIRS = [
    REPO_ROOT / "Executive" / "personas",
    REPO_ROOT / "Engineering" / "agents",
    REPO_ROOT / "Growth" / "agents",
    REPO_ROOT / "Security" / "agents",
    REPO_ROOT / "Product" / "agents",
    REPO_ROOT / "Infrastructure" / "agents",
    REPO_ROOT / "Legal-Finance" / "agents",
    REPO_ROOT / "Knowledge" / "agents",
]

COMMAND_SOURCE_DIRS = [
    REPO_ROOT / "Engineering" / "commands",
    REPO_ROOT / "Growth" / "commands",
    REPO_ROOT / "Security" / "commands",
    REPO_ROOT / "Product" / "commands",
    REPO_ROOT / "Infrastructure" / "commands",
    REPO_ROOT / "Legal-Finance" / "commands",
    REPO_ROOT / "Knowledge" / "commands",
]


def reset_path(path: Path) -> None:
    if path.is_symlink() or path.is_file():
        path.unlink()
    elif path.is_dir():
        shutil.rmtree(path)


def symlink_into_dir(names: list[str], target_dir: Path, gemini_dir: Path) -> None:
    target_dir.mkdir(parents=True, exist_ok=True)
    for name in sorted(names):
        src = gemini_dir / f"{name}.md"
        if not src.exists():
            raise FileNotFoundError(f"Missing Gemini asset for '{name}': {src}")
        dest = target_dir / src.name
        if dest.exists() or dest.is_symlink():
            reset_path(dest)
        dest.symlink_to(os.path.relpath(src, start=target_dir))


def symlink_skill_dirs(src_root: Path, target_dir: Path) -> None:
    target_dir.mkdir(parents=True, exist_ok=True)
    for src in sorted(src_root.iterdir()):
        if not src.is_dir():
            continue
        dest = target_dir / src.name
        if dest.exists() or dest.is_symlink():
            reset_path(dest)
        dest.symlink_to(os.path.relpath(src, start=target_dir))


def symlink_markdown_as_skill_dirs(pattern: str, src_root: Path, target_dir: Path) -> None:
    target_dir.mkdir(parents=True, exist_ok=True)
    for src in sorted(src_root.glob(pattern)):
        dest_dir = target_dir / src.stem
        if dest_dir.exists() or dest_dir.is_symlink():
            reset_path(dest_dir)
        dest_dir.mkdir(parents=True, exist_ok=True)
        skill_md = dest_dir / "SKILL.md"
        if skill_md.exists() or skill_md.is_symlink():
            reset_path(skill_md)
        skill_md.symlink_to(os.path.relpath(src, start=dest_dir))


def collect_stems(source_dirs: list[Path]) -> list[str]:
    stems: list[str] = []
    for source_dir in source_dirs:
        if not source_dir.exists():
            continue
        stems.extend(path.stem for path in source_dir.glob("*.md"))
    return stems


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--bundle-root", default=str(BUNDLE_ROOT))
    parser.add_argument("--gemini-dir", default=str(INTEGRATIONS_GEMINI))
    args = parser.parse_args()

    bundle_root = Path(args.bundle_root).resolve()
    gemini_dir = Path(args.gemini_dir).resolve()

    if not gemini_dir.exists():
        raise SystemExit(f"Gemini integration directory not found: {gemini_dir}")

    bundle_root.mkdir(parents=True, exist_ok=True)

    skills_dir = bundle_root / "skills"
    reset_path(skills_dir)
    skills_dir.mkdir(parents=True, exist_ok=True)
    symlink_skill_dirs(gemini_dir / "skills", skills_dir)
    symlink_markdown_as_skill_dirs(DESIGN_GLOB, gemini_dir, skills_dir)

    symlink_into_dir(collect_stems(AGENT_SOURCE_DIRS), bundle_root / "agents", gemini_dir)
    symlink_into_dir(collect_stems(COMMAND_SOURCE_DIRS), bundle_root / "commands", gemini_dir)

    print(f"Gemini bundle built at {bundle_root}")


if __name__ == "__main__":
    main()
