# SentinelUnbound
> Validating, Recursive, Caching DNS Resolver

<br>

## Update and Upgrade
```
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y
```

## Download And Install Unbound
1. Navigate to `sentinel/scripts/unbound`
```
chmod +x install-unbound.sh

./install-unbound.sh
```

## Update Unbound
```
sudo apt update
```

## Test Configuration
Expect: `SERVFAIL`
```
dig sigfail.verteiltesysteme.net @127.0.0.1 -p 5335
```

Expect: `NOERROR`
```
dig sigok.verteiltesysteme.net @127.0.0.1 -p 5335
```

## Configure Sentinel To Use Unbound
1. Go to pi-hole web interface
2. Go to Settings (left pane)
3. Go to DNS tab
4. Change `Custom 1 (IPv4)` to: `127.0.0.1#5335`
5. Click the checkbox to enable
6. Uncheck any checkboxes on the left hand side for all DNS providers
6. Click save
