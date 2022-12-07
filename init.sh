#!/bin/bash
runasroot=1

print_line() {
    echo " "
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    echo " "
}

echo "Preparing Scripts..."
cd /home/$SUDO_USER/sentinel/scripts/

sudo chmod +x ./checks.sh
sudo chmod +x ./deny-lists.sh
sudo chmod +x ./allow-lists.sh
sudo chmod +x ./apply-allow-list.sh
sudo chmod +x ./apply-allow-regex-list.sh
sudo chmod +x ./apply-regex-list.sh

sudo chmod +x ./configure-iptables.sh

sudo chmod +x ./unbound/install-unbound.sh

sudo chmod +x ./view/install-view.sh

print_line

echo "Installing Dependencies..."
sudo apt install python3 python3-pip sqlite3 -y

print_line

echo "Gathering Required Information..."
PIIP=$(hostname -I | tr -d ' ')
ROUTERIP=$(ip route show | grep -i 'default via' | awk '{print $3 }')

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
WEBTHEME=default-dark
WEBUIBOXEDLAYOUT=traditional
EOT

print_line

echo "Installing Pi-Hole..."
curl -L https://install.pi-hole.net | bash /dev/stdin --unattended

print_line

echo "Initialising SentinelCore..."
echo " "

print_line

pihole --regex --nuke
pihole --white-regex --nuke
pihole -w --nuke
pihole -b --nuke

sudo sqlite3 /etc/pihole/gravity.db "DELETE FROM adlist"
echo "Database has been purged"

print_line

# Deny List
echo "Running Sentinel Collection..."
echo "Preparing Deny List..."
./deny-lists.sh

print_line

# Allow List
echo "Preparing Allow List..."
./allow-lists.sh

print_line

echo "Configuring IP Tables..."
./configure-iptables.sh

print_line

echo "Initialising SentinelUnbound..."
echo " "

echo "Installing Unbound..."
./unbound/install-unbound.sh

print_line

echo "Change Your Admin Password"
pihole -a -p

print_line

echo "Compiling Database..."
pihole -g

print_line

echo "Cleaning Up..."

print_line

echo "Unclean Database:"
sudo sqlite3 /etc/pihole/gravity.db "SELECT COUNT(*) FROM gravity;"

print_line

echo "Cleaning Database..."
sudo sqlite3 /etc/pihole/gravity.db "DELETE FROM gravity WHERE rowid NOT IN (SELECT rowid FROM gravity GROUP BY domain); VACUUM;"

print_line

echo "Cleaned Database:"
sudo sqlite3 /etc/pihole/gravity.db "SELECT COUNT(*) FROM gravity;"

print_line

echo "Reloading..."
pihole restartdns reload

print_line

echo "Restarting DNS..."
pihole restartdns

print_line

echo "Flushing..."
pihole flush

print_line

echo "Clearing..."
history -c

print_line

echo "Running Checks..."
./checks.sh

print_line

echo "Go to https://$PIIP/admin"
echo "Use your previously set password to login"

print_line

echo "Rebooting Pi..."
sudo reboot

exit
