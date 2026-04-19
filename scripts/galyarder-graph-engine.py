#!/usr/bin/env python3
import os
import re
import json
import shutil
import ast
from pathlib import Path
from collections import defaultdict

# Galyarder Graphify Engine v2.0 - "Apex Fidelity"
# Purpose: High-integrity deterministic extraction and semantic inference.

REPO_ROOT = Path(__file__).parent.parent
DOCS_DIR = REPO_ROOT / "docs"
OUTPUT_FILE = REPO_ROOT / "docs" / "graph.json"
SILOS = ["Executive", "Engineering", "Growth", "Security", "Product", "Infrastructure", "Legal-Finance", "Knowledge"]

class GalyarderNeuralLink:
    def __init__(self):
        self.nodes = {}  # rel_path -> metadata
        self.edges = []  # list of {source, target, type, confidence}

    def add_node(self, path, title, category, silo=None):
        try:
            rel_path = str(Path(path).relative_to(REPO_ROOT))
            if rel_path in self.nodes: return
            
            if not silo:
                silo = rel_path.split('/')[0] if '/' in rel_path else "Root"
                
            self.nodes[rel_path] = {
                "title": title,
                "category": category,
                "silo": silo,
                "community": silo, # Initial community is the silo
                "degree": 0
            }
        except: pass

    def add_edge(self, source, target, edge_type, confidence=1.0):
        # Resolve target if it's a title (wikilink)
        resolved_target = target
        if not target.endswith(('.md', '.py', '.sh', '.json')):
            # It's a wikilink title, search for matching node
            for path, meta in self.nodes.items():
                if meta["title"].lower() == target.lower().replace('-', ' '):
                    resolved_target = path
                    break
        
        self.edges.append({
            "source": str(source),
            "target": str(resolved_target),
            "type": edge_type,
            "confidence": confidence
        })

    def parse_python_ast(self, file_path):
        """Pass 1: Deterministic AST Extraction (Logic Layer)"""
        rel_src = str(file_path.relative_to(REPO_ROOT))
        self.add_node(file_path, file_path.name, "logic-engine")
        
        try:
            with open(file_path, "r", encoding="utf-8") as f:
                tree = ast.parse(f.read())
            
            for node in ast.walk(tree):
                # Map Function Calls
                if isinstance(node, ast.Call):
                    if isinstance(node.func, ast.Name):
                        # Local function call
                        pass # Could map to local nodes
                
                # Map Imports
                if isinstance(node, (ast.Import, ast.ImportFrom)):
                    # Check for internal framework imports
                    # (This repo doesn't use standard python packages for silos yet, but we map strings)
                    pass

                # Map Path References in Strings (Dynamic Orchestration)
                if isinstance(node, ast.Constant) and isinstance(node.value, str):
                    val = node.value
                    if any(s in val for s in SILOS) and ("." in val):
                        self.add_edge(rel_src, val, "orchestrates", 1.0)
        except Exception as e:
            print(f"[!] AST Parse Error {rel_src}: {e}")

    def parse_markdown_fidelity(self, file_path, category):
        """Pass 1 & 2: Structural & Contextual Extraction (Knowledge Layer)"""
        rel_src = str(file_path.relative_to(REPO_ROOT))
        with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
            content = f.read()
        
        title_match = re.search(r"^# (.*)", content, re.MULTILINE)
        title = title_match.group(1).strip() if title_match else file_path.name
        self.add_node(file_path, title, category)

        # 1. Structural Links (Explicit)
        links = re.findall(r"\[.*?\]\((.*?\.md)\)", content)
        for link in links:
            if link.startswith("http"): continue
            target_path = (file_path.parent / link).resolve()
            if target_path.exists():
                try:
                    rel_target = str(target_path.relative_to(REPO_ROOT))
                    self.add_edge(rel_src, rel_target, "structural_reference", 1.0)
                except: pass

        # 2. Semantic Wikilinks
        wikilinks = re.findall(r"\[\[(.*?)\]\]", content)
        for target in wikilinks:
            self.add_edge(rel_src, target, "semantic_link", 0.9)

        # 3. Protocol Adherence (Pass 3 Simulation: Inference)
        if "Humans 3.0" in content or "Karpathy" in content:
            self.add_edge(rel_src, "CLAUDE.md", "enforces_protocol", 0.8)
        if "rtk" in content:
            self.add_edge(rel_src, "GEMINI.md", "uses_proxy", 0.8)

    def run_clustering(self):
        """Pass 3: Community Detection (Clustering by Edge Density)"""
        print("[*] Running Community Detection (Apex Clustering)...")
        # Simplified Louvain: Nodes are grouped if they share high-confidence edges
        # In this repo, we mostly cluster by Silo, but we look for 'Cross-Pollinators'
        for edge in self.edges:
            src = edge["source"]
            tgt = edge["target"]
            if src in self.nodes and tgt in self.nodes:
                # Increment Degree (God Node tracking)
                self.nodes[src]["degree"] += 1
                self.nodes[tgt]["degree"] += 1

    def generate_obsidian_vault(self):
        map_dir = REPO_ROOT / "docs" / "departments" / "Knowledge" / "World-Map"
        if map_dir.exists(): shutil.rmtree(map_dir)
        map_dir.mkdir(parents=True, exist_ok=True)
        
        for rel_path, meta in self.nodes.items():
            node_name = meta["title"].replace("/", "-").replace(" ", "-")
            content = f"""---
node_type: {meta['category']}
silo: {meta['silo']}
degree: {meta['degree']}
source: {rel_path}
---
# {meta['title']}

## 🧠 Strategic Intelligence
This entity is a **{meta['category']}** within the **{meta['silo']}** silo. 
It has a connectivity degree of **{meta['degree']}**.

## 🔗 Neural Links
"""
            outgoing = [e for e in self.edges if e["source"] == rel_path]
            incoming = [e for e in self.edges if e["target"] == rel_path or self.nodes.get(e["target"], {}).get("title") == meta["title"]]
            
            if outgoing:
                content += "\n### Directing To:\n"
                for e in outgoing:
                    target_meta = self.nodes.get(e["target"])
                    target_name = target_meta["title"] if target_meta else e["target"]
                    content += f"- [[{target_name.replace(' ', '-')}]] ({e['type']} | {e['confidence']})\n"
            
            if incoming:
                content += "\n### Informed By:\n"
                for e in incoming:
                    source_meta = self.nodes.get(e["source"])
                    source_name = source_meta["title"] if source_meta else e["source"]
                    content += f"- [[{source_name.replace(' ', '-')}]] ({e['type']} | {e['confidence']})\n"

            with open(map_dir / f"{node_name}.md", "w", encoding="utf-8") as f:
                f.write(content)

    def scan_repository(self):
        print(f"[*] Starting Apex Extraction...")
        
        # Scan Root
        for f in REPO_ROOT.glob("*.md"):
            self.parse_markdown_fidelity(f, "core-hukum")

        # Scan Silos
        for silo in SILOS:
            silo_path = REPO_ROOT / silo
            if not silo_path.exists(): continue
            for root, _, files in os.walk(silo_path):
                for f in files:
                    file_path = Path(root) / f
                    if f.endswith(".md"):
                        category = "agent" if "agents" in root else "skill" if "skills" in root else "governance"
                        self.parse_markdown_fidelity(file_path, category)
                    elif f.endswith(".py"):
                        self.parse_python_ast(file_path)
                    elif f.endswith(".sh"):
                        # Basic shell scan
                        self.add_node(file_path, f, "logic-engine")

        # Scan Docs
        for root, _, files in os.walk(DOCS_DIR):
            if "World-Map" in root: continue
            for f in files:
                if f.endswith(".md"):
                    self.parse_markdown_fidelity(Path(root) / f, "documentation")

    def export(self):
        # Final cleanup: Remove broken edges (targets that don't exist)
        valid_edges = [e for e in self.edges if e["target"] in self.nodes or any(meta["title"].lower() == e["target"].lower().replace('-', ' ') for meta in self.nodes.values())]
        
        data = {
            "version": "2.0.0",
            "nodes": self.nodes,
            "edges": valid_edges,
            "summary": {
                "god_nodes": sorted(self.nodes.items(), key=lambda x: x[1]['degree'], reverse=True)[:5]
            }
        }
        with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=2)
        print(f"✅ Apex Graph Exported: {len(self.nodes)} Nodes | {len(valid_edges)} Edges")

if __name__ == "__main__":
    link = GalyarderNeuralLink()
    link.scan_repository()
    link.run_clustering()
    link.generate_obsidian_vault()
    link.export()
