#!/bin/bash
# sudo bash ./apply-all-list.sh

BLACK_FILE=../lists/black/all_domains.txt
WHITE_FILE=../lists/white/all_domains.txt

echo "Loading blacklists..."
while IFS= read -r LINE; do
    ADDRESS="$LINE"
    COMMENT=$(basename "$LINE")

    sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('$ADDRESS', 1, '$COMMENT');"
done <"$BLACK_FILE"

echo "Loading whitelists..."
while IFS= read -r LINE; do
    URL="$LINE"
    COMMENT=$(basename "$LINE")

    curl "$URL" | while IFS=$'\r' read -r DOMAIN || [[ -n $DOMAIN ]]; do
    pihole -w "$DOMAIN" --comment "$COMMENT" -nr
done <"$WHITE_FILE"


pihole -g
