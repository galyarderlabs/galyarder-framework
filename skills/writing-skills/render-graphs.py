#!/usr/bin/env python3
"""Render graphviz diagrams from a skill's SKILL.md to SVG files.

Usage:
  ./render-graphs.py <skill-directory>           # Render each diagram separately
  ./render-graphs.py <skill-directory> --combine # Combine all into one diagram

Extracts all ```dot blocks from SKILL.md and renders to SVG.
Useful for helping your human partner visualize the process flows.

Requires: graphviz (dot) installed on system
"""

import re
import shutil
import subprocess
import sys
from pathlib import Path


def extract_dot_blocks(markdown):
    blocks = []
    for match in re.finditer(r"```dot\n(.*?)```", markdown, re.DOTALL):
        content = match.group(1).strip()
        name_match = re.search(r"digraph\s+(\w+)", content)
        name = name_match.group(1) if name_match else f"graph_{len(blocks) + 1}"
        blocks.append({"name": name, "content": content})
    return blocks


def extract_graph_body(dot_content):
    # Extract just the body (nodes and edges) from a digraph
    match = re.search(r"digraph\s+\w+\s*\{(.*)\}", dot_content, re.DOTALL)
    if not match:
        return ""
    body = match.group(1)
    # Remove rankdir (we'll set it once at the top level)
    body = re.sub(r"^\s*rankdir\s*=\s*\w+\s*;?\s*$", "", body, flags=re.MULTILINE)
    return body.strip()


def combine_graphs(blocks, skill_name):
    bodies = []
    for i, block in enumerate(blocks):
        body = extract_graph_body(block["content"])
        # Wrap each subgraph in a cluster for visual grouping
        indented = "\n".join("  " + line for line in body.split("\n"))
        bodies.append(
            f"  subgraph cluster_{i} {{\n"
            f'    label="{block["name"]}";\n'
            f"    {indented}\n"
            f"  }}"
        )
    return (
        f"digraph {skill_name}_combined {{\n"
        f"  rankdir=TB;\n"
        f"  compound=true;\n"
        f"  newrank=true;\n"
        f"\n"
        f"{'\n\n'.join(bodies)}\n"
        f"}}"
    )


def render_to_svg(dot_content):
    try:
        result = subprocess.run(
            ["dot", "-Tsvg"],
            input=dot_content,
            capture_output=True,
            text=True,
            timeout=60,
        )
    except (OSError, subprocess.TimeoutExpired) as err:
        print(f"Error running dot: {err}", file=sys.stderr)
        return None
    if result.returncode != 0:
        print(f"Error running dot: dot exited with status {result.returncode}", file=sys.stderr)
        if result.stderr:
            print(result.stderr, file=sys.stderr)
        return None
    return result.stdout


def main():
    args = sys.argv[1:]
    combine = "--combine" in args
    skill_dir_arg = next((a for a in args if not a.startswith("--")), None)

    if not skill_dir_arg:
        print("Usage: render-graphs.py <skill-directory> [--combine]", file=sys.stderr)
        print("", file=sys.stderr)
        print("Options:", file=sys.stderr)
        print("  --combine    Combine all diagrams into one SVG", file=sys.stderr)
        print("", file=sys.stderr)
        print("Example:", file=sys.stderr)
        print("  ./render-graphs.py ../subagent-driven-development", file=sys.stderr)
        print("  ./render-graphs.py ../subagent-driven-development --combine", file=sys.stderr)
        sys.exit(1)

    skill_dir = Path(skill_dir_arg).resolve()
    skill_file = skill_dir / "SKILL.md"
    skill_name = skill_dir.name.replace("-", "_")

    if not skill_file.exists():
        print(f"Error: {skill_file} not found", file=sys.stderr)
        sys.exit(1)

    # Check if dot is available
    if shutil.which("dot") is None:
        print("Error: graphviz (dot) not found. Install with:", file=sys.stderr)
        print("  brew install graphviz    # macOS", file=sys.stderr)
        print("  apt install graphviz     # Linux", file=sys.stderr)
        sys.exit(1)

    markdown = skill_file.read_text(encoding="utf-8")
    blocks = extract_dot_blocks(markdown)

    if not blocks:
        print("No ```dot blocks found in", skill_file)
        sys.exit(0)

    print(f"Found {len(blocks)} diagram(s) in {skill_dir.name}/SKILL.md")

    output_dir = skill_dir / "diagrams"
    output_dir.mkdir(exist_ok=True)

    if combine:
        # Combine all graphs into one
        combined = combine_graphs(blocks, skill_name)
        svg = render_to_svg(combined)
        if svg:
            output_path = output_dir / f"{skill_name}_combined.svg"
            output_path.write_text(svg, encoding="utf-8")
            print(f"  Rendered: {skill_name}_combined.svg")

            # Also write the dot source for debugging
            dot_path = output_dir / f"{skill_name}_combined.dot"
            dot_path.write_text(combined, encoding="utf-8")
            print(f"  Source: {skill_name}_combined.dot")
        else:
            print("  Failed to render combined diagram", file=sys.stderr)
    else:
        # Render each separately
        for block in blocks:
            svg = render_to_svg(block["content"])
            if svg:
                output_path = output_dir / f"{block['name']}.svg"
                output_path.write_text(svg, encoding="utf-8")
                print(f"  Rendered: {block['name']}.svg")
            else:
                print(f"  Failed: {block['name']}", file=sys.stderr)

    print(f"\nOutput: {output_dir}/")


if __name__ == "__main__":
    main()
