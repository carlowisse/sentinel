#!/bin/bash
# sudo bash ./apply-all-list.sh

BLACK_FILE=../lists/black/all_domains.txt
WHITE_FILE=../lists/white/all_domains.txt

echo "Loading blacklists..."
while IFS= read -r BLACK_LINE; do
    BLACK_URL="$BLACK_LINE"
    BLACK_COMMENT=$(basename "$BLACK_LINE")

    sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('$BLACK_URL', 1, '$BLACK_COMMENT');"
done <"$BLACK_FILE"

echo "Loading whitelists..."
while IFS= read -r WHITE_LINE; do
    WHITE_URL="$WHITE_LINE"
    WHITE_COMMENT=$(basename "$WHITE_LINE")

    curl "$WHITE_URL" | while IFS=$'\r' read -r WHITE_DOMAIN || [[ -n $WHITE_DOMAIN ]]; do
        pihole -w "$WHITE_DOMAIN" --comment "$WHITE_COMMENT" -nr
    done
done <"$WHITE_FILE"

pihole -g
