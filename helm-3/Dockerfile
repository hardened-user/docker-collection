FROM alpine/helm:3.16.1

ARG USER_NAME=helm
ARG USER_UID=1000
ARG USER_GID=1000
ARG WORKDIR=/apps

ENV TERM="xterm"
ENV TZ="Europe/Moscow"

### APK packages
RUN apk update && \
    apk add sops && \
    rm -rf /var/cache/apk/*

### Add user
RUN addgroup -g "${USER_GID}" "${USER_NAME}" && \
    adduser -u "${USER_UID}" -G "${USER_NAME}" -s /bin/sh -D "${USER_NAME}" && \
    chown "${USER_NAME}:${USER_NAME}" "${WORKDIR}" && \
    # additional groups for file access permission (optional)
    addgroup -g 987 987 && addgroup "${USER_NAME}" 987 && \
    addgroup -g 998 998 && addgroup "${USER_NAME}" 998

USER "${USER_NAME}"
WORKDIR "${WORKDIR}"

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
