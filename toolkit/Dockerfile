FROM alpine:3.16

ENV TZ="Europe/Moscow"


### APK packages
RUN apk add --no-cache bash busybox-extras ca-certificates iputils bind-tools curl wget jq nano && \
    rm -rf /var/cache/apk/*

RUN apk add --no-cache g++ python3 py3-pip && \
    rm -rf /var/cache/apk/*

### Entrypoint
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
