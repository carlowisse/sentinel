#!/bin/bash

echo "Configuring Unbound..."

sudo systemctl disable systemd-resolved
sudo apt install unbound -y
sudo ln -s $HOME/SENTINEL/sentinel-unbound/sentinel-unbound.conf /etc/unbound/unbound.conf.d/
sudo systemctl disable unbound-resolvconf.service
sudo systemctl stop unbound-resolvconf.service
sudo unbound-anchor
sudo rm /etc/unbound/unbound.conf.d/resolvconf_resolvers.conf
sudo sed -i -n '/unbound/!p' /etc/resolvconf.conf
sudo systemctl restart dhcpcd
sudo systemctl restart unbound
sudo echo "edns-packet-max=1232" | sudo tee -a /etc/dnsmasq.d/99-edns.conf


exit
