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
    echo "$1='$2'" >>$SENTINEL_CONF
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
apt install git python3 python3-pip sqlite3 ufw -y

# GET SENTINEL
cd /home/$SUDO_USER
# git clone https://github.com/carlowisse/sentinel.git
cd /home/$SUDO_USER/sentinel

# GET CUSTOM INPUT FROM USER
TIMEZONE=$(get_input "Enter Timezone (e.g. Australia/Sydney)")
PIHOLE_PASSWORD=$(get_input "Enter PiHole Frontend Password")

# STATIC VARIABLES
SENTINEL_PATH="/home/$SUDO_USER/sentinel"
SENTINEL_CONF="./env.conf"
ROUTERIP=$(ip route show | grep -i 'default via' | awk '{print $3 }')
PIIP=$(hostname -I | tr -d ' ')

# CLEAR THE ENV FILE
echo "" >$SENTINEL_CONF

# UPDATE THE ENV FILE WITH THE NEW ENTRIES
## CORE
update_env_file "ROUTERIP" "$ROUTERIP"
update_env_file "PIIP" "$PIIP"
update_env_file "PIHOLE_PASSWORD" "$PIHOLE_PASSWORD"
update_env_file "TIMEZONE" "$TIMEZONE"

print_line

########## CONFIGURE SYSTEM ##########
echo "Configuring System..."

# SET TIMEZONE
timedatectl set-timezone $TIMEZONE

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

# CONFIGURE UFW
ufw --force enable
echo y | ufw reset
ufw --force enable
ufw default deny incoming
ufw default allow outgoing
ufw allow 22
ufw allow 80

systemctl restart ufw

print_line

########## PREPARE SENTINEL ##########
echo "Preparing Sentinel..."

# PREPARE SENTINEL SCRIPTS
cd $SENTINEL_PATH/scripts/
chmod +x ./tools/sentinel-check.sh

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
DNSMASQ_LISTENING=bind
DNS_FQDN_REQUIRED=true
DNS_BOGUS_PRIV=true
DNSSEC=true
REV_SERVER=false
WEBTHEME=default-darker
WEBUIBOXEDLAYOUT=traditional
PIHOLE_DNS_1=127.0.0.1#5335
EOT

# INSTALL PI-HOLE
curl -L https://install.pi-hole.net | bash /dev/stdin --unattended

# UPDATE PI-HOLE PASSWORD
pihole -a -p $PIHOLE_PASSWORD

# ADD BLOCKINGMODE=NXDOMAIN TO PIHOLE-FTL.CONF IF IT DOESN'T EXIST
if grep -q "BLOCKINGMODE=NXDOMAIN" /etc/pihole/pihole-FTL.conf; then
    echo "Blocking Mode already configured"
else
    echo "BLOCKINGMODE=NXDOMAIN" >>/etc/pihole/pihole-FTL.conf
fi

print_line

# PI-HOLE MAINTENANCE
pihole restartdns reload
pihole restartdns
pihole flush

print_line

########## UNBOUND AND STUBBY ##########
echo "Configuring Unbound..."

apt install unbound stubby -y
for file in $SENTINEL_PATH/unbound/*.conf; do
    ln -s $file /etc/unbound/unbound.conf.d/
done

systemctl disable --now unbound-resolvconf.service
sed -Ei 's/^unbound_conf=/#unbound_conf=/' /etc/resolv.conf
rm /etc/unbound/unbound.conf.d/resolvconf_resolvers.conf
echo "edns-packet-max=1232" | tee -a /etc/dnsmasq.d/99-edns.conf

mkdir -p /var/log/unbound
touch /var/log/unbound/unbound.log
chown unbound /var/log/unbound/unbound.log

if grep -q "var/log/unbound/unbound.log rw," /etc/apparmor.d/local/usr.sbin.unbound; then
    echo "AppArmor already configured for unbound"
else
    echo "/var/log/unbound/unbound.log rw," >>/etc/apparmor.d/local/usr.sbin.unbound
    apparmor_parser -r /etc/apparmor.d/usr.sbin.unbound
    service apparmor restart
fi

print_line

########## STUBBY ##########
echo "Configuring Stubby..."

rm /etc/stubby/stubby.yml
cp $SENTINEL_PATH/stubby/sentinel-stubby.yml /etc/stubby/stubby.yml
chmod 644 /etc/stubby/stubby.yml

### COMMENT OUT line that contains domain_name_servers in /etc/dhcpcd.conf
sed -i '/domain_name_servers=/s/^/#/g' /etc/dhcpcd.conf

systemctl restart unbound stubby

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
echo "Web Portal: http://$PIIP/admin"
echo "Password: $PIHOLE_PASSWORD"

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
