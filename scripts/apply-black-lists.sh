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

pihole -g
