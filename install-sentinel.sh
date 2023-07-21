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
echo "Disabling Wi-Fi..."
sudo echo "dtoverlay=disable-wifi" | sudo tee -a /boot/config.txt >/dev/null
echo "Disabling Bluetooth..."
sudo echo "dtoverlay=disable-bt" | sudo tee -a /boot/config.txt >/dev/null

print_line

echo "Configuring Network..."

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

echo "Configuring IP Tables..."
./configure-iptables.sh

print_line

echo "Updating System..."
sudo apt-get update -y

print_line

echo "Upgrading System..."
sudo apt-get upgrade -y

echo "Upgrading Distribution..."
sudo apt dist-upgrade -y

echo "Installing Dependencies..."
sudo apt install git python3 python3-pip sqlite3 -y

echo "Cleaning Up..."
sudo apt-get autoremove -y
sudo apt-get autoclean -y
sudo apt-get clean -y

print_line

echo "Gathering Resources..."
mkdir $HOME/SENTINEL
cd $HOME/SENTINEL
git clone https://github.com/carlowisse/sentinel-core.git
git clone https://github.com/carlowisse/sentinel-unbound.git
git clone https://github.com/carlowisse/sentinel-alert.git
git clone https://github.com/carlowisse/sentinel-guard.git

echo "Preparing Scripts..."
cd $HOME/SENTINEL/sentinel-core/scripts/

sudo chmod +x ./checks.sh
sudo chmod +x ./load-lists.sh
sudo chmod +x ./apply-white-list.sh
sudo chmod +x ./apply-white-regex-list.sh
sudo chmod +x ./apply-regex-list.sh

sudo chmod +x ./configure-iptables.sh

print_line

echo "Preparing Pi-Hole..."
sudo mkdir /etc/pihole

print_line

echo "Creating Configuration File..."
sudo touch /etc/pihole/setupVars.conf

sudo tee /etc/pihole/setupVars.conf >/dev/null <<EOT
PIHOLE_INTERFACE=eth0
IPV4_ADDRESS=$PIIP/24
IPV6_ADDRESS=
QUERY_LOGGING=true
INSTALL_WEB_SERVER=true
INSTALL_WEB_INTERFACE=true
LIGHTTPD_ENABLED=true
CACHE_SIZE=10000
BLOCKING_ENABLED=true
WEBPASSWORD=
DNSMASQ_LISTENING=local
PIHOLE_DNS_1=127.0.0.1#5335
DNS_FQDN_REQUIRED=true
DNS_BOGUS_PRIV=true
DNSSEC=false
REV_SERVER=false
WEBTHEME=default-darker
WEBUIBOXEDLAYOUT=traditional
EOT

print_line

echo "Installing PiHole..."
curl -L https://install.pi-hole.net | bash /dev/stdin --unattended

print_line

echo "Set Admin Password"
pihole -a -p

echo "Cleaning PiHole..."
pihole --regex --nuke
pihole --white-regex --nuke
pihole -w --nuke
pihole -b --nuke
sudo sqlite3 /etc/pihole/gravity.db "DELETE FROM adlist"

print_line

echo "Initialising sentinelCore..."
./load-lists.sh

print_line

echo "Compiling Database..."
pihole -g

print_line

echo "Running Database Maintenance..."

print_line

echo "Unclean Database:"
sudo sqlite3 /etc/pihole/gravity.db "SELECT COUNT(*) FROM gravity;"

print_line

echo "Cleaning Database..."
sudo sqlite3 /etc/pihole/gravity.db "DELETE FROM gravity WHERE rowid NOT IN (SELECT rowid FROM gravity GROUP BY domain); VACUUM;"

print_line

echo "Cleaned Database:"
sudo sqlite3 /etc/pihole/gravity.db "SELECT COUNT(*) FROM gravity;"

echo "Running PiHole Maintenance..."
pihole restartdns reload
pihole restartdns
pihole flush

echo "Cleaning Up Installation..."
history -c

print_line

echo "Running Checks..."
./checks.sh

print_line

echo "Access Details:"
echo "sentinelCore: http://$PIIP/admin"
echo "sentinelAlert: http://$PIIP:5000"
echo "sentinelGuard: http://$PIIP:5001"
echo "sentinelUnbound: http://$PIIP:5002"

echo "We recommend you reboot your system now."
read -p "Would you like to reboot? (y/n): " reply

if [ "$reply" = "y" ] || [ "$reply" = "Y" ]; then
    echo "Rebooting Sentinel..."
    echo "INSTALLATION COMPLETE"
    sudo reboot
else
    echo "INSTALLATION COMPLETE"
    exit 1
fi
