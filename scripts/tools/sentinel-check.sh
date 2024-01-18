#!/bin/bash

### SENTINEL CHECK ###
cd
if ls | grep -q 'sentinel'; then
    echo "Sentinel install: PASS."
else
    echo -e "\e[31mSentinel install: FAIL.\e[0m"
fi

if pihole -c -e | grep -q 'Hostname: sentinel'; then
    echo "Sentinel stats: PASS."
else
    echo "\e[31mSentinel stats: FAIL.\e[0m"
fi

if hostname | grep -q 'sentinel'; then
    echo "Sentinel hostname: PASS."
else
    echo -e "\e[31mSentinel hostname: FAIL.\e[0m"
fi

### DNS CHECK ###
# UNBOUND
if dig pi-hole.net @127.0.0.1 -p 5335 | grep -q 'NOERROR'; then
    echo "Unbound DNS: PASS."
else
    echo -e "\e[31mUnbound DNS: FAIL.\e[0m"
fi

# STUBBY
if dig pi-hole.net @127.0.0.1 -p 8053 | grep -q 'NOERROR'; then
    echo "Stubby DNS: PASS."
else
    echo -e "\e[31mStubby DNS: FAIL.\e[0m"
fi

# FTLDNS
if dig pi-hole.net @127.0.0.1 -p 53 | grep -q 'NOERROR'; then
    echo "FTLDNS DNS: PASS."
else
    echo -e "\e[31mFTLDNS DNS: FAIL.\e[0m"
fi

# DNSSEC
if dig sigfail.verteiltesysteme.net @127.0.0.1 -p 5335 | grep -q 'SERVFAIL'; then
    echo "DNSSEC reject: PASS."
else
    echo -e "\e[31mDNSSEC reject: FAIL.\e[0m"
fi

if dig sigok.verteiltesysteme.net @127.0.0.1 -p 5335 | grep -q 'NOERROR'; then
    echo "DNSSEC accept: PASS."
else
    echo -e "\e[31mDNSSEC accept: FAIL.\e[0m"
fi

### UNBOUND CHECK ###
if ps aux | grep -q 'unbound'; then
    echo "Unbound process: PASS."
else
    echo -e "\e[31mUnbound process: FAIL.\e[0m"
fi

if unbound-checkconf | grep -q 'no errors'; then
    echo "Unbound configuration: PASS."
else
    echo -e "\e[31mUnbound configuration: FAIL.\e[0m"
fi

### PI-HOLE CHECK ###
if ps aux | grep -q 'pihole'; then
    echo "Pi-Hole process: PASS."
else
    echo -e "\e[31mPi-Hole process: FAIL.\e[0m"
fi

if pihole -v | grep -q 'Pi-hole'; then
    echo "Pi-Hole install: PASS."
else
    echo -e "\e[31mPi-Hole install: FAIL.\e[0m"
fi

if pihole -v | grep -q 'web'; then
    echo "Web install: PASS."
else
    echo -e "\e[31mWeb install: FAIL.\e[0m"
fi

if pihole -v | grep -q 'FTL'; then
    echo "FTL install: PASS."
else
    echo -e "\e[31mFTL install: FAIL.\e[0m"
fi

if pihole status | grep -q 'FTL is listening'; then
    echo "FTL listening: PASS."
else
    echo -e "\e[31mFTL listening: FAIL.\e[0m"
fi

if pihole status | grep -q 'UDP (IPv4)'; then
    echo "Pi-Hole UDP IPv4: PASS."
else
    echo -e "\e[31mPi-Hole UDP IPv4: FAIL.\e[0m"
fi

if pihole status | grep -q 'TCP (IPv4)'; then
    echo "Pi-Hole TCP IPv4: PASS."
else
    echo -e "\e[31mPi-Hole TCP IPv4: FAIL.\e[0m"
fi

if pihole status | grep -q 'UDP (IPv6)'; then
    echo "Pi-Hole UDP IPv6: PASS."
else
    echo -e "\e[31mPi-Hole UDP IPv6: FAIL.\e[0m"
fi

if pihole status | grep -q 'TCP (IPv6)'; then
    echo "Pi-Hole TCP IPv6: PASS."
else
    echo -e "\e[31mPi-Hole TCP IPv6: FAIL.\e[0m"
fi

if pihole status | grep -q 'Pi-hole blocking is enabled'; then
    echo "Pi-Hole blocking enabled: PASS."
else
    echo -e "\e[31mPi-Hole blocking enabled: FAIL.\e[0m"
fi

### UFW CHECK ###
ufw_status=$(sudo ufw status verbose)

if [[ $ufw_status == *"Status: active"* ]]; then
    echo "UFW Running: PASS."
else
    echo -e "\e[31mUFW Running: FAIL.\e[0m"
fi

# Check if port 80 and 22 are open
if sudo netstat -tuln | grep -q ':80 ' && sudo netstat -tuln | grep -q ':22 '; then
    echo "UFW Ports: PASS."
else
    echo -e "\e[31mUFW Ports: FAIL.\e[0m"
fi

# Check if ufw is enabled
if [[ $ufw_status == *"Status: active"* ]]; then
    echo "UFW Enabled: PASS."
else
    echo -e "\e[31mUFW Enabled: FAIL.\e[0m"
fi

# Check if outgoing is allowed and incoming is denied
if [[ $ufw_status == *"deny (incoming)"* ]] && [[ $ufw_status == *"allow (outgoing)"* ]]; then
    echo "UFW Incoming/Outgoing: PASS."
else
    echo -e "\e[31mUFW Incoming/Outgoing: FAIL.\e[0m"
fi

exit
