#!/bin/bash

# ask if user wants to purge all lists
echo "This will purge all lists from your Sentinel"

read -p "Are you sure? (y/n): " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Purging..."

    pihole --regex --nuke
    pihole --white-regex --nuke
    pihole -w --nuke
    pihole -b --nuke

    sudo sqlite3 /etc/pihole/gravity.db "DELETE FROM adlist"
    echo "Sentinel purged."
else
    echo "Sentinel standing down..."
    exit 1
fi
