#!/bin/bash

sudo systemctl stop unbound

sudo systemctl disable unbound

sudo apt remove libunbound8 -y
sudo apt remove unbound-anchor -y
sudo apt remove unbound-resolvconf -y
sudo apt remove unbound -y

sudo rm -rf /var/lib/unbound

sudo rm -rf etc/unbound

sudo systemctl restart dhcpcd

pihole restartdns
pihole flush
