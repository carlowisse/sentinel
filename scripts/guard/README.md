# How To Use Client Gen

```
sudo -i
cd /etc/wireguard
umask 077

bash "10.100.0." "fd08:4711::" "my_server_domain:47111" 2 "charis-phone"
bash "10.100.0." "fd08:4711::" "my_server_domain:47111" 3 "carlo-phone"

exit
```