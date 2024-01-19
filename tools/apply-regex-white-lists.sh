#!/bin/bash
# sudo bash ./apply-regex-white-lists.sh /path/to/file/that/contains/regex-white-links.txt

REGEX_FILE=$1

# READ TXT FILE OF REMOTE LINKS LINE BY LINE
for REGEX_LINK in $(cat "$REGEX_FILE"); do
    # CREATE COMMENT FROM FILENAME
    REGEX_COMMENT=$(basename "$REGEX_LINK")

    # DOWNLOAD REMOTE FILE AND READ IT LINE BY LINE
    IFS=$'\n'

    for REGEX_LINE in $(curl -s "$REGEX_LINK"); do
        # ignore the line if it starts with #
        [[ "$REGEX_LINE" =~ ^#.*$ ]] && continue

        pihole --white-regex "$REGEX_LINE" --comment "$REGEX_COMMENT"
    done
done
