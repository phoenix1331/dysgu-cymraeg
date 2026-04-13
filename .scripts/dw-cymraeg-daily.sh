#!/bin/bash

# Welsh Daily Practice Generator
# Generates a daily practice note with random exercises from Welsh learning materials

# Get today's date
DATE=$(date +%Y-%m-%d)
DAY_NAME=$(date +%A)

# Vault root directory
VAULT_ROOT="/mnt/c/Users/darre/Documents/dev/obsidian"
CYMRAEG_DIR="$VAULT_ROOT/Learning/Cymraeg"
PRACTICE_DIR="$CYMRAEG_DIR/Daily Practice"
OUTPUT_FILE="$PRACTICE_DIR/$DATE.md"

# Check if today's practice already exists
if [ -f "$OUTPUT_FILE" ]; then
    echo "Practice note for today ($DATE) already exists!"
    echo "Location: $OUTPUT_FILE"
    exit 0
fi

# Calculate previous and next dates
PREV_DATE=$(date -d "$DATE - 1 day" +%Y-%m-%d 2>/dev/null || date -v-1d -j -f "%Y-%m-%d" "$DATE" +%Y-%m-%d 2>/dev/null || echo "")
NEXT_DATE=$(date -d "$DATE + 1 day" +%Y-%m-%d 2>/dev/null || date -v+1d -j -f "%Y-%m-%d" "$DATE" +%Y-%m-%d 2>/dev/null || echo "")

# Function to get random table rows
get_random_table_rows() {
    local file="$1"
    local count="$2"

    if [ -f "$file" ]; then
        # Get table rows (lines with |) excluding header separators
        grep "^|" "$file" | grep -v "^|---" | grep -v "^| English" | grep -v "^| Person" | grep -v "^| Welsh" | shuf -n "$count" 2>/dev/null || echo ""
    fi
}

# Get random content
PHRASES_FILE="$CYMRAEG_DIR/Basic Phrases.md"
PHRASES=$(get_random_table_rows "$PHRASES_FILE" 5)
if [ -n "$PHRASES" ]; then
    PHRASES_CONTENT="| Welsh | Phonetic | English |
|-------|----------|---------|
$PHRASES"
else
    PHRASES_CONTENT="Review: [[Learning/Cymraeg/Basic Phrases]]"
fi

VOCAB_FILE="$CYMRAEG_DIR/Clothing and Accessories.md"
VOCAB=$(get_random_table_rows "$VOCAB_FILE" 6)
if [ -n "$VOCAB" ]; then
    VOCAB_CONTENT="| Welsh | Phonetic | English | Gender |
|-------|----------|---------|--------|
$VOCAB"
else
    VOCAB_CONTENT="Review: [[Learning/Cymraeg/Clothing and Accessories]]"
fi

# Create the daily practice note
cat > "$OUTPUT_FILE" << EOF
---
type: practice
date: $DATE
tags:
  - cymraeg
  - practice
  - daily
---

# Welsh Daily Practice - $DATE

> [!tip] Pob lwc heddiw! (Good luck today!)
> Take 10-15 minutes to practice. Say each phrase out loud!

## 📅 Today's Focus

**Day:** $DAY_NAME

---

## 🗣️ Pronunciation Practice

Practice these Welsh sounds:

| Welsh | Sound | Example | Phonetic |
|-------|-------|---------|----------|
| ch | Like "loch" | coch (red) | KOKH |
| ll | Breathy "hl" | llyfr (book) | HLUVR |
| dd | Like "th" in "this" | dydd (day) | DEETH |

---

## 💬 Phrases to Practice

$PHRASES_CONTENT

---

## 🎯 Verb Conjugation Practice

### "Bod" (To Be) - Fill in the Blanks

Complete these sentences:

1. ___ i'n dysgu Cymraeg (I am learning Welsh)
2. Mae ___'n mynd (She is going)
3. ___ ni'n hapus (We are happy)
4. Ydy ___'n dod? (Is he coming?)
5. ___ chi'n siarad Cymraeg? (Do you speak Welsh - formal)

