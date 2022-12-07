# Sentinel VPN
> Make Sentinel route traffic through a VPN.

## Update and Upgrade
```
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y
```

### Set A Static IP Address
1. Check IPs In Use
    ```
    arp -a
    ```
2. Get Router IP
    ```
    ip r | grep default
    ```
3. Get Current DNS IP
    ```
    cat /etc/resolv.conf
    ```
4. `sudo nano /etc/dhcpcd.conf`
    1. Change first line to `sentinel`
    2. Scroll to the end of the file and set the following for the `eth0` interface
        ```
        interface eth0
        static ip_address=[STAIC_IP]]/24
        static routers=[ROUTER_IP]
        static domain_name_servers=[DNS_IP]
        ```

## Install Dependencies
```
sudo apt install openvpn iptables-persistent python-requests -y
```

## Prepare NordVPN OpenVPN Configuration Files
```
cd /etc/openvpn

sudo su

wget https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip

unzip ovpn.zip

cp ovpn_udp/*.ovpn .

rm -rf ovpn_tcp ovpn_udp
```

```
sudo nano /etc/openvpn/login.txt
```
> USERNAME <br>
> PASSWORD

```
sudo chmod 600 /etc/openvpn/login.txt

python update-nord-creds.py
```

## Find The Country Code You Wish To Connect To
1. Go to this link: https://nordvpn.com/servers/tools/
2. Open Developer Tools
3. Click on the Network Tab
4. Click on the XHR filter
5. Select the Country you wish to use
6. Observe the request that was made
7. Right click the request and copy the link address

```
For Australia it is:
https://nordvpn.com/wp-admin/admin-ajax.php?action=servers_recommendations&filters={"country_id":13}
```

## Configure Sentinel to connect to NordVPN on boot
1. Open the `nord-boot-connector.py` file
2. Replace the URL string with the previously obtained URL

```
sudo nano /etc/rc.local
```
> Before the `exit 0` line insert the following: <br>
> `python /home/pi/sentinel/scripts/nord-boot-connector.py`


## Lock RPi and Allow NordVPN IPs Only
<span style="color:red">**:TODO: NOT SCALABLE need to find another solution**</span>

### Find NordVPN IPs
```
nslookup nordvpn.com
```

### Add IPs to Hosts File
```
sudo nano /etc/hosts
```
> `ip.addr.ess nordvpn.com` <br>
> `ip.addr.ess nordvpn.com`

## Setup IP Forwarding
```
sudo nano /etc/sysctl.conf
```
> Uncomment: <br>
> `net.ipv4.ip_forward=1`

```
sysctl -p /etc/sysctl.conf
```

## Setup IPTables
1. Open the `configure-iptables.sh` file
2. Change `$1` to the subnet from where you expect the devices to connect and use the gateway e.g. `192.168.1.0/24`
3. Change `$2` and `$3` to the IP addesses returned in the `nslookup`
4. Run `bash configure-iptables.sh`

## Initialise
```
sudo reboot
```

## Trobleshooting Logs
```
/var/log/syslog
```

## Testing
> Test the NordVPN Kill Switch feature.
> Simply kill the openvpn process, Kill Switch should kick in and you will not be able to conect to the internet until a stable secure connection is found again.