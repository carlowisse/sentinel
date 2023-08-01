#!/bin/bash

### BASE REPO URL ###
base_url="https://raw.githubusercontent.com/carlowisse/sentinel-lists/main/lists"

### VAR URL ###
VARS_URL="https://raw.githubusercontent.com/carlowisse/sentinel-lists/main/scripts/vars"

### DOMAINS ###
curl -sSL "${VARS_URL}/domains.sh" -o domains.sh && source ./domains.sh

for CATEGORY in ads adult agencies amp analytics badware compilation crypto drugs misc native piracy services social trackers; do
    COUNT=${!CATEGORY}

    if [[ $COUNT -eq 1 ]]; then
        FILE_URL="${base_url}/domains/${CATEGORY}/${CATEGORY}.txt"
        sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$FILE_URL', 1, '$CATEGORY');"
    else
        for ((i = 0; i < COUNT; i++)); do
            if [[ $i -lt 10 ]]; then
                FILE_URL="${base_url}/domains/${CATEGORY}/${CATEGORY}_0${i}.txt"
            else
                FILE_URL="${base_url}/domains/${CATEGORY}/${CATEGORY}_${i}.txt"
            fi

            sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$FILE_URL', 1, '$CATEGORY');"
        done
    fi
done

### ADBLOCKS ###
curl -sSL "${VARS_URL}/adblocks.sh" -o adblocks.sh && source ./adblocks.sh

for CATEGORY in ads badware compilation misc native piracy services; do
    COUNT=${!CATEGORY}

    if [[ $COUNT -eq 1 ]]; then
        FILE_URL="${base_url}/adblocks/${CATEGORY}/${CATEGORY}.txt"
        sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$FILE_URL', 1, '$CATEGORY');"
    else
        for ((i = 0; i < COUNT; i++)); do
            if [[ $i -lt 10 ]]; then
                FILE_URL="${base_url}/adblocks/${CATEGORY}/${CATEGORY}_0${i}.txt"
            else
                FILE_URL="${base_url}/adblocks/${CATEGORY}/${CATEGORY}_${i}.txt"
            fi

            sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$FILE_URL', 1, '$CATEGORY');"
        done
    fi
done

### REGEXES ###
curl -sSL "${VARS_URL}/regexes.sh" -o regexes.sh && source ./regexes.sh

for CATEGORY in ads adult amp analytics compilation crypto malware misc native services social trackers; do
    COUNT=${!CATEGORY}

    if [[ $COUNT -eq 1 ]]; then
        FILE_URL="${base_url}/regexes/${CATEGORY}/${CATEGORY}.txt"
        ./apply-regex-list.sh $FILE_URL $CATEGORY
    else
        for ((i = 0; i < COUNT; i++)); do
            if [[ $i -lt 10 ]]; then
                FILE_URL="${base_url}/regexes/${CATEGORY}/${CATEGORY}_0${i}.txt"
            else
                FILE_URL="${base_url}/regexes/${CATEGORY}/${CATEGORY}_${i}.txt"
            fi

            ./apply-black-regex-list.sh $FILE_URL $CATEGORY
        done
    fi
done
