#!/bin/bash

# ask if user wants to purge all lists
echo "This will purge all lists from your Sentinel"
echo "Are you sure you want to continue? (y/n)"

read -r CONTINUE

if [[ $CONTINUE == "y" ]]; then
    echo "Purging..."

    pihole --regex --nuke
    pihole --white-regex --nuke
    pihole -w --nuke
    pihole -b --nuke

    sudo sqlite3 /etc/pihole/gravity.db "DELETE FROM adlist"
else
    echo "Sentinel standing down..."
    exit 1
fi
