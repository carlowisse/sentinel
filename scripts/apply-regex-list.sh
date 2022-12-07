#!/bin/bash
# chmod +x ./apply-regex-list.sh
# ./apply-regex-list.sh https://DOMAIN.HERE

URL=$1
COMMENT=${URL##*/}

curl "$URL" | while IFS=$'\r' read -r DOMAIN || [[ -n $DOMAIN ]]; do
    pihole --regex "$DOMAIN" --comment "$COMMENT" -nr
done