<details>
<summary>Answers</summary>

1. **Dw** i'n dysgu Cymraeg
2. Mae **hi**'n mynd
3. **Dyn** ni'n hapus
4. Ydy **e**'n dod?
5. **Dych** chi'n siarad Cymraeg?

</details>

---

## 🎨 Vocabulary Practice

### Colors & Clothing

$VOCAB_CONTENT

---

## 🔢 Numbers Practice

Practice counting:

| Welsh | English |
|-------|---------|
| un | 1 |
| dau/dwy | 2 |
| tri/tair | 3 |
| pedwar/pedair | 4 |
| pump | 5 |

**Challenge:** How do you say:
- "I am 25 years old" = Dw i'n ___ ___ ___ oed
- "Five apples" = ___ afal

<details>
<summary>Answers</summary>

- Dw i'n **dau ddeg pump** oed
- **Pump** afal (nouns stay singular after numbers!)

</details>

---

## ⏰ Time & Days

**What time is it?**

Practice: Faint o'r gloch yw hi?

- 3:00 = Tri o'r gloch
- 7:30 = Hanner awr wedi saith
- 2:15 = Chwarter wedi dau

**Days:** Llun, Mawrth, Mercher, Iau, Gwener, Sadwrn, Sul

**Today:** Translate "I'm going on Friday" = _______________

<details>
<summary>Answer</summary>

Dw i'n mynd **dydd Gwener** / **ar ddydd Gwener**

</details>

---

## ✍️ Translation Practice

### Welsh to English

Translate these to English:

1. Dw i'n hoffi coffi
2. Mae hi'n dysgu Cymraeg
3. Maen nhw'n byw yng Nghymru
4. Dyn ni'n mynd i'r dre

<details>
<summary>Answers</summary>

1. I like coffee
2. She is learning Welsh
3. They live in Wales
4. We are going to town

</details>

### English to Welsh

Translate these to Welsh:

1. I am happy
2. Are you going? (informal)
3. He is working
4. We don't understand

<details>
<summary>Answers</summary>

1. Dw i'n hapus
2. Wyt ti'n mynd?
3. Mae e'n gweithio
4. Dyn ni ddim yn deall

</details>

---

## 🧠 Grammar Challenge

### Mutations

What happens to these words?

| Context | Original | Mutated | Type |
|---------|----------|---------|------|
| fy (my) | car | fy n___ar | Nasal |
| dy (your) | pen | dy ___en | Soft |
| ei (her) | tad | ei ___ad | Aspirate |
| after feminine | coch | côt ___och | Soft |

<details>
<summary>Answers</summary>

- fy **nghar** (nasal: c → ngh)
- dy **ben** (soft: p → b)
- ei **thad** (aspirate: t → th)
- côt **goch** (soft: c → g)

</details>

### Possessives

Fill in the blanks:

1. ___ nghar (my car)
2. ___ gar (your car - informal)
3. ___ gar (his car)
4. ___ char (her car)

<details>
<summary>Answers</summary>

1. **fy** nghar
2. **dy** gar
3. **ei** gar
4. **ei** char

Remember: Both his/her use "ei" but different mutations!

</details>

---

## 📝 Notes & Progress

**What I learned today:**
-

**What I struggled with:**
-

**Words to review:**
-

---

**Previous:** [[Learning/Cymraeg/Daily Practice/$PREV_DATE|Yesterday's Practice]]
**Next:** [[Learning/Cymraeg/Daily Practice/$NEXT_DATE|Tomorrow's Practice]]
**Back to:** [[Learning/Cymraeg/Cymraeg MOC|Cymraeg MOC]]

---

*Gwaith da! (Good work!)*
EOF

echo "✅ Daily Welsh practice note created!"
echo "📝 Location: $OUTPUT_FILE"
echo ""
echo "Open in Obsidian and start practicing!"
echo "Pob lwc! (Good luck!)"
