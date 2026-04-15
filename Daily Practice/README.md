---
type: readme
tags:
  - cymraeg
  - practice
  - setup
---

# Welsh Daily Practice Generator

This folder contains your daily Welsh practice notes, automatically generated with random exercises from your learning materials.

## 🚀 Quick Start

### Generate Today's Practice

Run this command from your vault root:

```bash
.scripts/dw-cymraeg-daily
```

Or if you've added `.scripts` to your PATH:

```bash
dw-cymraeg-daily
```

## 📋 What's Included in Each Practice Note

Every daily practice note includes:

### 🗣️ Pronunciation Practice
- Random Welsh sounds (ch, ll, dd, etc.)
- Examples with phonetics

### 💬 Phrases to Practice
- 5 random phrases from your Basic Phrases note
- Includes phonetics and English translations

### 🎯 Verb Conjugation
- Fill-in-the-blank exercises for "bod" (to be)
- Practice all forms: I am, you are, he/she is, we are, they are

### 🎨 Vocabulary Practice
- 6 random vocabulary items from Clothing & Accessories
- Practice gender, phonetics, and meanings

### 🔢 Numbers Practice
- Counting practice
- Age and quantity exercises

### ⏰ Time & Days
- Telling time practice
- Days of the week
- Time expressions

### ✍️ Translation Practice
- Welsh to English translations
- English to Welsh translations
- Real-world sentence patterns

### 🧠 Grammar Challenge
- **Mutations**: Practice soft, nasal, and aspirate mutations
- **Possessives**: My, your, his, her exercises

### 📝 Notes & Progress
- Space to record what you learned
- Track struggles and review words
- Build your personalized learning log

## 🎲 Randomization

The script pulls random content from:
- `Basic Phrases.md` - 5 random phrases
- `Clothing and Accessories.md` - 6 random vocabulary items
- Static exercises for grammar, numbers, time, and translations

Each day you'll get different phrases and vocabulary to keep practice fresh!

## 📅 Daily Workflow

1. **Morning**: Run `dw-cymraeg-daily` to generate today's practice
2. **Practice**: Spend 10-15 minutes working through the exercises
3. **Say it out loud**: Practice pronunciation using the phonetics
4. **Review answers**: Check the collapsible answer sections
5. **Take notes**: Record your progress at the bottom
6. **Track it**: Notes link to yesterday/tomorrow for easy navigation

## 🔗 Navigation

Each practice note includes automatic links to:
- **Previous day**: Yesterday's practice (if it exists)
- **Next day**: Tomorrow's practice (placeholder for future)
- **Back to MOC**: [[General/1- Cymraeg MOC|Cymraeg MOC]]

## 🛠️ Command Details

### Location
```
/mnt/c/Users/darre/Documents/dev/obsidian/.scripts/dw-cymraeg-daily.sh
```

### What It Does
1. Checks if today's practice already exists (won't overwrite)
2. Generates a new markdown file with today's date (YYYY-MM-DD.md)
3. Pulls random phrases and vocabulary from your learning notes
4. Creates interactive exercises with collapsible answers
5. Saves to `Learning/Cymraeg/Daily Practice/`

### File Naming
- Format: `YYYY-MM-DD.md`
- Example: `2026-04-13.md`

## 🎯 Tips for Effective Practice

1. **Consistency**: Run the command every day
2. **Speak out loud**: Don't just read - say the words!
3. **Cover answers**: Try to answer before revealing
4. **Review notes**: Go back to previous days to see progress
5. **Update learning notes**: Add new vocabulary to your dictionary as you learn
6. **Track patterns**: Notice what you struggle with consistently

## 🔄 Customization

The script pulls from these files - you can edit them to customize your practice:
- `Learning/Cymraeg/3- Basic Phrases.md`
- `Learning/Cymraeg/13- Clothing and Accessories.md`

Add more content to these files, and it will automatically appear in future practice sessions!

## 📊 Tracking Progress

Use the "Notes & Progress" section in each daily note to track:
- **What I learned today**: New concepts or words
- **What I struggled with**: Difficult areas to review
- **Words to review**: Vocabulary that needs more practice

Review these notes weekly to see your progress!

## 🆘 Troubleshooting

### "Practice note already exists"
The script won't overwrite existing notes. If you want to regenerate today's practice, delete the existing file first:
```bash
rm "Learning/Cymraeg/Daily Practice/$(date +%Y-%m-%d).md"
```

### Command not found
Make sure you're running from the vault root or the script is executable:
```bash
chmod +x .scripts/dw-cymraeg-daily.sh
```

### No random content appearing
Check that your source files exist:
- `Learning/Cymraeg/3- Basic Phrases.md`
- `Learning/Cymraeg/13- Clothing and Accessories.md`

## 🎉 Benefits

- **Spaced repetition**: Different content each day
- **Comprehensive**: Covers all aspects of Welsh
- **Quick**: 10-15 minutes per session
- **Trackable**: Built-in progress tracking
- **Consistent**: Daily habit building

---

**Back to:** [[General/1- Cymraeg MOC|Cymraeg MOC]]

*Pob lwc gyda dy ymarfer! (Good luck with your practice!)*
