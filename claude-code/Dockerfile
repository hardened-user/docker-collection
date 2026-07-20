ARG NODE_VERSION=24
FROM node:${NODE_VERSION}-alpine

ARG USER_NAME=claude
ARG USER_UID=1000
ARG USER_GID=1000
ARG WORKDIR=/workspace

ENV TERM="xterm"
ENV TZ="Europe/Moscow"
ENV USER_NAME="${USER_NAME}"
ENV DISABLE_AUTOUPDATER=1
ENV CLAUDE_CONFIG_DIR="/.claude"

### APK packages
ADD https://downloads.claude.ai/keys/claude-code.rsa.pub /etc/apk/keys/claude-code.rsa.pub
RUN echo "https://downloads.claude.ai/claude-code/apk/stable" >> /etc/apk/repositories && \
    apk update && \
    apk add bash tzdata ca-certificates openssh-client su-exec sudo \
        claude-code curl git ripgrep jq less \
        python3 py3-pip py3-requests py3-ruamel.yaml && \
    rm -rf /var/cache/apk/*

### Add user
RUN getent passwd "${USER_UID}" && deluser --remove-home "$(getent passwd "${USER_UID}" | cut -d: -f1)" || true; \
    addgroup -g "${USER_GID}" "${USER_NAME}" && \
    adduser -u "${USER_UID}" -G "${USER_NAME}" -s /bin/bash -D "${USER_NAME}" && \
    mkdir -p "${WORKDIR}" && chown "${USER_NAME}:${USER_NAME}" "${WORKDIR}" && \
    mkdir -p "${CLAUDE_CONFIG_DIR}" && chown "${USER_NAME}:${USER_NAME}" "${CLAUDE_CONFIG_DIR}"

### Allow the user to manage packages via apk without a password
RUN echo "${USER_NAME} ALL=(root) NOPASSWD: /sbin/apk" > "/etc/sudoers.d/${USER_NAME}" && \
    chmod 440 "/etc/sudoers.d/${USER_NAME}"

WORKDIR "${WORKDIR}"

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
