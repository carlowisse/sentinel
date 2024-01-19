#!/bin/bash
# sudo bash ./apply-black-list.sh /path/to/file/that/contains/blacklists.txt

BLACK_FILE=$1
BLACK_COUNT=$(wc -l <"$BLACK_FILE")
if [[ $BLACK_COUNT -eq 0 ]]; then
    BLACK_COUNT=1
fi

echo "APPLYING $BLACK_COUNT BLACKLISTS..."

while IFS= read -r BLACK_LINE || [[ -n "$BLACK_LINE" ]]; do
    BLACK_URL="$BLACK_LINE"
    BLACK_COMMENT=$(basename "$BLACK_LINE")

    sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('$BLACK_URL', 1, '$BLACK_COMMENT');"
done <"$BLACK_FILE"

pihole -g
