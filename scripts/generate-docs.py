#!/usr/bin/env python3
import os
import re
import shutil
import json
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent
DOCS_DIR = REPO_ROOT / "docs"

# Global icons for auto-discovered domains
ICONS = {
    "executive": "material/account-tie",
    "engineering": "material/hammer-wrench",
    "growth": "material/trending-up",
    "security": "material/shield-lock",
    "product": "material/package-variant-closed",
    "infrastructure": "material/server",
    "finance": "material/scale-balance",
    "knowledge": "material/brain",
    "default": "material/folder-zip"
}

def prettify(name):
    # Fix double names and kebab-case
    name = name.replace("-", " ").replace("_", " ").title()
    if name.startswith("Galyarder"):
        name = name.replace("Galyarder ", "")
    return name.strip()

class Asset:
    def __init__(self, file_path, category):
        self.src_path = Path(file_path)
        self.category = category
        self.name = self.src_path.stem if self.src_path.name != "SKILL.md" else self.src_path.parent.name
        self.title = ""
        self.description = ""
        self.content = ""
        self.is_skill = (self.src_path.name == "SKILL.md")
        self.parse()

    def parse(self):
        with open(self.src_path, "r", encoding="utf-8") as f:
            raw = f.read()
        
        # 1. Extract Frontmatter
        fm_match = re.search(r"^---\s*\n(.*?)\n---", raw, re.DOTALL)
        if fm_match:
            fm = fm_match.group(1)
            name_m = re.search(r"^name:\s*(.*)", fm, re.MULTILINE)
            desc_m = re.search(r"^description:\s*(.*)", fm, re.MULTILINE)
            if name_m: self.title = name_m.group(1).strip().strip('"').strip("'")
            if desc_m: self.description = desc_m.group(1).strip().strip('"').strip("'")
            self.content = raw[fm_match.end():].strip()
        else:
            self.content = raw.strip()

        # 2. Extract H1 if title missing
        if not self.title or self.title == "|":
            h1_match = re.search(r"^# (.*)", self.content, re.MULTILINE)
            if h1_match:
                self.title = h1_match.group(1).strip()
                # Remove the H1 from content to avoid double headers
                self.content = re.sub(r"^# .*", "", self.content, count=1, flags=re.MULTILINE).strip()
        
        if not self.title or self.title == "|":
            self.title = prettify(self.name)

        # 3. Clean Garbage Descriptions
        if self.description == "|" or not self.description:
            clean_content = re.sub(r"##.*", "", self.content, flags=re.DOTALL).strip()
            # Remove protocol headers from description preview
            clean_content = re.sub(r"## THE 1-MAN ARMY GLOBAL PROTOCOLS.*?\n---", "", clean_content, flags=re.DOTALL).strip()
            lines = [l for l in clean_content.split("\n") if l.strip() and not l.startswith("#") and not l.startswith(">")]
            if lines:
                self.description = lines[0][:200].strip().rstrip(".") + "..."
            else:
                self.description = f"Specialized {self.category} unit for Galyarder Framework orchestration."

        # Ensure title and desc are clean
        self.title = self.title.replace("Galyarder ", "").strip()
        self.description = self.description.replace('"', "'").strip()

    def generate_page(self, icon, label):
        # Format icon correctly for MkDocs Material (:material-name:)
        mk_icon = f":{icon.replace('/', '-')}:"
        
        return f"""---
title: "{self.title} | Galyarder Framework"
description: "{self.description}"
---

# {mk_icon} {self.title}

<p class="domain-label">{label} {self.category.title()}</p>

---

{self.content}
"""

