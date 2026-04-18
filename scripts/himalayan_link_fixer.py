import os
import re
from pathlib import Path

REPO_ROOT = Path(os.getcwd())

# Mapping of asset names to their new department-relative paths
# This allows us to resolve [text](../skills/name) regardless of where it moved.
ASSET_MAP = {}

def build_asset_map():
    print("[*] Building Himalayan Asset Map...")
    # Find all .md and folders with SKILL.md
    for root, dirs, files in os.walk(REPO_ROOT):
        if ".git" in root: continue
        rel_root = Path(root).relative_to(REPO_ROOT)
        
        for f in files:
            if f.endswith(".md"):
                name = f.replace(".md", "")
                if f == "SKILL.md":
                    name = Path(root).name
                ASSET_MAP[name] = rel_root / f

def fix_links_in_file(file_path):
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()
    
    def link_replacer(match):
        text = match.group(1)
        link = match.group(2)
        
        # We only care about internal relative links that look like they point to our old structure
        if link.startswith(".") and ".md" in link:
            # Extract the asset name from the link (e.g., ../skills/seo-audit/SKILL.md -> seo-audit)
            parts = link.split("/")
            asset_name = ""
            for p in reversed(parts):
                if p and p != "SKILL.md" and p != "index.md":
                    asset_name = p.replace(".md", "")
                    break
            
            if asset_name in ASSET_MAP:
                new_dest = ASSET_MAP[asset_name]
                # Calculate new relative path from current file to new_dest
                current_dir = Path(file_path).parent.relative_to(REPO_ROOT)
                try:
                    rel_path = os.path.relpath(new_dest, current_dir)
                    return f"[{text}]({rel_path})"
                except:
                    return match.group(0)
        return match.group(0)

    # Match [text](link)
    new_content = re.sub(r"\[([^\]]+)\]\(([^)]+)\)", link_replacer, content)
    
    if new_content != content:
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(new_content)
        return True
    return False

def main():
    build_asset_map()
    count = 0
    print("[*] Performing Surgical Link Realignment...")
    for root, dirs, files in os.walk(REPO_ROOT):
        if ".git" in root or "integrations" in root or "docs" in root: continue
        for f in files:
            if f.endswith(".md"):
                if fix_links_in_file(os.path.join(root, f)):
                    count += 1
    print(f"[SUCCESS] Realigned links in {count} files. We have reached the base camp of the Himalayas.")

if __name__ == "__main__":
    main()
