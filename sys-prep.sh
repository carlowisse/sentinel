#!/bin/bash

print_line() {
    echo " "
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    echo " "
}

read -p "Please Set Your Time Zone (e.g. Australia/Sydney):" TIMEZONE
sudo timedatectl set-timezone $TIMEZONE

print_line

date

print_line

echo "Securing system..."
sudo touch /home/access/.hushlogin

print_line

echo "Disabling Wi-Fi.."
sudo echo "dtoverlay=disable-wifi" | sudo tee -a /boot/config.txt >/dev/null

print_line

echo "Disabling Bluetooth..."
sudo echo "dtoverlay=disable-bt" | sudo tee -a /boot/config.txt >/dev/null

print_line

echo "Gathering Required Information..."
PIIP=$(hostname -I | tr -d ' ')
ROUTERIP=$(ip route show | grep -i 'default via' | awk '{print $3 }')

print_line

echo "Configuring Static IP..."
sudo tee -a /etc/dhcpcd.conf >/dev/null <<EOT

interface eth0
static ip_address=$PIIP/24
static routers=$ROUTERIP
static domain_name_servers=$ROUTERIP
EOT

print_line

echo "Updating System..."
sudo apt-get update -y

print_line

echo "Upgrading System..."
sudo apt-get upgrade -y

echo "Upgrading Distribution..."
sudo apt dist-upgrade -y

echo "Cleaning Up..."
sudo apt-get autoremove -y
sudo apt-get autoclean -y
sudo apt-get clean -y

print_line

echo "Rebooting SENTINEL"
sudo reboot
