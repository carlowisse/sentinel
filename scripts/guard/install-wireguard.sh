#!/bin/bash
runasroot=1

print_line() {
    echo " "
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    echo " "
}

echo "Installing WireGuard..."
sudo apt-get install wireguard wireguard-tools -y

print_line

echo "Preparing WireGuard configuration..."
sudo -i
cd /etc/wireguard
umask 077

print_line

echo "Creating WireGuard configuration..."
wg genkey | tee server.key | wg pubkey > server.pub

sudo touch wg0.conf

sudo tee /etc/wireguard/wg0.conf >/dev/null <<EOT
[Interface]
Address = 10.100.0.1/24, fd08:4711::1/64
ListenPort = 47111
EOT

echo "PrivateKey = $(cat server.key)" >> /etc/wireguard/wg0.conf

print_line

echo "Creating WireGuard configuration..."
sudo systemctl enable wg-quick@wg0.service
sudo systemctl daemon-reload
sudo systemctl start wg-quick@wg0

sudo wg

exit