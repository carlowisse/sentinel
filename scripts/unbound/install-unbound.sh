#!/bin/bash
runasroot=1

sudo systemctl disable systemd-resolved

sudo apt install unbound -y

sudo ln -s /home/$SUDO_USER/sentinel/scripts/unbound/sentinel-unbound.conf /etc/unbound/unbound.conf.d/

sudo systemctl disable unbound-resolvconf.service

sudo systemctl stop unbound-resolvconf.service

sudo unbound-anchor

sudo rm /etc/unbound/unbound.conf.d/resolvconf_resolvers.conf

sudo sed -i -n '/unbound/!p' /etc/resolvconf.conf

sudo systemctl restart dhcpcd

sudo systemctl restart unbound

sudo echo "edns-packet-max=1232" | sudo tee -a /etc/dnsmasq.d/99-edns.conf

echo " "
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
echo " "

systemctl status unbound

echo " "
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
echo " "

if dig sigfail.verteiltesysteme.net @127.0.0.1 -p 5335 | grep -q 'SERVFAIL'; then
    echo "DNSSEC Reject: Passed"
fi

echo " "
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
echo " "

if dig sigok.verteiltesysteme.net @127.0.0.1 -p 5335 | grep -q 'NOERROR'; then
    echo "DNSSEC Accept: Passed"
fi

exit