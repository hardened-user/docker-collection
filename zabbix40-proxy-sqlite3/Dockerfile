FROM zabbix/zabbix-proxy-sqlite3:alpine-4.0-latest

ENV TERM="xterm"
ENV TZ="Europe/Moscow"

RUN apk update && \
    apk add --no-cache coreutils tzdata curl curl-dev python

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo "$TZ" >  /etc/timezone

RUN mkdir /var/lib/zabbix/data && \
    chown zabbix:zabbix /var/lib/zabbix/data

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
