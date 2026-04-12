# Vault Maintenance Scripts

This directory contains scripts to help maintain the quality and consistency of your Obsidian vault.

## Link Validator

Validates all wikilinks in the vault to ensure they point to existing files.

### Usage

**Python version (recommended):**
```bash
python .scripts/validate-links.py
```

**Bash version:**
```bash
bash .scripts/validate-links.sh
```

### When to Run

- Before committing changes to git
- After reorganizing files or folders
- Regularly (e.g., weekly) to catch any issues

### Automated Validation

To automatically validate links on every commit, set up a git pre-commit hook:

```bash
# From vault root
cp .scripts/pre-commit.sample .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

## Exit Codes

- `0`: All links valid
- `1`: Broken links found

## What Gets Checked

- All markdown files (`.md`) in the vault
- Wikilink format: `[[path/to/file]]`
- Excludes: `.git/`, `.agents/`, `.obsidian/` directories

## Common Issues

### Case Sensitivity
Obsidian is case-insensitive on some systems but case-sensitive on others. The validator checks exact paths.

### Relative vs Absolute Links
Use relative paths from vault root. Example:
- ✅ `[[Learning/Dev/MYSQL/SQL - Fundamentals]]`
- ❌ `[[learning/dev/mysql/SQL - Fundamentals]]` (wrong case)

### Anchor Links
Links with anchors/headings are supported:
- `[[File#Heading]]` - checks if `File.md` exists, ignores heading
