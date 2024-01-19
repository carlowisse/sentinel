#!/bin/bash
# sudo bash ./apply-black-list.sh /path/to/file/that/contains/blacklists.txt

BLACK_FILE=$1

for BLACK_LINE in $(cat "$BLACK_FILE"); do
    BLACK_URL="$BLACK_LINE"
    BLACK_COMMENT=$(basename "$BLACK_LINE")

    sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('$BLACK_URL', 1, '$BLACK_COMMENT');"
done

pihole -g
