import os
import json
import re
import shutil
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

def extract_metadata(file_path):
    name, desc = "", ""
    try:
        with open(file_path, "r", encoding="utf-8") as f:
            content = f.read()
            fm_match = re.search(r"^---\s*\n(.*?)\n---", content, re.DOTALL)
            if fm_match:
                fm = fm_match.group(1)
                name_m = re.search(r"^name:\s*(.*)", fm, re.MULTILINE)
                desc_m = re.search(r"^description:\s*(.*)", fm, re.MULTILINE)
                if name_m: name = name_m.group(1).strip().strip('"').strip("'")
                if desc_m: desc = desc_m.group(1).strip().strip('"').strip("'")
            if not name:
                h1_match = re.search(r"^# (.*)", content, re.MULTILINE)
                if h1_match: name = h1_match.group(1).strip()
    except: pass
    return name, desc

def generate():
    print("🚀 Initializing Mars Mission: Dynamic Asset Discovery...")
    
    for d in ["agents", "skills", "commands", "design"]:
        target = DOCS_DIR / d
        if target.exists(): shutil.rmtree(target)
        target.mkdir(parents=True, exist_ok=True)

    # 1. Discover all Silos (any directory with a plugin.json)
    silos = {}
    for item in REPO_ROOT.iterdir():
        if item.is_dir() and (item / ".claude-plugin" / "plugin.json").exists():
            with open(item / ".claude-plugin" / "plugin.json", "r") as f:
                manifest = json.load(f)
                category = manifest.get("category", "default")
                silos[item.name] = {
                    "name": manifest.get("name", item.name),
                    "category": category,
                    "icon": ICONS.get(category, ICONS["default"]),
                    "path": item
                }
    
    print(f"[*] Discovered {len(silos)} independent organizational silos.")

    assets = {"agents": {}, "skills": {}, "commands": {}}

    for silo_name, info in silos.items():
        silo_path = info["path"]
        print(f"[*] Mapping Silo: {silo_name}")
        
        # Agents
        agent_src = silo_path / "agents"
        if agent_src.exists():
            for f in agent_src.glob("*.md"):
                if f.name == "README.md": continue
                name, desc = extract_metadata(f)
                shutil.copy(f, DOCS_DIR / "agents" / f.name)
                if silo_name not in assets["agents"]: assets["agents"][silo_name] = []
                assets["agents"][silo_name].append((name or f.stem, f"../agents/{f.name}", desc))

        # Commands
        cmd_src = silo_path / "commands"
        if cmd_src.exists():
            for f in cmd_src.glob("*.md"):
                shutil.copy(f, DOCS_DIR / "commands" / f.name)
                if silo_name not in assets["commands"]: assets["commands"][silo_name] = []
                assets["commands"][silo_name].append((f"/{f.stem}", f"../commands/{f.name}", ""))

        # Skills
        skill_src = silo_path / "skills"
        if skill_src.exists():
            for skill_folder in skill_src.iterdir():
                if not skill_folder.is_dir(): continue
                skill_md = skill_folder / "SKILL.md"
                if skill_md.exists():
                    name, desc = extract_metadata(skill_md)
                    dest_folder = DOCS_DIR / "skills" / skill_folder.name
                    dest_folder.mkdir(exist_ok=True)
                    shutil.copy(skill_md, dest_folder / "index.md")
                    for sub in ["references", "assets", "templates"]:
                        if (skill_folder / sub).exists():
                            shutil.copytree(skill_folder / sub, dest_folder / sub, dirs_exist_ok=True)
                    if silo_name not in assets["skills"]: assets["skills"][silo_name] = []
                    assets["skills"][silo_name].append((name or skill_folder.name, f"../skills/{skill_folder.name}/index.md", desc))

    # 2. Generate Grid Landing Pages
    for category in ["agents", "skills", "commands"]:
        idx_content = f"# Galyarder Framework {category.title()}\n\n"
        idx_content += '<div class="grid cards" markdown>\n'
        for silo_name, silo_assets in assets[category].items():
            info = silos[silo_name]
            idx_content += f"\n## :{info['icon']}: {silo_name}\n\n"
            for title, link, desc in sorted(silo_assets):
                idx_content += f"-   **[{title}]({link})**\n\n    ---\n\n    {desc}\n"
        idx_content += "\n</div>"
        with open(DOCS_DIR / f"{category}/index.md", "w") as f:
            f.write(idx_content)

    print("🌌 Olympus Mons Deployment Complete. System is now Dynamic.")

if __name__ == "__main__":
    generate()
