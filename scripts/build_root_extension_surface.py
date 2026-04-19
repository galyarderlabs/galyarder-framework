#!/usr/bin/env python3
from __future__ import annotations

import argparse
import re
import shutil
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent.parent

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

DISALLOWED_AGENT_KEYS = {"color", "emoji", "vibe"}


def reset_path(path: Path) -> None:
    if path.is_symlink() or path.is_file():
        path.unlink()
    elif path.is_dir():
        shutil.rmtree(path)


def ensure_empty_dir(path: Path) -> None:
    if path.exists() or path.is_symlink():
        reset_path(path)
    path.mkdir(parents=True, exist_ok=True)


def copy_unique_markdown(source_dirs: list[Path], target_dir: Path) -> None:
    seen: dict[str, Path] = {}
    target_dir.mkdir(parents=True, exist_ok=True)

    for source_dir in source_dirs:
        if not source_dir.exists():
            continue
        for src in sorted(source_dir.glob("*.md")):
            if src.name in seen:
                raise SystemExit(f"Duplicate markdown asset '{src.name}': {seen[src.name]} and {src}")
            seen[src.name] = src
            shutil.copy2(src, target_dir / src.name)


def strip_frontmatter_keys(markdown: str, disallowed_keys: set[str]) -> str:
    if not markdown.startswith("---\n"):
        return markdown

    end = markdown.find("\n---\n", 4)
    if end == -1:
        return markdown

    frontmatter = markdown[4:end].splitlines()
    kept_lines = []
    for line in frontmatter:
        match = re.match(r"^([A-Za-z0-9_-]+):", line)
        if match and match.group(1) in disallowed_keys:
            continue
        kept_lines.append(line)

    body = markdown[end + 5 :]
    return "---\n" + "\n".join(kept_lines) + "\n---\n" + body


def copy_unique_agent_markdown(source_dirs: list[Path], target_dir: Path) -> None:
    seen: dict[str, Path] = {}
    target_dir.mkdir(parents=True, exist_ok=True)

    for source_dir in source_dirs:
        if not source_dir.exists():
            continue
        for src in sorted(source_dir.glob("*.md")):
            if src.name in seen:
                raise SystemExit(f"Duplicate markdown asset '{src.name}': {seen[src.name]} and {src}")
            seen[src.name] = src
            content = strip_frontmatter_keys(src.read_text(), DISALLOWED_AGENT_KEYS)
            (target_dir / src.name).write_text(content)


def copy_unique_skill_dirs(source_dirs: list[Path], target_dir: Path) -> None:
    seen: dict[str, Path] = {}
    target_dir.mkdir(parents=True, exist_ok=True)

    for source_dir in source_dirs:
        if not source_dir.exists():
            continue
        for src in sorted(source_dir.iterdir()):
            if not src.is_dir():
                continue
            if src.name in seen:
                raise SystemExit(f"Duplicate skill directory '{src.name}': {seen[src.name]} and {src}")
            seen[src.name] = src
            shutil.copytree(src, target_dir / src.name)


def copy_design_markdown_as_skills(source_dirs: list[Path], target_dir: Path) -> None:
    seen: dict[str, Path] = {}
    target_dir.mkdir(parents=True, exist_ok=True)

    for source_dir in source_dirs:
        if not source_dir.exists():
            continue
        for src in sorted(source_dir.glob("*.md")):
            skill_name = src.stem
            if skill_name in seen:
                raise SystemExit(f"Duplicate design skill '{skill_name}': {seen[skill_name]} and {src}")
            seen[skill_name] = src
            dest_dir = target_dir / skill_name
            dest_dir.mkdir(parents=True, exist_ok=True)
            title = src.stem.replace("-", " ").strip()
            wrapped = (
                "---\n"
                f"name: {skill_name}\n"
                f'description: "Design system reference for {title}."\n'
                "---\n\n"
                + src.read_text()
            )
            (dest_dir / "SKILL.md").write_text(wrapped)


def build_surface(output_root: Path) -> None:
    agents_dir = output_root / "agents"
    skills_dir = output_root / "skills"
    commands_dir = output_root / "commands"
    personas_dir = output_root / "personas"

    for path in (agents_dir, skills_dir, commands_dir, personas_dir):
        ensure_empty_dir(path)

    copy_unique_agent_markdown(PERSONA_DIRS, personas_dir)
    copy_unique_agent_markdown(PERSONA_DIRS + AGENT_DIRS, agents_dir)
    copy_unique_markdown(COMMAND_DIRS, commands_dir)
    copy_unique_skill_dirs(SKILL_DIRS, skills_dir)
    copy_design_markdown_as_skills(DESIGN_DIRS, skills_dir)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output-root", default=str(REPO_ROOT))
    args = parser.parse_args()

    output_root = Path(args.output_root).resolve()
    output_root.mkdir(parents=True, exist_ok=True)
    build_surface(output_root)
    print(f"Root extension surface built at {output_root}")


if __name__ == "__main__":
    main()
