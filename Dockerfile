FROM alpine:latest

# NOTE: port numbers are int, other values are str.
# Therefore, escaping quotes is necessary for these to work
# HTTPS tunnel config
ENV HTTPS_IP=""
ENV HTTPS_PORT=""

# SOCKS5 config
ENV SOCKS_IP=\"127.0.0.1\"
ENV SOCKS_PORT="7777"

# Auth
ENV PROXY_USER=""
ENV PROXY_PASS=""

RUN apk update
RUN apk add gettext go

ADD . /proxy
WORKDIR /proxy
RUN go mod tidy
RUN go build
RUN mv config.json old-config.json

CMD envsubst < old-config.json > config.json && ./socks-over-https
