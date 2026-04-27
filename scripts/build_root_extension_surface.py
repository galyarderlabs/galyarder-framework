#!/usr/bin/env python3
from __future__ import annotations

import argparse
import re
import shutil
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent.parent

PERSONA_DIRS = [REPO_ROOT / "personas"]
AGENT_DIRS = [REPO_ROOT / "agents"]
SKILL_DIRS = [REPO_ROOT / "skills"]
COMMAND_DIRS = [REPO_ROOT / "commands"]

DISALLOWED_AGENT_KEYS = {"color", "emoji", "vibe"}
TOOL_NAME_MAP = {
    "read_file": "read_file",
    "grep_search": "grep_search",
    "glob": "glob",
    "run_shell_command": "run_shell_command",
    "write_file": "write_file",
    "replace": "replace",
}


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
                continue
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


def normalize_agent_frontmatter(markdown: str) -> str:
    cleaned = strip_frontmatter_keys(markdown, DISALLOWED_AGENT_KEYS)
    if not cleaned.startswith("---\n"):
        return cleaned

    end = cleaned.find("\n---\n", 4)
    if end == -1:
        return cleaned

    frontmatter = cleaned[4:end].splitlines()
    rewritten: list[str] = []
    for line in frontmatter:
        match = re.match(r"^tools:\s*\[(.*)\]\s*$", line)
        if not match:
            rewritten.append(line)
            continue

        raw_tools = [item.strip() for item in match.group(1).split(",") if item.strip()]
        mapped: list[str] = []
        for tool in raw_tools:
            mapped_name = TOOL_NAME_MAP.get(tool)
            if mapped_name and mapped_name not in mapped:
                mapped.append(mapped_name)
        rewritten.append("tools:")
        for tool_name in mapped:
            rewritten.append(f"  - {tool_name}")

    body = cleaned[end + 5 :]
    return "---\n" + "\n".join(rewritten) + "\n---\n" + body


def copy_unique_agent_markdown(source_dirs: list[Path], target_dir: Path) -> None:
    seen: dict[str, Path] = {}
    target_dir.mkdir(parents=True, exist_ok=True)

    for source_dir in source_dirs:
        if not source_dir.exists():
            continue
        for src in sorted(source_dir.glob("*.md")):
            if src.name in seen:
                continue
            seen[src.name] = src
            content = normalize_agent_frontmatter(src.read_text())
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


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output-root", default=str(REPO_ROOT))
    args = parser.parse_args()

    output_root = Path(args.output_root).resolve()
    output_root.mkdir(parents=True, exist_ok=True)
    if output_root == REPO_ROOT:
        print(f"Root runtime is canonical at {output_root}")
        return
    build_surface(output_root)
    print(f"Root extension surface built at {output_root}")


if __name__ == "__main__":
    main()
