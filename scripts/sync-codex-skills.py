#!/usr/bin/env python3
import os
import shutil
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
SKILLS_SRC = REPO_ROOT / "skills"
AGENTS_SRC = REPO_ROOT / "agents"
PERSONAS_SRC = REPO_ROOT / "personas"
DESIGN_SRC = REPO_ROOT / "design"
COMMANDS_SRC = REPO_ROOT / "commands"

CODEX_DIR = REPO_ROOT / ".codex"
SKILLS_DEST = CODEX_DIR / "skills"

def sync():
    try:
        if SKILLS_DEST.exists():
            shutil.rmtree(SKILLS_DEST)
        SKILLS_DEST.mkdir(parents=True, exist_ok=True)

        # Process all sources
        for src_dir in [SKILLS_SRC, AGENTS_SRC, PERSONAS_SRC, DESIGN_SRC, COMMANDS_SRC]:
            if not src_dir.exists(): continue
            for item in src_dir.rglob("SKILL.md"):
                name = item.parent.name
                dest = SKILLS_DEST / name
                if not dest.exists():
                    os.symlink(item.parent, dest)
            for item in src_dir.glob("*.md"):
                if item.name == "README.md" or item.name == "SKILL.md": continue
                name = item.stem
                dest = SKILLS_DEST / name
                dest.mkdir(exist_ok=True)
                if not (dest / "SKILL.md").exists():
                    os.symlink(item, dest / "SKILL.md")

        print(f"Codex skills synced to {SKILLS_DEST}")
    except OSError as e:
        raise SystemExit(f"Failed to sync Codex skills: {e}")

if __name__ == "__main__":
    sync()
