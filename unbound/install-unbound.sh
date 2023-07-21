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

echo "Installing node and npm..."

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source ~/.bashrc
nvm install node

echo "Installing Unbound Frontend..."

cd $HOME/SENTINEL/sentinel-unbound
npm install
npm install -g pm2
pm2 start sentinel-unbound.js --name sentinel-unbound

echo "Enforcing PM2 to start on boot..."

startup_output=$(pm2 startup)
command=$(echo "$startup_output" | grep -o 'sudo env PATH=.*')
eval $command

exit
