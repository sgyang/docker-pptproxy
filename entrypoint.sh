#!/bin/sh

sysctl -w net.ipv4.conf.all.forwarding=1
sysctl -w net.ipv6.conf.all.forwarding=1

cat > /etc/ppp/peers/vpn <<_EOF_
pty "pptp ${SERVER} --nolaunchpppd"
lock
noauth
refuse-pap
refuse-eap
refuse-chap
refuse-mschap
require-mppe-128
nobsdcomp
nodeflate
name "${USERNAME}"
password "${PASSWORD}"
_EOF_

cat > /etc/ppp/ip-up <<_EOF_
#!/bin/sh
ip route add 0.0.0.0/1 dev ppp0
ip route add 128.0.0.0/1 dev ppp0
_EOF_

cat > /etc/ppp/ip-down <<_EOF_
#!/bin/sh
ip route del 0.0.0.0/1 dev ppp0
ip route del 128.0.0.0/1 dev ppp0
_EOF_

# fooo
route add -net 192.168.0.0 netmask 255.255.0.0 gw 172.17.0.1

pon vpn debug dump logfd 2 updetach persist "$@"
exec sockd
