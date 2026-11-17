ARG ALPINE_VERSION="latest"
FROM alpine:${ALPINE_VERSION}

ARG OPENCODE_VERSION
ARG USER_NAME=opencode
ARG USER_UID=1000
ARG USER_GID=1000
ARG WORKDIR=/workspace

ENV TERM="xterm"
ENV TZ="UTC"
ENV USER_NAME="${USER_NAME}"

### APK packages
RUN apk update && \
    apk add bash tzdata ca-certificates openssh-client su-exec sudo \
        libstdc++ libgcc ripgrep \
        curl wget git github-cli jq yq less \
        helm postgresql-client \
        python3 py3-pip py3-requests py3-yaml py3-ruamel.yaml py3-pillow && \
    rm -rf /var/cache/apk/*

### Download OpenCode
RUN wget -nv "https://github.com/anomalyco/opencode/releases/download/v${OPENCODE_VERSION}/opencode-linux-x64-musl.tar.gz" -O /tmp/opencode-linux-x64-musl.tar.gz && \
    ls -lah /tmp/opencode-linux-x64-musl.tar.gz && \
    tar xfv /tmp/opencode-linux-x64-musl.tar.gz -C /usr/local/bin && \
    rm /tmp/opencode-linux-x64-musl.tar.gz

### Add user
RUN addgroup -g "${USER_GID}" "${USER_NAME}" && \
    adduser -u "${USER_UID}" -G "${USER_NAME}" -s /bin/bash -D "${USER_NAME}" && \
    mkdir -p "${WORKDIR}" && chown "${USER_NAME}:${USER_NAME}" "${WORKDIR}" && \
    mkdir -p "$(getent passwd "${USER_NAME}" | cut -d: -f6)/.config/opencode" && \
    mkdir -p "$(getent passwd "${USER_NAME}" | cut -d: -f6)/.local/share/opencode" && \
    chown -R "${USER_NAME}:${USER_NAME}" "$(getent passwd "${USER_NAME}" | cut -d: -f6)"

### Allow the user to manage packages via apk without a password
RUN echo "${USER_NAME} ALL=(root) NOPASSWD: /sbin/apk" > "/etc/sudoers.d/${USER_NAME}" && \
    chmod 440 "/etc/sudoers.d/${USER_NAME}"

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
WORKDIR "${WORKDIR}"
