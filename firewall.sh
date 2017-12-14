iptables -A PREROUTING -d 192.168.1.11 -t mangle -j MARK --set-mark 1
iptables -A PREROUTING -d 192.168.1.22 -t mangle -j MARK --set-mark 2

ip rule add fwmark 1 table 1
ip rule add fwmark 2 table 2

ip route add default via 192.168.1.11 table 1
ip route add default via 192.168.1.22 table 2


ip rule add from 192.168.1.11 lookup 1
ip rule add from 192.168.1.22 lookup 2

iptables -t nat -A OUTPUT -d 192.168.1.11 -p tcp --dport 80 -j DNAT --to 192.168.1.254:80
iptables -t nat -A OUTPUT -d 192.168.1.22 -p tcp --dport 80 -j DNAT --to 192.168.1.254:80

iptables -t nat -A OUTPUT -d 192.168.1.11 -p tcp --dport 3333 -j DNAT --to 192.168.1.254:3333
iptables -t nat -A OUTPUT -d 192.168.1.22 -p tcp --dport 3333 -j DNAT --to 192.168.1.254:3333