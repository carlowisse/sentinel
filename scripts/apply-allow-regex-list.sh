#!/bin/bash
# chmod +x ./apply-allow-regex-list.sh
# ./apply-allow-regex-list.sh https://DOMAIN.HERE/PATH/TO/HOSTED/FILE

URL=$1
COMMENT=${URL##*/}

curl "$URL" | while IFS=$'\r' read -r DOMAIN || [[ -n $DOMAIN ]]; do
    pihole --white-regex "$DOMAIN" --comment "$COMMENT" -nr
done
