# Dysgu Cymraeg — Welsh Learning Vault

An open, self-study Welsh (Cymraeg) course packaged as an [Obsidian](https://obsidian.md) vault. It takes a complete beginner (CEFR A1) to conversational competency (B1) over roughly 12 weeks, with grammar, thematic vocabulary, conversation practice, reading texts, songs, weekly assessments, and an automated daily-practice generator.

Everything is plain Markdown, so it works in any editor — but it's designed for Obsidian, where the internal links, folder notes, and callouts come to life.

---

## Getting started with Obsidian

1. **Install Obsidian** — free from [obsidian.md](https://obsidian.md) (Windows, macOS, Linux, iOS, Android).
2. **Get the vault:**
   - Download this repository as a ZIP and extract it, **or**
   - `git clone https://github.com/<your-username>/<this-repo>.git dysgu-cymraeg`
3. **Open it in Obsidian:** *Open* → *Open folder as vault* → select the folder you just downloaded.
4. Obsidian will ask you to trust the vault (it contains community plugin files). Click **Trust author and enable plugins** if you want the Git and Calendar plugins, or skip it — the learning content works either way.
5. **Start here:** open `General/1- Cymraeg MOC.md`. It's the map of content and links to everything else.

If you're a complete beginner, read `General/2- Phonetics and Pronunciation.md` first, then follow the 12-week path in `Weekly Practice/README - 12 Week Curriculum.md`.

---

## What's in the vault

```
General/            Core grammar and reference (17 modules) — start at "1- Cymraeg MOC.md"
Vocabulary/         Thematic word lists with gender markers and pronunciation
Discussions/        15 conversation topics, every line as Welsh | Phonetics | English
Reading Practice/   Graded reading texts (A1, A2, B1) with comprehension questions
Songs/              5 traditional and modern Welsh songs with full phonetics
Weekly Practice/    12-week curriculum guide and one assessment per week
Daily Practice/     Generated daily exercise notes (see the script below)
.scripts/           Daily-practice generator and a wikilink validator
.agents/            Reference skills for editing the vault with AI tooling (optional)
```

Every Welsh word or phrase in the course includes a phonetic pronunciation guide, and grammar modules use collapsible sections for practice answers.

---

## Daily practice generator

`.scripts/dw-cymraeg-daily.sh` creates a dated practice note in `Daily Practice/` with randomised exercises pulled from the vault's own content — pronunciation drills, phrase practice, verb conjugation, vocabulary, translation, and mutation challenges.

Run it from the vault root:

```bash
.scripts/dw-cymraeg-daily
```

It auto-detects the vault location, so it works wherever you cloned the repo. Add `.scripts/` to your `PATH` if you'd like to call `dw-cymraeg-daily` from anywhere. It won't overwrite a note that already exists for today.

See `Daily Practice/README.md` for details and customisation.

---

## Checking internal links

If you reorganise files, validate the wikilinks:

```bash
python .scripts/validate-links.py      # recommended
bash   .scripts/validate-links.sh      # no Python needed
```

Exit code `0` means all links resolve; `1` means some are broken (they're listed).

---

## Suggested routine (30–60 minutes/day)

**30 minutes:** daily practice note (10 min) → one grammar module or vocabulary set (15 min) → review notes (5 min).

**60 minutes:** daily practice note (15 min) → grammar or vocabulary (20 min) → a conversation dialogue, read aloud (20 min) → reflection (5 min).

Consistency beats intensity — 30 minutes every day outperforms one long weekly session.

---

## Contributing

Corrections and additions are welcome. Keep the existing format: phonetics for every Welsh word, gender markers (`m`/`f`) for nouns, and wikilinks (not bare paths) for cross-references. Run the link validator before opening a pull request.

---

## Licence

The learning content is provided as-is for personal study. Welsh song lyrics are traditional/public-domain or quoted for educational use.

**Pob lwc gyda'ch Cymraeg!** (Good luck with your Welsh!) 🏴󠁧󠁢󠁷󠁬󠁳󠁿
