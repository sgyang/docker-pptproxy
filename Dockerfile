FROM alpine:edge
MAINTAINER Seonggi Yang <seonggi.yang@gmail.com>

RUN apk add --no-cache \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
    pptpclient dante-server
ADD entrypoint.sh /entrypoint.sh
ADD sockd.conf /etc/sockd.conf
EXPOSE 1080
ENTRYPOINT ["/entrypoint.sh"]
