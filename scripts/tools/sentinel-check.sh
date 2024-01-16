#!/bin/bash

print_line() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

check() {
    if eval "$1"; then
        echo "$2: Pass."
    else
        echo "$2: FAIL."
    fi
}

echo "Sentinel:"
print_line

check "ls | grep -q 'sentinel'" "Sentinel install"
check "pihole -c -e | grep -q 'Hostname: sentinel'" "Sentinel stats"
check "hostname | grep -q 'sentinel'" "Sentinel hostname"

echo ""
echo "Unbound:"
print_line

check "dig sigfail.verteiltesysteme.net @127.0.0.1 -p 5335 | grep -q 'SERVFAIL'" "DNSSEC reject"
check "dig sigok.verteiltesysteme.net @127.0.0.1 -p 5335 | grep -q 'NOERROR'" "DNSSEC accept"
check "ps aux | grep -v grep | grep -q 'unbound'" "Unbound process"
check "unbound-checkconf | grep -q 'no errors'" "Unbound configuration"

echo ""
echo "Pi-Hole:"
print_line

check "ps aux | grep -v grep | grep -q 'pihole'" "Pi-Hole process"
check "pihole -v | grep -q 'Pi-hole'" "Pi-Hole install"
check "pihole -v | grep -q 'AdminLTE'" "Admin install"
check "pihole -v | grep -q 'FTL'" "FTL install"
check "pihole status | grep -q 'FTL is listening'" "FTL listening"
check "pihole status | grep -q '[✓] UDP (IPv4)'" "Pi-Hole UDP IPv4"
check "pihole status | grep -q '[✓] TCP (IPv4)'" "Pi-Hole TCP IPv4"
check "pihole status | grep -q '[✓] UDP (IPv6)'" "Pi-Hole UDP IPv6"
check "pihole status | grep -q '[✓] TCP (IPv6)'" "Pi-Hole TCP IPv6"
check "pihole status | grep -q '[✓] Pi-hole blocking is enabled'" "Pi-Hole blocking enabled"

echo ""
echo "UFW:"
print_line

ufw_status=$(sudo ufw status verbose)

check "[[ $ufw_status == *'Status: active'* ]]" "UFW Running"
check "sudo netstat -tuln | grep -q ':80 ' && sudo netstat -tuln | grep -q ':22 '" "UFW Ports"
check "[[ $ufw_status == *'Status: active'* ]]" "UFW Enabled"
check "[[ $ufw_status == *'Default: deny (incoming)'* ]] && [[ $ufw_status == *'Default: allow (outgoing)'* ]]" "UFW Incoming/Outgoing"

exit
