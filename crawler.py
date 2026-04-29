import os
import re

DOCS_DIR = 'docs'
all_files = []
for root, _, files in os.walk(DOCS_DIR):
    for f in files:
        if f.endswith('.md') or f.endswith('.html'):
            all_files.append(os.path.join(root, f))

# Find all relative links
links = []
link_pattern = re.compile(r'\[([^\]]+)\]\(([^)]+)\)')
for f in all_files:
    with open(f, 'r') as file:
        content = file.read()
        matches = link_pattern.findall(content)
        for match in matches:
            link = match[1]
            if not link.startswith('http') and not link.startswith('#') and not link.startswith('mailto:') and not link.startswith('/') and not link.startswith('url') and not link.startswith('repo-url') and not 'ep.url' in link:
                links.append((f, link))

missing = []
for f, link in links:
    # Resolve link relative to file
    link_path = link.split('#')[0]
    if not link_path:
        continue
    target = os.path.normpath(os.path.join(os.path.dirname(f), link_path))
    if not os.path.exists(target):
        missing.append((f, link, target))

print(f"Found {len(missing)} 404 links")
for f, link, target in missing:
    print(f"404 link in {f}: {link} -> {target}")
