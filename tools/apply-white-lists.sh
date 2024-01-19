#!/bin/bash
# sudo bash ./apply-white-list.sh /path/to/file/that/contains/whitelists.txt

WHITE_FILE=$1

# READ TXT FILE OF REMOTE LINKS LINE BY LINE
for WHITE_LINK in $(cat "$WHITE_FILE"); do
    # CREATE COMMENT FROM FILENAME
    WHITE_COMMENT=$(basename "$WHITE_LINK")

    # DOWNLOAD REMOTE FILE AND READ IT LINE BY LINE
    IFS=$'\n'

    for WHITE_LINE in $(curl -s "$WHITE_LINK"); do
        # ignore the line if it starts with #
        [[ "$WHITE_LINE" =~ ^#.*$ ]] && continue

        pihole -w "$WHITE_LINE" --comment "$WHITE_COMMENT"
    done
done
