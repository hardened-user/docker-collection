FROM python:3.12-alpine

ARG USER_NAME=flask
ARG USER_UID=1000
ARG USER_GID=1000

ENV TERM="xterm"
ENV TZ="Europe/Moscow"

ENV PYTHONDONTWRITEBYTECODE="1"
ENV PYTHONUNBUFFERED="1"
ENV PYTHONIOENCODING="utf8"

### APK packages
RUN apk update && \
    apk add tzdata bash && \
    rm -rf /var/cache/apk/*

### Add user
RUN addgroup -g "${USER_GID}" "${USER_NAME}" && \
    adduser -u "${USER_UID}" -G "${USER_NAME}" -s /bin/sh -D "${USER_NAME}" && \
    mkdir /flask

### Python packages
COPY requirements.txt /
RUN pip3 --disable-pip-version-check install -r /requirements.txt

### Project files
COPY src /flask


USER ${USER_NAME}
WORKDIR /flask

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8080/tcp
