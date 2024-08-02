FROM alpine:3.19

ENV TZ="Europe/Moscow"


### APK packages
RUN apk add --no-cache bash busybox-extras ca-certificates openssh \
    bind-tools iputils tcpdump \
    nano rsync curl wget jq \
    postgresql && \
    rm -rf /var/cache/apk/*

RUN apk add --no-cache g++ python3 py3-pip && \
    rm -rf /var/cache/apk/*

### Entrypoint
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
