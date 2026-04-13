# Obsidian Vault Structure

## Overview
This vault is organized into Work and Personal areas with daily notes and task management.

> [!info] Claude Code Integration
> This repository is configured to work with [Claude Code](https://claude.ai/claude-code) using [Obsidian Skills](https://github.com/kepano/obsidian-skills). These skills teach Claude how to work with Obsidian-specific features like Markdown syntax, JSON Canvas, and vault management. The skills are installed in the `.claude/` directory and enable Claude to help with note-taking, organization, and knowledge management tasks.

## Folder Structure

```
├── Work/
│   ├── Daily Notes/
│   ├── Projects/
│   ├── Meetings/
│   ├── Tasks/
│   └── Reference/
├── Personal/
│   ├── Daily Notes/
│   ├── Goals/
│   ├── Tasks/
│   └── Journal/
├── Learning/
│   ├── Dev/
│   │   └── MYSQL/
│   └── Cymraeg/
├── Templates/
│   ├── Work Daily Note.md
│   ├── Personal Daily Note.md
│   ├── Meeting Notes.md
│   ├── Project Template.md
│   └── Task List.md
└── Assets/
    └── (images, attachments)
```

## Quick Start

- **Home Page**: [[Home]] - Your vault dashboard
- **Work Hub**: [[Work/Work MOC]] - All work-related content
- **Personal Hub**: [[Personal/Personal MOC]] - Personal organization
- **SQL Learning**: [[Learning/Dev/MYSQL/Databases MOC]] - Database knowledge library
- **Welsh Learning**: [[Learning/Cymraeg/1- Cymraeg MOC]] - Learning Cymraeg

### Daily Notes

- **Work Daily Notes**: `Work/Daily Notes/YYYY-MM-DD.md`
- **Personal Daily Notes**: `Personal/Daily Notes/YYYY-MM-DD.md`
- **Quick Capture**: Add to today's daily note or create quick notes in Tasks folders

## Naming Conventions

- Daily notes: `YYYY-MM-DD.md` (e.g., 2026-04-06.md)
- Projects: Descriptive names (e.g., "Website Redesign.md")
- Meetings: "YYYY-MM-DD - Meeting Name.md"
- Tasks: Use tags `#work/task` or `#personal/task`

## Link Integrity

This vault includes automated link validation to prevent broken links.

### Manual Validation
```bash
python .scripts/validate-links.py
```

### Automatic Validation (Git Hook)
```bash
# Set up pre-commit hook
cp .scripts/pre-commit.sample .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

Once installed, links will be validated automatically before each commit.

## Best Practices

1. **Always use relative paths** from vault root in wikilinks
2. **Enable "Always update links"** in Obsidian settings (already configured)
3. **Run link validator** after reorganizing files
4. **Use MOCs** (Maps of Content) to navigate large topic areas
5. **Tag consistently** using the folder-based system: `#work/project`, `#personal/task`, etc.
