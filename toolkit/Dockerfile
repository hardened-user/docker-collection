FROM alpine:3.20

ENV TZ="Europe/Moscow"


### APK packages
RUN apk add --no-cache \
      bash busybox-extras ca-certificates openssh \
      bind-tools iputils tcpdump \
      nano rsync curl wget jq \
      postgresql \
      python3 py3-pip py3-requests py3-psycopg2 && \
    rm -rf /usr/sbin/nanddump /usr/sbin/nandwrite && \
    rm -rf /var/cache/apk/*


### Entrypoint
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
