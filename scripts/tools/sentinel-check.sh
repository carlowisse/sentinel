#!/bin/bash

print_line() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

echo "Sentinel:"
print_line

cd
if ls | grep -q 'sentinel'; then
    echo "Sentinel install: PASS."
else
    echo "Sentinel install: FAIL."
fi

if pihole -c -e | grep -q 'Hostname: sentinel'; then
    echo "Sentinel stats: PASS."
else
    echo "Sentinel stats: FAIL."
fi

if hostname | grep -q 'sentinel'; then
    echo "Sentinel hostname: PASS."
else
    echo "Sentinel hostname: FAIL."
fi

echo ""
echo "Unbound:"
print_line

if dig sigfail.verteiltesysteme.net @127.0.0.1 -p 5335 | grep -q 'SERVFAIL'; then
    echo "DNSSEC reject: PASS."
else
    echo "DNSSEC reject: FAIL."
fi

if dig sigok.verteiltesysteme.net @127.0.0.1 -p 5335 | grep -q 'NOERROR'; then
    echo "DNSSEC accept: PASS."
else
    echo "DNSSEC accept: FAIL."
fi

if ps aux | grep -q 'unbound'; then
    echo "Unbound process: PASS."
else
    echo "Unbound process: FAIL."
fi

if unbound-checkconf | grep -q 'no errors'; then
    echo "Unbound configuration: PASS."
else
    echo "Unbound configuration: FAIL."
fi

echo ""
echo "Pi-Hole:"
print_line

if ps aux | grep -q 'pihole'; then
    echo "Pi-Hole process: PASS."
else
    echo "Pi-Hole process: FAIL."
fi

if pihole -v | grep -q 'Pi-hole'; then
    echo "Pi-Hole install: PASS."
else
    echo "Pi-Hole install: FAIL."
fi

if pihole -v | grep -q 'AdminLTE'; then
    echo "Admin install: PASS."
else
    echo "Admin install: FAIL."
fi

if pihole -v | grep -q 'FTL'; then
    echo "FTL install: PASS."
else
    echo "FTL install: FAIL."
fi

if pihole status | grep -q 'FTL is listening'; then
    echo "FTL listening: PASS."
else
    echo "FTL listening: FAIL."
fi

if pihole status | grep -q '[✓] UDP (IPv4)'; then
    echo "Pi-Hole UDP IPv4: PASS."
else
    echo "Pi-Hole UDP IPv4: FAIL."
fi

if pihole status | grep -q '[✓] TCP (IPv4)'; then
    echo "Pi-Hole TCP IPv4: PASS."
else
    echo "Pi-Hole TCP IPv4: FAIL."
fi

if pihole status | grep -q '[✓] UDP (IPv6)'; then
    echo "Pi-Hole UDP IPv6: PASS."
else
    echo "Pi-Hole UDP IPv6: FAIL."
fi

if pihole status | grep -q '[✓] TCP (IPv6)'; then
    echo "Pi-Hole TCP IPv6: PASS."
else
    echo "Pi-Hole TCP IPv6: FAIL."
fi

if pihole status | grep -q '[✓] Pi-hole blocking is enabled'; then
    echo "Pi-Hole blocking enabled: PASS."
else
    echo "Pi-Hole blocking enabled: FAIL."
fi

echo ""
echo "UFW:"
print_line

# Check if ufw is running
ufw_status=$(sudo ufw status verbose)

if [[ $ufw_status == *"Status: active"* ]]; then
    echo "UFW Running: PASS."
else
    echo "UFW Running: FAIL."
fi

# Check if port 80 and 22 are open
if sudo netstat -tuln | grep -q ':80 ' && sudo netstat -tuln | grep -q ':22 '; then
    echo "UFW Ports: PASS."
else
    echo "UFW Ports: FAIL."
fi

# Check if ufw is enabled
if [[ $ufw_status == *"Status: active"* ]]; then
    echo "UFW Enabled: PASS."
else
    echo "UFW Enabled: FAIL."
fi

# Check if outgoing is allowed and incoming is denied
if [[ $ufw_status == *"Default: deny (incoming)"* ]] && [[ $ufw_status == *"Default: allow (outgoing)"* ]]; then
    echo "UFW Incoming/Outgoing: PASS."
else
    echo "UFW Incoming/Outgoing: FAIL."
fi

exit
