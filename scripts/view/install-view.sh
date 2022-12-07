#!/bin/bash
runasroot=1

sudo apt install gcc -y

sudo chmod +x ./install-go.sh

./install-go.sh

wget -N https://raw.githubusercontent.com/pi-hole/PADD/master/padd.sh

sudo mv padd.sh padd

sudo chmod +x padd

sudo chmod +x ./sentinel-view

ln -s /home/$SUDO_USER/sentinel/scripts/view/padd /usr/local/bin
ln -s /home/$SUDO_USER/sentinel/scripts/view/sentinel-view/cmd/main/sentinel-view /usr/local/bin
