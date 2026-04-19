#!/usr/bin/env python3
import os
import re
import json
import shutil
from pathlib import Path

# Galyarder Graphify Engine v1.1 - "Deep Link" Edition
# Purpose: Comprehensive repository-wide relationship mapping.

REPO_ROOT = Path(__file__).parent.parent
DOCS_DIR = REPO_ROOT / "docs"
OUTPUT_FILE = REPO_ROOT / "docs" / "graph.json"
SILOS = ["Executive", "Engineering", "Growth", "Security", "Product", "Infrastructure", "Legal-Finance", "Knowledge"]

class Graphify:
    def __init__(self):
        self.nodes = {}  # rel_path -> metadata
        self.edges = []  # list of {source, target, type}

    def add_node(self, path, title, category):
        try:
            rel_path = str(Path(path).relative_to(REPO_ROOT))
            self.nodes[rel_path] = {
                "title": title,
                "category": category,
                "silo": rel_path.split('/')[0] if '/' in rel_path else "Root"
            }
        except: pass

    def add_edge(self, source, target, edge_type):
        self.edges.append({
            "source": str(source),
            "target": str(target),
            "type": edge_type
        })

    def scan_all(self):
        print(f"[*] Executing Deep Scan across {len(SILOS)} Silos...")
        
        # 1. Scan root MD files
        for f in REPO_ROOT.glob("*.md"):
            self.process_markdown(f, "core-hukum")

        # 2. Scan each Silo
        for silo in SILOS:
            silo_path = REPO_ROOT / silo
            if not silo_path.exists(): continue
            
            for root, _, files in os.walk(silo_path):
                for f in files:
                    file_path = Path(root) / f
                    if f.endswith(".md"):
                        category = "agent" if "agents" in root else "skill" if "skills" in root else "governance"
                        self.process_markdown(file_path, category)
                    elif f.endswith(".py") or f.endswith(".sh"):
                        self.process_logic(file_path, "logic-engine")

        # 3. Scan docs/
        for root, _, files in os.walk(DOCS_DIR):
            for f in files:
                if f.endswith(".md"):
                    self.process_markdown(Path(root) / f, "documentation")

    def process_markdown(self, path, category):
        rel_src = str(path.relative_to(REPO_ROOT))
        with open(path, "r", encoding="utf-8", errors="ignore") as file:
            content = file.read()
        
        title_match = re.search(r"^# (.*)", content, re.MULTILINE)
        title = title_match.group(1).strip() if title_match else path.name
        self.add_node(path, title, category)
        
        # Map [[wikilinks]]
        wikilinks = re.findall(r"\[\[(.*?)\]\]", content)
        for target in wikilinks:
            self.add_edge(rel_src, target, "semantic_link")

        # Map relative links
        links = re.findall(r"\[.*?\]\((.*?\.md)\)", content)
        for link in links:
            if link.startswith("http"): continue
            target_path = (path.parent / link).resolve()
            if target_path.exists():
                try:
                    rel_target = str(target_path.relative_to(REPO_ROOT))
                    self.add_edge(rel_src, rel_target, "structural_reference")
                except: pass

    def process_logic(self, path, category):
        rel_src = str(path.relative_to(REPO_ROOT))
        self.add_node(path, path.name, category)
        
        with open(path, "r", encoding="utf-8", errors="ignore") as file:
            content = file.read()
        
        # Find path references
        paths = re.findall(r"['\"]((?:Executive|Engineering|Growth|Security|Product|Infrastructure|Legal-Finance|Knowledge)/.*?\.(?:md|py|sh))['\"]", content)
        for p in paths:
            self.add_edge(rel_src, p, "orchestrates")

    def generate_obsidian_map(self):
        map_dir = REPO_ROOT / "docs" / "departments" / "Knowledge" / "World-Map"
        if map_dir.exists(): shutil.rmtree(map_dir)
        map_dir.mkdir(parents=True, exist_ok=True)
        print(f"[*] Finalizing World Map in Obsidian...")
        
        for rel_path, meta in self.nodes.items():
            node_name = meta["title"].replace("/", "-").replace(" ", "-")
            content = f"""---
node_type: {meta['category']}
silo: {meta['silo']}
source_path: {rel_path}
---
# {meta['title']}

## 🔗 Connections
"""
            outgoing = [e for e in self.edges if e["source"] == rel_path]
            incoming = [e for e in self.edges if e["target"] == rel_path or self.nodes.get(e["target"], {}).get("title") == meta["title"]]
            
            if outgoing:
                content += "\n### Directing To:\n"
                for e in outgoing:
                    target_name = self.nodes.get(e["target"], {}).get("title", e["target"])
                    content += f"- [[{target_name.replace(' ', '-')}]] ({e['type']})\n"
            
            if incoming:
                content += "\n### Informed By:\n"
                for e in incoming:
                    source_name = self.nodes.get(e["source"], {}).get("title", e["source"])
                    content += f"- [[{source_name.replace(' ', '-')}]] ({e['type']})\n"

            with open(map_dir / f"{node_name}.md", "w", encoding="utf-8") as f:
                f.write(content)

    def generate_mermaid_summary(self):
        # Create a simplified high-level graph for the web portal
        summary_path = REPO_ROOT / "docs" / "KNOWLEDGE_GRAPH_SUMMARY.md"
        content = "# 🧠 Knowledge Graph Summary\n\n## High-Level Orchestration Map\n\n```mermaid\ngraph LR\n"
        
        # Only show connections between Silos
        silo_edges = set()
        for e in self.edges:
            s_silo = self.nodes.get(e["source"], {}).get("silo", "Root")
            t_silo = self.nodes.get(e["target"], {}).get("silo")
            if not t_silo:
                # Try to find silo by path
                t_silo = e["target"].split('/')[0] if '/' in e["target"] else "Root"
            
            if s_silo != t_silo and t_silo in SILOS + ["Root"]:
                silo_edges.add((s_silo, t_silo))
        
        for s, t in sorted(silo_edges):
            content += f"    {s} --> {t}\n"
        
        content += "```\n\n## Statistics\n"
        content += f"- **Total Entities**: {len(self.nodes)}\n"
        content += f"- **Total Relationships**: {len(self.edges)}\n"
        
        with open(summary_path, "w", encoding="utf-8") as f:
            f.write(content)

    def export(self):
        data = {"nodes": self.nodes, "edges": self.edges}
        with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=2)

if __name__ == "__main__":
    engine = Graphify()
    engine.scan_all()
    engine.generate_obsidian_map()
    engine.generate_mermaid_summary()
    engine.export()
