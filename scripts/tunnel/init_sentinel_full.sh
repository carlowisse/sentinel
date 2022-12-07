#!/bin/bash

echo "Initialising SentinelCore"
echo " "
echo "Preparing Deny List..."

# Deny List
### List Tool
echo "Running Pi Hole List Tool..."
sudo apt install python3-pip -y
sudo pip3 install pihole5-list-tool --upgrade
sudo pihole5-list-tool

### Sentinel Collection
echo "Running Sentinel Collection..."
source load-adlists.sh

### Regex (Facebook)
echo "Applying Facebook RegEx..."
pihole --regex '(^|\.)(facebook|fb|fbcdn|fbsbx|tfbnw)\.(com|net)$'

echo " "
echo "Preparing Allow List..."

cd
echo "Applying anudeepND Common..."
git clone https://github.com/anudeepND/whitelist.git
sudo python3 whitelist/scripts/whitelist.py

cd sentinel/scripts
echo "Applying Sentinel Common..."
source apply-whitelist.sh common.txt
echo "Applying Sentinel URL Shorteners..."
source apply-whitelist.sh url_shorteners.txt

echo " "
echo " "
echo "Initialising SentinelDoH..."
echo " "
echo "Preparing Cloudflared..."

cd

wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64

sudo cp ./cloudflared-linux-arm64 /usr/local/bin/cloudflared

sudo chmod +x /usr/local/bin/cloudflared

echo "Cloudflared Version:"
cloudflared -v

echo "Creating Cloudflared Configuration..."
sudo mkdir /etc/cloudflared/

sudo touch /etc/cloudflared/config.yml

sudo cat <<EOT >> /etc/cloudflared/config.yml
proxy-dns: true
proxy-dns-port: 5053
proxy-dns-upstream:
 - https://1.1.1.1/dns-query
 - https://1.0.0.1/dns-query
 # Uncomment the following if you also want to use IPv6 for external DOH lookups
 #- https://[2606:4700:4700::1111]/dns-query
 #- https://[2606:4700:4700::1001]/dns-query
EOT

echo "Installing Cloudflared..."
sudo cloudflared service install --legacy

sudo systemctl enable cloudflared

sudo systemctl start cloudflared

sudo systemctl status cloudflared

echo "Testing Cloudflared..."
dig @127.0.0.1 -p 5053 google.com

echo " "
echo "Creating Auto Updater For Cloudflared..."

sudo touch /etc/cron.weekly/cloudflared-updater

sudo cat <<EOT >> /etc/cron.weekly/cloudflared-updater
sudo cloudflared update
sudo systemctl restart cloudflared
EOT

sudo chmod +x /etc/cron.weekly/cloudflared-updater

sudo chown root:root /etc/cron.weekly/cloudflared-updater

echo " "
echo " "
echo "Initialising SentinelVPN..."
echo " "
echo "Downloading Dependencies..."

echo "Installing NordVPN Client"
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)

echo "Login to NordVPN"
nordvpn login

echo "Configuring NordVPN"
nordvpn set cybersec on
nordvpn set killswitch on
nordvpn set autoconnect on
nordvpn set dns 1.1.1.1 1.0.0.1

echo "Using UDP For Speed Rather than Accuracy"
nordvpn set protocol udp

echo "Switching To NordLynx (WireGuard)"
nordvpn set technology nordlynx

echo " "
nordvpn countries

echo " "
echo "Please type in a country from above"

read -p "Selected Country:" COUNTRY
nordvpn connect $COUNTRY

nordvpn status
