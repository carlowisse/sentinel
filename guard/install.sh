#!/bin/bash

### PRINT FUNCTIONS ###
print_line() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    echo " "
}

print_msg() {
    printf "\n$1\n"
}

### SYSTEM PREPARATION ###
print_msg "Preparing system..."
sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y && sudo apt-get autoclean -y && sudo apt-get clean -y && sudo reboot

print_msg "Installing dependencies..."

print_msg "Wireguard tools..."
sudo apt-get install -y wireguard-tools ufw

print_msg "NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

print_msg "NodeJS..."
nvm install node

print_msg "Updating npm..."
npm install -g npm@latest

print_msg "PM2..."
npm install pm2@latest -g

sudo ln -s $(nvm which node) /usr/sbin/node

sudo ln -s "$(dirname "$(nvm which node)")/pm2" /usr/sbin/pm2

print_msg "Configuring firewall..."
sudo ufw --force enable

sudo ufw status
echo y | sudo ufw reset
sudo ufw status

sudo ufw --force enable

sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 51820/udp
sudo ufw allow 51821/tcp

sudo systemctl restart ufw
