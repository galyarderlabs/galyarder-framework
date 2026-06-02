#!/usr/bin/env python3
import os
import json
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent

def main() -> None:
    skills_dir = REPO_ROOT / "skills"
    manifest = {}
    
    if skills_dir.exists():
        for item in sorted(skills_dir.iterdir()):
            if item.is_dir() and (item / "SKILL.md").exists():
                manifest[item.name] = f"skills/{item.name}/SKILL.md"
                
    manifest_path = REPO_ROOT / "skills.json"
    with open(manifest_path, "w", encoding="utf-8") as f:
        json.dump(manifest, f, indent=2)
        f.write("\n")
        
    print(f"Manifest successfully synced to {manifest_path}")

if __name__ == "__main__":
    main()