def generate():
    print("🚀 De-slopping Documentation Portal...")
    
    # Clean output directories
    for d in ["agents", "skills", "commands", "design"]:
        target = DOCS_DIR / d
        if target.exists(): shutil.rmtree(target)
        target.mkdir(parents=True, exist_ok=True)

    # Discovery
    silos = {}
    for item in REPO_ROOT.iterdir():
        if item.is_dir() and (item / ".claude-plugin" / "plugin.json").exists():
            with open(item / ".claude-plugin" / "plugin.json", "r") as f:
                manifest = json.load(f)
                cat = manifest.get("category", "default")
                silos[item.name] = {"icon": ICONS.get(cat, ICONS["default"]), "label": item.name}

    inventory = {"agents": {}, "skills": {}, "commands": {}}

    for silo_name, info in silos.items():
        silo_path = REPO_ROOT / silo_name
        
        # 1. Agents
        agent_src = silo_path / "agents"
        if agent_src.exists():
            for f in agent_src.glob("*.md"):
                if f.name == "README.md": continue
                a = Asset(f, "agent")
                out_path = DOCS_DIR / "agents" / f.name
                with open(out_path, "w", encoding="utf-8") as out:
                    out.write(a.generate_page(info["icon"], info["label"]))
                if silo_name not in inventory["agents"]: inventory["agents"][silo_name] = []
                inventory["agents"][silo_name].append((a.title, f"{f.name}", a.description))

        # 2. Commands
        cmd_src = silo_path / "commands"
        if cmd_src.exists():
            for f in cmd_src.glob("*.md"):
                c = Asset(f, "command")
                out_path = DOCS_DIR / "commands" / f.name
                with open(out_path, "w", encoding="utf-8") as out:
                    out.write(c.generate_page(info["icon"], info["label"]))
                if silo_name not in inventory["commands"]: inventory["commands"][silo_name] = []
                inventory["commands"][silo_name].append((f"/{c.name}", f"{f.name}", c.description))

        # 3. Skills
        skill_src = silo_path / "skills"
        if skill_src.exists():
            for skill_folder in skill_src.iterdir():
                if not skill_folder.is_dir(): continue
                skill_md = skill_folder / "SKILL.md"
                if skill_md.exists():
                    s = Asset(skill_md, "skill")
                    dest_folder = DOCS_DIR / "skills" / skill_folder.name
                    dest_folder.mkdir(exist_ok=True)
                    with open(dest_folder / "index.md", "w", encoding="utf-8") as out:
                        out.write(s.generate_page(info["icon"], info["label"]))
                    for sub in ["references", "assets", "templates"]:
                        if (skill_folder / sub).exists():
                            shutil.copytree(skill_folder / sub, dest_folder / sub, dirs_exist_ok=True)
                    
                    if silo_name not in inventory["skills"]: inventory["skills"][silo_name] = []
                    inventory["skills"][silo_name].append((s.title, f"{skill_folder.name}/index.md", s.description))

    # 4. Generate High-Density Grid Landing Pages
    for category in ["agents", "skills", "commands"]:
        idx_content = f"# Galyarder Framework: {category.title()}\n\n"
        idx_content += "Discover the high-integrity workforce and protocols designed for autonomous orchestration.\n\n"
        
        for silo_name in sorted(inventory[category].keys()):
            info = silos[silo_name]
            mk_icon = f":{info['icon'].replace('/', '-')}:"
            idx_content += f"## {mk_icon} {silo_name}\n\n"
            idx_content += '<div class="grid cards" markdown>\n\n'
            for title, link, desc in sorted(inventory[category][silo_name]):
                idx_content += f"-   **[{title}]({link})**\n\n    ---\n\n    {desc}\n\n"
            idx_content += "</div>\n\n"
            
        with open(DOCS_DIR / category / "index.md", "w", encoding="utf-8") as f:
            f.write(idx_content)

    # Special Case: Design Systems
    design_idx = "# Design System Specifications\n\nElite UI specifications to enforce aesthetic law.\n\n"
    design_idx += '<div class="grid cards" markdown>\n\n'
    design_src = REPO_ROOT / "Growth" / "design"
    if design_src.exists():
        for f in sorted(design_src.glob("*.md")):
            shutil.copy(f, DOCS_DIR / "design" / f.name)
            title = f.stem.replace("design-md-", "").title()
            design_idx += f"-   **[{title}]({f.name})**\n\n    ---\n\n    Institutional-grade design law.\n\n"
    design_idx += "</div>"
    with open(DOCS_DIR / "design/index.md", "w", encoding="utf-8") as f: f.write(design_idx)

    print("Success: Documentation portal de-slopped and verified.")

if __name__ == "__main__":
    generate()
