# sentinelGuard

## Features
* WireGuard with a Web UI
* Easy installation
* List, create, edit, delete, enable & disable clients
* Show a client's QR code
* Download a client's configuration file
* Statistics for which clients are connected
* Tx/Rx charts for each connected client

## Requirements
* A Raspberry Pi or VPS
* **Install Script uses `apt-get` so will only work on Debian based systems**

## Installation
### 1. Clone the repository
```bash
git clone https://github.com:carlowisse/sentinelGuard.git
```

### 2. Edit `.env` File
```bash
cd sentinelGuard
nano .env
```
- Replace `WG_HOST` with your WAN IP, or a Dynamic DNS hostname
- Replace `PASSWORD` with a password to log in on the Web UI
- Feel free to change anything else in the `.env` file if you know what you're doing

### 3. Run the install script
```bash
sudo bash install.sh
```
> The Web UI will be available on `http://YOUR.SERVER.IP.HERE:51821`.


## Running
### Manually In Console
```bash
cd sentinelGuard
sudo $(nvm which node) server.js
```

### Automatically On Boot (PM2)
```bash
cd sentinelGuard

sudo pm2 start server.js --name sentinelGuard --log /var/log/sentinelGuard.log --time

sudo pm2 save

sudo pm2 startup
```

> This will output a command for you to run, it will look something like this:
```bash
sudo env PATH=$PATH:/home/pi/.nvm/versions/node/v14.15.4/bin /home/pi/.nvm/versions/node/v14.15.4/lib/node_modules/pm2/bin/pm2 startup systemd -u pi --hp /home/pi
```

> Then enable the PM2 service to start on boot:
```bash
systemctl enable pm2-root
```
