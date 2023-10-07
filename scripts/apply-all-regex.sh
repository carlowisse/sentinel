#!/bin/bash
# bash ./apply-all-regex.sh FILE COMMENT

FILE=$1
COMMENT=$2

while IFS= read -r URL; do
    # Skip lines starting with #
    if [[ $URL == \#* ]]; then
        continue
    fi

    curl "$URL" | while IFS=$'\r' read -r DOMAIN || [[ -n $DOMAIN ]]; do
        pihole --regex "$DOMAIN" --comment "$COMMENT" -nr
    done
done <"$FILE"
