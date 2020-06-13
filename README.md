# up-ca-tp-integrador

## Getting host ready
Rename host with sudo hostnamectl set-hostname <name> and then
Change the file in /etc/hosts

## Setting policy
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

## allow loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

## allow firewall to access internet
iptables -A INPUT -i eth0 -j ACCEPT
iptables -A OUTPUT -o eth0 -j ACCEPT


## do not allow cliente-03 access to java server
iptables -A FORWARD -s 192.168.20.3 -d 192.168.10.3  -j DROP

## Allowing cliente-03 to acces internet
iptables -A FORWARD -s 192.168.20.3 -j ACCEPT
iptables -A FORWARD -d 192.168.20.3 -j ACCEPT
iptables -t nat -A POSTROUTING -j MASQUERADE


## Allowing cliente-02 to access the firewall with ssh
For this to work it was necessary to install ssh with sudo apt install ssh
iptables -A INPUT -s 192.168.20.2 -p tcp -m tcp  --dport 22 -j ACCEPT
iptables -A OUTPUT -s 192.168.20.1 -d 192.168.20.2 -p tcp -m tcp --sport 22 -j ACCEPT

## Allow cliente-04 to access java server
iptables -A FORWARD -s 192.168.20.4 -p tcp -m tcp  --dport 8080 -j ACCEPT
iptables -A FORWARD -s 192.168.10.3 -d 192.168.20.4 -p tcp -m tcp  -j ACCEPT

## Dhcp in dhcp-server
Change files /etc/defaults/isc-dhcp-server
and file etc/dhcp/dhcp/dhcpd.conf
needed to restart dhcp service with 
/etc/init.d/isc-server restart


