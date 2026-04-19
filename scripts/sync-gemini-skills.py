#!/usr/bin/env python3
import os
import shutil
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent
GEMINI_SRC = REPO_ROOT / "integrations" / "gemini" / "skills"

GEMINI_DIR = REPO_ROOT / ".gemini"
SKILLS_DEST = GEMINI_DIR / "skills"

def sync():
    if not GEMINI_SRC.exists():
        raise SystemExit(f"Gemini integration source not found: {GEMINI_SRC}")

    if SKILLS_DEST.exists():
        shutil.rmtree(SKILLS_DEST)
    SKILLS_DEST.mkdir(parents=True, exist_ok=True)

    for item in sorted(GEMINI_SRC.iterdir()):
        dest = SKILLS_DEST / item.name
        if dest.exists() or dest.is_symlink():
            if dest.is_dir() and not dest.is_symlink():
                shutil.rmtree(dest)
            else:
                dest.unlink()
        os.symlink(item, dest)

    print(f"Gemini skills synced from {GEMINI_SRC} to {SKILLS_DEST}")

if __name__ == "__main__":
    sync()
