#!/bin/bash
# chmod +x ./apply-allow-list.sh
# ./apply-allow-list.sh https://DOMAIN.HERE/PATH/TO/HOSTED/FILE

URL=$1
COMMENT=${URL##*/}

curl "$URL" | while IFS=$'\r' read -r DOMAIN || [[ -n $DOMAIN ]]; do
    pihole -w "$DOMAIN" --comment "$COMMENT" -nr
done
