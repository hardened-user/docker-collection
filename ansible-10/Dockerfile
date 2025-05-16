FROM python:3.12-alpine

ARG USER_NAME=ansible
ARG USER_UID=1000
ARG USER_GID=1000

ENV TERM="xterm"
ENV TZ="Europe/Moscow"

ENV PYTHONDONTWRITEBYTECODE="1"
ENV PYTHONUNBUFFERED="1"
ENV PYTHONIOENCODING="utf8"

### APK packages
RUN apk update && \
    apk add tzdata bash openssh-client rsync git && \
    rm -rf /var/cache/apk/*

### Add user
RUN addgroup -g "${USER_GID}" "${USER_NAME}" && \
    adduser -u "${USER_UID}" -G "${USER_NAME}" -s /bin/sh -D "${USER_NAME}" && \
    mkdir /ansible

### Python packages
RUN --mount=type=bind,source=requirements.txt,target=/requirements.txt \
    pip3 --disable-pip-version-check install -r /requirements.txt

USER ${USER_NAME}
WORKDIR /ansible

### Ansible Galaxy
RUN --mount=type=bind,source=galaxy-collections.yaml,target=/galaxy-collections.yaml \
    ansible-galaxy collection install -r /galaxy-collections.yaml

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
