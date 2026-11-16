ARG ALPINE_VERSION="latest"
FROM alpine:${ALPINE_VERSION}

ENV TZ="Europe/Moscow"


### APK packages
RUN apk add --no-cache \
      bash busybox-extras ca-certificates openssh openssl \
      bind-tools iputils tcpdump nmap-ncat \
      s3cmd rsync curl wget \
      tar pigz xz pixz \
      nano jq yq \
      postgresql \
      python3 py3-pip py3-requests py3-psycopg2 && \
    rm -rf /usr/sbin/nanddump /usr/sbin/nandwrite && \
    rm -rf /var/cache/apk/*


### Entrypoint
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
