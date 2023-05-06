FROM zabbix/zabbix-web-nginx-pgsql:alpine-4.0-latest

ENV TERM="xterm"
ENV TZ="Europe/Moscow"
ENV PHP_TZ="Europe/Moscow"

RUN apk update && \
    apk add --no-cache shadow tzdata

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo "$TZ" >  /etc/timezone
