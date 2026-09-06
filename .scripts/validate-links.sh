#!/bin/bash

# Obsidian Vault Link Validator
# Checks for broken wikilinks in the vault

VAULT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BROKEN_LINKS=()

echo "🔍 Validating links in Obsidian vault..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Find all markdown files and extract wikilinks
while IFS= read -r file; do
    # Skip .git and .agents directories
    if [[ "$file" == *"/.git/"* ]] || [[ "$file" == *"/.agents/"* ]]; then
        continue
    fi

    # Extract wikilinks from the file
    grep -o '\[\[[^]]*\]\]' "$file" 2>/dev/null | while read -r link; do
        # Remove [[ and ]]
        link_path="${link#\[\[}"
        link_path="${link_path%\]\]}"

        # Remove any anchor/heading references
        link_path="${link_path%%#*}"

        # Skip empty links
        if [[ -z "$link_path" ]]; then
            continue
        fi

        # Check if it's an absolute path or relative
        if [[ "$link_path" == /* ]]; then
            target_file="$VAULT_PATH/$link_path.md"
        else
            # Try multiple possible locations
            possible_paths=(
                "$VAULT_PATH/$link_path.md"
                "$VAULT_PATH/$link_path"
            )

            found=false
            for possible_path in "${possible_paths[@]}"; do
                if [[ -f "$possible_path" ]]; then
                    found=true
                    break
                fi
            done

            if [[ "$found" == false ]]; then
                echo "❌ Broken link in $(basename "$file"): [[$link_path]]"
                BROKEN_LINKS+=("$file: [[$link_path]]")
            fi
        fi
    done
done < <(find "$VAULT_PATH" -name "*.md" -type f)

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [[ ${#BROKEN_LINKS[@]} -eq 0 ]]; then
    echo "✅ All links validated successfully!"
    exit 0
else
    echo "⚠️  Found ${#BROKEN_LINKS[@]} broken link(s)"
    echo ""
    echo "Run this script regularly to maintain link integrity."
    exit 1
fi
