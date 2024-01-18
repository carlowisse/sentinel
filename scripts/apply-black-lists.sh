#!/bin/bash
# sudo bash ./apply-all-list.sh

# get argument from command line as variable

BLACK_FILE=$1
BLACK_COUNT=$(wc -l <"$BLACK_FILE")

echo "APPLYING $BLACK_COUNT BLACKLISTS..."

while IFS= read -r BLACK_LINE; do
    BLACK_URL="$BLACK_LINE"
    BLACK_COMMENT=$(basename "$BLACK_LINE")

    sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('$BLACK_URL', 1, '$BLACK_COMMENT');"
done <"$BLACK_FILE"

pihole -g
