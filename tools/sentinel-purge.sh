#!/bin/bash

echo "This will purge all lists from your sentinel"
read -p "Are you sure? (y/n): " reply

if [ "$reply" = "y" ] || [ "$reply" = "Y" ]; then
    echo "sentinelPurge initiated..."

    pihole --regex --nuke
    pihole --white-regex --nuke
    pihole -w --nuke
    pihole -b --nuke

    sudo sqlite3 /etc/pihole/gravity.db "DELETE FROM adlist"

    pihole -f
    pihole arpflush
    pihole restartdns

    pihole -g

    sudo service pihole-FTL stop

    sudo rm /etc/pihole/pihole-FTL.db

    sudo service pihole-FTL start

    echo ""
    echo "Sentinel purged."
else
    echo "sentinelPurge standing down..."
    exit 1
fi
