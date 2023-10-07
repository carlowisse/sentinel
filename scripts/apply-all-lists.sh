#!/bin/bash
# sudo bash ./apply-all-list.sh

FILE=../lists/black/all_domains.txt

while IFS= read -r LINE; do
    ADDRESS="$LINE"
    COMMENT=$(basename "$LINE")

    sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('$ADDRESS', 1, '$COMMENT');"
done <"$FILE"

pihole -g
