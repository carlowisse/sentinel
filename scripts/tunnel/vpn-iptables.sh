#!/bin/bash

sudo iptables -F

sudo iptables -A INPUT -p tcp --dport 443 -j REJECT --reject-with tcp-reset
sudo iptables -A INPUT -p udp --dport 80 -j REJECT --reject-with icmp-port-unreachable
sudo iptables -A INPUT -p udp --dport 443 -j REJECT --reject-with icmp-port-unreachable

sudo iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

sudo iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE

sudo iptables -A FORWARD -i tun0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i eth0 -o tun0 -j ACCEPT

sudo iptables -A OUTPUT -o tun0 -m comment --comment "vpn" -j ACCEPT
sudo iptables -A OUTPUT -o eth0 -p icmp -m comment --comment "icmp" -j ACCEPT
sudo iptables -A OUTPUT -d $1 -o eth0 -m comment --comment "lan" -j ACCEPT
sudo iptables -A OUTPUT -o eth0 -p udp -m udp --dport 1194 -m comment --comment "allow vpn traffic" -j ACCEPT
sudo iptables -A OUTPUT -o eth0 -p udp -m udp --dport 123 -m comment --comment "ntp" -j ACCEPT
sudo iptables -A OUTPUT -p tcp -d $2 --dport 443 -m comment --comment "nordvpn IP" -j ACCEPT
sudo iptables -A OUTPUT -p tcp -d $3 --dport 443 -m comment --comment "nordvpn IP" -j ACCEPT
sudo iptables -A OUTPUT -o eth0 -j DROP

sudo iptables -I FORWARD -i eth0 ! -o tun0 -j DROP

sudo iptables-save | sudo tee /etc/iptables/rules.v4