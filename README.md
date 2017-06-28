# pptproxy

A simple container which provides SOCKS5 proxy over PPTP VPN.

## Environment variables

- SERVER: PPTP server address
- USERNAME: PPTP client username
- PASSWORD: PPTP client password

## Examples

Run a proxy container named `proxy00` and obtain the IP address:
```
$ docker run --privileged -d \
    -e SERVER=us.hma.rocks \
    -e USERNAME=YOUR_HMA_USERNAME_HERE \
    -e PASSWORD=YOUR_HMA_PASSWORD_HERE \
    --name proxy00 \
    sgyang/pptproxy:latest
17e7d8869cccae6cccf5b28e28d87c6d3ebe0fd75044a23efd9c976ca0f1312e
$ docker inspect --format '{{ .NetworkSettings.IPAddress }}' proxy00
172.17.0.2
```

Then, try:
```
$ curl ifconfig.co
(Your current IP address)
$ curl -x socks5://172.17.0.2:1080 ifconfig.co
(VPN powered address)
```
