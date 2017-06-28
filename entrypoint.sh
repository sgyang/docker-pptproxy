#!/bin/sh

cat > /etc/ppp/peers/vpn <<_EOF_
pty "pptp ${SERVER} --nolaunchpppd"
name "${USERNAME}"
password "${PASSWORD}"
remotename PPTP
require-mppe-128
file /etc/ppp/options.pptp
ipparam "vpn"
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

pon vpn debug dump logfd 2 updetach persist "$@"
exec sockd
