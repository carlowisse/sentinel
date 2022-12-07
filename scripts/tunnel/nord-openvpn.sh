sudo apt install openvpn iptables-persistent python-requests -y

echo "Preparing NordVPN Configuration Files..."
cd /etc/openvpn

sudo wget https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip

sudo unzip ovpn.zip

sudo cp ovpn_udp/*.ovpn .

sudo rm -rf ovpn_tcp ovpn_udp

echo "Configuring NordVPN..."
sudo touch /etc/openvpn/login.txt

read -p "NordVPN Username:" nordUser
sudo echo $nordUser >> /etc/openvpn/login.txt

read -s -p "NordVPN Password:" nordPassword
sudo echo $nordPassword >> /etc/openvpn/login.txt

sudo chmod 600 /etc/openvpn/login.txt

cd
cd sentinel/scripts
python3 update-nord-creds.py

echo "Configuring NordVPN To Start On Boot..."
sudo sed '/exit 0/ipython /home/pi/sentinel/scripts/nord-boot-connector.py' /etc/rc.local

echo "Retrieving NordVPN IPs..."
NORDIP1=$(nslookup nordvpn.com | grep -m2 Address | tail -n1 | awk '{print $2}')
NORDIP2=$(nslookup nordvpn.com | grep -m3 Address | tail -n1 | awk '{print $2}')

sudo echo "${NORDIP1} nordvpn.com" >> /etc/hosts
sudo echo "${NORDIP2} nordvpn.com" >> /etc/hosts

sudo sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sysctl -p /etc/sysctl.conf

echo "Retrieving Router IP..."
ROUTERIP=$(route | grep default | awk '{print $2}')

echo "Configuring IPTables..."
bash configure-iptables.sh "192.168.0.0/24" ${NORDIP1} ${NORDIP2}

echo "Turning Off IPv6..."
sudo echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
sudo echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
sudo echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
sudo echo "net.ipv6.conf.tun0.disable_ipv6 = 1" >> /etc/sysctl.conf