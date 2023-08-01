#!/bin/bash

########## FUNCTIONS ##########
print_line() {
    echo " "
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    echo " "
}

get_input() {
    read -p "$1: " value
    echo "$value"
}

# FUNCTION TO UPDATE THE ENV FILE
update_env_file() {
    echo "$1='$2'" >>$ENV_FILE
}

########## ENVIRONMENT ##########
echo "PREPARING ENVIRONMENT"

# UPDATE SYSTEM
apt-get update -y
apt-get upgrade -y
apt dist-upgrade -y

# CLEAN UP SYSTEM
apt-get autoremove -y
apt-get autoclean -y
apt-get clean -y

# INSTALL DEPENDENCIES
apt install git python3 python3-pip sqlite3 iptables-persistent wireguard-tools ufw -y

# GET SENTINEL
cd /home/$SUDO_USER
# git clone https://github.com/carlowisse/sentinel.git
cd /home/$SUDO_USER/sentinel

# GET CUSTOM INPUT FROM USER
GUARD_FRONT_PORT=$(get_input "Enter WireGuard Frontend Port")
GUARD_PASSWORD=$(get_input "Enter WireGuard Frontend Password")
UNBOUND_FRONT_PORT=$(get_input "Enter sentinelUnbound Frontend Port")
ALERT_PASSWORD=$(get_input "Enter sentinelAlert Frontend Password")
TIMEZONE=$(get_input "Enter Timezone (e.g. Australia/Sydney)")
PIHOLE_PASSWORD=$(get_input "Enter PiHole Frontend Password")

# STATIC VARIABLES
GUARD_PORT=51820
SENTINEL_PATH="/home/$SUDO_USER/sentinel"
ENV_FILE="./test_env.conf"
ROUTERIP=$(ip route show | grep -i 'default via' | awk '{print $3 }')
PIIP=$(hostname -I | tr -d ' ')

# CLEAR THE ENV FILE
echo "" >$ENV_FILE

# ADD BASE_ENV.CONF TO ENV FILE
cat ./base_env.conf >>$ENV_FILE

# UPDATE THE ENV FILE WITH THE NEW ENTRIES
## CORE
update_env_file "ROUTERIP" "$ROUTERIP"
update_env_file "PIIP" "$PIIP"
update_env_file "PIHOLE_PASSWORD" "$PIHOLE_PASSWORD"
update_env_file "TIMEZONE" "$TIMEZONE"

## GUARD
update_env_file "GUARD_HOST" "$PIIP"
update_env_file "GUARD_PORT" "$GUARD_PORT"
update_env_file "GUARD_FRONT_PORT" "$GUARD_FRONT_PORT"
update_env_file "GUARD_PASSWORD" "$GUARD_PASSWORD"

## UNBOUND
update_env_file "UNBOUND_FRONT_PORT" "$UNBOUND_FRONT_PORT"

## ALERT
update_env_file "ALERT_PASSWORD" "$ALERT_PASSWORD"

print_line

########## CONFIGURE SYSTEM ##########
echo "Configuring System..."

# SET TIMEZONE
timedatectl set-timezone $TIMEZONE

# INSTALL NODE AND NPM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install node
npm install -g npm@latest
npm install pm2@latest -g
ln -s $(nvm which node) /usr/sbin/node
ln -s "$(dirname "$(nvm which node)")/pm2" /usr/sbin/pm2

# SECURE SYSTEM
touch /home/$SUDO_USER/.hushlogin
echo "dtoverlay=disable-wifi" | tee -a /boot/config.txt >/dev/null
echo "dtoverlay=disable-bt" | tee -a /boot/config.txt >/dev/null

# SET STATIC IP
tee -a /etc/dhcpcd.conf >/dev/null <<EOT

interface eth0
static ip_address=$PIIP/24
static routers=$ROUTERIP
static domain_name_servers=$ROUTERIP
EOT

# CONFIGURE IPTABLES
debconf-set-selections <<EOT
iptables-persistent iptables-persistent/autosave_v4 boolean true
iptables-persistent iptables-persistent/autosave_v6 boolean true
EOT

iptables -F

iptables -A INPUT -p tcp --dport 443 -j REJECT --reject-with tcp-reset
iptables -A INPUT -p udp --dport 80 -j REJECT --reject-with icmp-port-unreachable
iptables -A INPUT -p udp --dport 443 -j REJECT --reject-with icmp-port-unreachable

ip6tables -A INPUT -p tcp --dport 443 -j REJECT --reject-with tcp-reset
ip6tables -A INPUT -p udp --dport 80 -j REJECT --reject-with icmp6-port-unreachable
ip6tables -A INPUT -p udp --dport 443 -j REJECT --reject-with icmp6-port-unreachable

sh -c "iptables-save > /etc/iptables/rules.v4"
sh -c "ip6tables-save > /etc/iptables/rules.v6"

# CONFIGURE UFW
ufw --force enable
echo y | ufw reset
ufw --force enable
ufw default deny incoming
ufw default allow outgoing
ufw allow 22
ufw allow 80
ufw allow 5000
ufw allow $GUARD_PORT
ufw allow $GUARD_FRONT_PORT
ufw allow $UNBOUND_FRONT_PORT

