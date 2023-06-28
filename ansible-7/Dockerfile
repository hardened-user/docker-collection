FROM python:3.10-alpine

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
    apk add gcc libc-dev && \
    rm -rf /var/cache/apk/*

### Add user
RUN addgroup -g "${USER_GID}" "${USER_NAME}" && \
    adduser -u "${USER_UID}" -G "${USER_NAME}" -s /bin/sh -D "${USER_NAME}" && \
    mkdir /ansible

### Python packages
COPY requirements.txt /
RUN pip3 --disable-pip-version-check install -r /requirements.txt

USER ${USER_NAME}
WORKDIR /ansible

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]


### ruamel.yaml.clib-0.2.7.tar.gz
# gcc libc-dev

### ansible-lint
# git
