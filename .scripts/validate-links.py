#!/usr/bin/env python3
"""
Obsidian Vault Link Validator
Checks for broken wikilinks in the vault
"""

import os
import re
from pathlib import Path

VAULT_PATH = Path(__file__).parent.parent
BROKEN_LINKS = []

def find_md_files(path):
    """Find all markdown files in the vault, excluding .git and .agents"""
    for root, dirs, files in os.walk(path):
        # Skip .git and .agents directories
        dirs[:] = [d for d in dirs if d not in ['.git', '.agents', '.obsidian']]

        for file in files:
            if file.endswith('.md'):
                yield Path(root) / file

def extract_wikilinks(content):
    """Extract all wikilinks from markdown content"""
    pattern = r'\[\[([^\]]+)\]\]'
    links = re.findall(pattern, content)

    # Remove display text (everything after |)
    cleaned_links = []
    for link in links:
        if '|' in link:
            link = link.split('|')[0].strip()
        cleaned_links.append(link)

    return cleaned_links

def resolve_link(link_text, vault_path):
    """
    Try to resolve a wikilink to an actual file.
    Returns True if the file exists, False otherwise.
    """
    # Remove anchor/heading references
    link_path = link_text.split('#')[0].strip()

    if not link_path:
        return True  # Empty links are template placeholders

    # Skip template variables
    if '{{' in link_path or '}}' in link_path:
        return True

    # Skip example/placeholder links
    if link_path.startswith('path/to/') or link_path == 'File':
        return True

    # Try multiple possible paths
    possible_paths = [
        vault_path / f"{link_path}.md",
        vault_path / link_path,
    ]

    # Also try with different case sensitivity (Obsidian is case-insensitive on some systems)
    for possible in possible_paths:
        if possible.exists():
            return True

    return False

def main():
    print("🔍 Validating links in Obsidian vault...")
    print("━" * 50)
    print()

    for md_file in find_md_files(VAULT_PATH):
        try:
            content = md_file.read_text(encoding='utf-8')
            links = extract_wikilinks(content)

            for link in links:
                if not resolve_link(link, VAULT_PATH):
                    rel_path = md_file.relative_to(VAULT_PATH)
                    print(f"❌ Broken link in {rel_path}: [[{link}]]")
                    BROKEN_LINKS.append((rel_path, link))
        except Exception as e:
            print(f"⚠️  Error reading {md_file}: {e}")

    print()
    print("━" * 50)

    if not BROKEN_LINKS:
        print("✅ All links validated successfully!")
        return 0
    else:
        print(f"⚠️  Found {len(BROKEN_LINKS)} broken link(s)")
        print()
        print("To fix broken links, ensure the referenced files exist")
        print("or update the links to point to the correct location.")
        return 1

if __name__ == "__main__":
    exit(main())
