#!/bin/bash

runasroot=1

sudo debconf-set-selections <<EOT
iptables-persistent iptables-persistent/autosave_v4 boolean true
iptables-persistent iptables-persistent/autosave_v6 boolean true
EOT

sudo apt install iptables-persistent -y

sudo iptables -F

sudo iptables -A INPUT -p tcp --dport 443 -j REJECT --reject-with tcp-reset
sudo iptables -A INPUT -p udp --dport 80 -j REJECT --reject-with icmp-port-unreachable
sudo iptables -A INPUT -p udp --dport 443 -j REJECT --reject-with icmp-port-unreachable

sudo ip6tables -A INPUT -p tcp --dport 443 -j REJECT --reject-with tcp-reset
sudo ip6tables -A INPUT -p udp --dport 80 -j REJECT --reject-with icmp6-port-unreachable
sudo ip6tables -A INPUT -p udp --dport 443 -j REJECT --reject-with icmp6-port-unreachable

sudo sh -c "iptables-save > /etc/iptables/rules.v4"
sudo sh -c "ip6tables-save > /etc/iptables/rules.v6"

exit