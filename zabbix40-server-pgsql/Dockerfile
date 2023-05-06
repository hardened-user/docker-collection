FROM zabbix/zabbix-server-pgsql:alpine-4.0-latest

ENV TERM="xterm"
ENV TZ="Europe/Moscow"

RUN apk update && \
    apk add --no-cache coreutils tzdata curl curl-dev python

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo "$TZ" >  /etc/timezone

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
