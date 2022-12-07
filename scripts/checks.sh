#!/bin/bash
runasroot=1

print_line() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

echo "Sentinel Core:"
print_line

cd
if ls | grep -q 'sentinel'; then
    echo "Sentinel install: Pass."
fi

if pihole -c -e | grep -q 'Hostname: sentinel'; then
    echo "Sentinel stats: Pass."
fi

if hostname | grep -q 'sentinel'; then
    echo "Sentinel hostname: Pass."
fi

echo ""

echo "Sentinel Unbound:"
print_line

if dig sigfail.verteiltesysteme.net @127.0.0.1 -p 5335 | grep -q 'SERVFAIL'; then
    echo "DNSSEC reject: Pass."
fi

if dig sigok.verteiltesysteme.net @127.0.0.1 -p 5335 | grep -q 'NOERROR'; then
    echo "DNSSEC accept: Pass."
fi

if ps aux | grep -q 'unbound'; then
    echo "Unbound process: Pass."
fi

if unbound-checkconf | grep -q 'no errors'; then
    echo "Unbound configuration: Pass."
fi

echo ""

echo "Sentinel Pi-Hole:"
print_line

if ps aux | grep -q 'pihole'; then
    echo "Pi-Hole process: Pass."
fi

if pihole -v | grep -q 'Pi-hole'; then
    echo "Pi-Hole install: Pass."
fi

if pihole -v | grep -q 'AdminLTE'; then
    echo "Admin install: Pass."
fi

if pihole -v | grep -q 'FTL'; then
    echo "FTL install: Pass."
fi

if pihole status | grep -q 'FTL is listening'; then
    echo "FTL listening: Pass."
fi

if pihole status | grep -q '[✓] UDP (IPv4)'; then
    echo "Pi-Hole UDP IPv4: Pass."
fi

if pihole status | grep -q '[✓] TCP (IPv4)'; then
    echo "Pi-Hole TCP IPv4: Pass."
fi

if pihole status | grep -q '[✓] UDP (IPv6)'; then
    echo "Pi-Hole UDP IPv6: Pass."
fi

if pihole status | grep -q '[✓] TCP (IPv6)'; then
    echo "Pi-Hole TCP IPv6: Pass."
fi

if pihole status | grep -q '[✓] Pi-hole blocking is enabled'; then
    echo "Pi-Hole blocking enabled: Pass."
fi

echo ""

echo "IPTables:"
print_line

if sudo iptables -S | grep -q -e '-P INPUT ACCEPT'; then
    echo "INPUT ACCEPT: Pass."
fi

if sudo iptables -S | grep -q -e '-P FORWARD ACCEPT'; then
    echo "FORWARD ACCEPT: Pass."
fi

if sudo iptables -S | grep -q -e '-P OUTPUT ACCEPT'; then
    echo "OUTPUT ACCEPT: Pass."
fi

if sudo iptables -S | grep -q -e '-A INPUT -p tcp -m tcp --dport 443 -j REJECT --reject-with tcp-reset'; then
    echo "TCP 443 REJECT: Pass."
fi

if sudo iptables -S | grep -q -e '-A INPUT -p udp -m udp --dport 80 -j REJECT --reject-with icmp-port-unreachable'; then
    echo "UDP 80 REJECT: Pass."
fi

if sudo iptables -S | grep -q -e '-A INPUT -p udp -m udp --dport 443 -j REJECT --reject-with icmp-port-unreachable'; then
    echo "UDP 443 REJECT: Pass."
fi

exit