systemctl restart ufw

print_line

########## PREPARE SENTINEL ##########
echo "Preparing Sentinel..."

# PREPARE SENTINEL SCRIPTS
cd $SENTINEL_PATH/scripts/
chmod +x ./tools/sentinel-check.sh
chmod +x ./load-lists.sh
chmod +x ./apply-white-list.sh
chmod +x ./apply-white-regex-list.sh
chmod +x ./apply-black-regex-list.sh

print_line

########## CONFIGURE AND INSTALL PI-HOLE ##########
echo "Configuring PiHole..."

# PREPARE PI-HOLE CONFIGURATION
mkdir /etc/pihole
touch /etc/pihole/setupVars.conf

tee /etc/pihole/setupVars.conf >/dev/null <<EOT
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

# INSTALL PI-HOLE
curl -L https://install.pi-hole.net | bash /dev/stdin --unattended

# UPDATE PI-HOLE PASSWORD
pihole -a -p $PIHOLE_PASSWORD

# CLEAN UP PI-HOLE
pihole --regex --nuke
pihole --white-regex --nuke
pihole -w --nuke
pihole -b --nuke
sqlite3 /etc/pihole/gravity.db "DELETE FROM adlist"

print_line

########## LOADING SENTINEL LISTS ##########
echo "Loading Sentinel Lists..."

# LOAD LISTS
./load-lists.sh
pihole -g

# GET COUNT OF DOMAINS IN GRAVITY DB
UNCLEAN_COUNT=$(sqlite3 /etc/pihole/gravity.db "SELECT COUNT(*) FROM gravity;")

# CLEAN UP GRAVITY DB
sqlite3 /etc/pihole/gravity.db "DELETE FROM gravity WHERE rowid NOT IN (SELECT rowid FROM gravity GROUP BY domain); VACUUM;"

# GET COUNT OF DOMAINS IN GRAVITY DB
CLEAN_COUNT=$(sqlite3 /etc/pihole/gravity.db "SELECT COUNT(*) FROM gravity;")

echo "Domains Uncleaned: $UNCLEAN_COUNT"
echo "Domains Cleaned: $CLEAN_COUNT"
echo "Domains Removed: $(($UNCLEAN_COUNT - $CLEAN_COUNT))"

# PI-HOLE MAINTENANCE
pihole restartdns reload
pihole restartdns
pihole flush

print_line

########## UNBOUND ##########
echo "Configuring sentinelUnbound..."

systemctl disable systemd-resolved
apt install unbound -y
ln -s $SENTINEL_PATH/unbound/sentinel-unbound.conf /etc/unbound/unbound.conf.d/
systemctl disable unbound-resolvconf.service
systemctl stop unbound-resolvconf.service
unbound-anchor
rm /etc/unbound/unbound.conf.d/resolvconf_resolvers.conf
sed -i -n '/unbound/!p' /etc/resolvconf.conf
systemctl restart dhcpcd
systemctl restart unbound
echo "edns-packet-max=1232" | tee -a /etc/dnsmasq.d/99-edns.conf

# INSTALL UNBOUND FRONTEND
cd $SENTINEL_PATH/unbound
npm install

# START UNBOUND FRONTEND
pm2 start sentinel-unbound.js --name sentinel-unbound

# ENFORCE PM2 TO START ON BOOT
startup_output=$(pm2 startup)
command=$(echo "$startup_output" | grep -o 'env PATH=.*')
eval $command

print_line

########## SENTINEL GUARD ##########
# INSTALL UNBOUND FRONTEND
cd $SENTINEL_PATH/guard
npm install

# START UNBOUND FRONTEND
pm2 start server.js --name sentinel-guard

print_line

########## SENTINEL ALERT ##########
echo "Configuring sentinelAlert..."
curl -sSL https://raw.githubusercontent.com/carlowisse/sentinel-alert/main/install/pialert_install.sh | bash

cd ~/pialert/back

./pialert-cli set_password $ALERT_PASSWORD

print_line

########## PM2 ##########
echo "Configuring PM2..."
pm2 save

print_line

########## CLEAN UP INSTALL ##########
# CLEAN UP HISTORY
history -c

print_line

########## RUN CHECKS ##########
echo "Running sentinelCheck..."
bash $SENTINEL_PATH/scripts/tools/sentinel-check.sh

print_line

########## PRINT DETAILS ##########
echo "Access Details:"
echo "sentinelCore: http://$PIIP/admin"
echo "sentinelAlert: http://$PIIP:5000"
echo "sentinelGuard: http://$PIIP:$GUARD_FRONT_PORT"
echo "sentinelUnbound: http://$PIIP:5002"

print_line

########## REBOOT ##########
echo "We recommend you reboot your system now."
read -p "Would you like to reboot? (y/n): " reply

if [ "$reply" = "y" ] || [ "$reply" = "Y" ]; then
    echo "Rebooting Sentinel..."
    echo "INSTALLATION COMPLETE"
    reboot
else
    echo "INSTALLATION COMPLETE"
    print_line
    exit 1
fi
