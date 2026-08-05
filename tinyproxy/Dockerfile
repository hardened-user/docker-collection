ARG ALPINE_VERSION="3.22"
FROM alpine:${ALPINE_VERSION}

ARG USER_NAME=tinyproxy
ARG USER_UID=10001
ARG USER_GID=10001
ARG WORKDIR=/

ENV TERM="xterm"
ENV TZ="UTC"
ENV TINYPROXY_CONFIG_FILE="/etc/tinyproxy/tinyproxy.conf"

### APK packages
RUN apk update && \
    apk add tzdata bash ca-certificates tinyproxy && \
    rm -rf /var/cache/apk/*

### Add user
RUN getent passwd "${USER_UID}" && deluser --remove-home "$(getent passwd "${USER_UID}" | cut -d: -f1)" || true; \
    getent passwd "${USER_NAME}" && deluser --remove-home "$(getent passwd "${USER_NAME}" | cut -d: -f1)" || true; \
    addgroup -g "${USER_GID}" "${USER_NAME}" && \
    adduser -u "${USER_UID}" -G "${USER_NAME}" -s /bin/bash -D "${USER_NAME}" && \
    chown -R "${USER_NAME}:${USER_NAME}" "$(dirname "${TINYPROXY_CONFIG_FILE}")" "/var/log/tinyproxy"

USER ${USER_NAME}
WORKDIR "${WORKDIR}"

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
