FROM alpine:3.22 AS builder

ARG MICROSOCKS_REPOURL="https://github.com/rofl0r/microsocks.git"
ARG MICROSOCKS_RELEASE=latest

RUN apk update && \
    apk add --no-cache build-base git

RUN git clone --depth 1 --branch "v${MICROSOCKS_RELEASE}" "${MICROSOCKS_REPOURL}" /tmp/microsocks && \
    cd /tmp/microsocks && \
    make && \
    make install


FROM alpine:3.22

ARG MICROSOCKS_REPOURL="https://github.com/rofl0r/microsocks.git"
ARG MICROSOCKS_RELEASE=latest

ENV TERM="xterm"
ENV TZ="Europe/Moscow"
ENV MICROSOCKS_REPOURL=${MICROSOCKS_REPOURL}
ENV MICROSOCKS_RELEASE=${MICROSOCKS_RELEASE}

### APK packages
RUN apk update && \
    apk add --no-cache tzdata bash curl && \
    rm -rf /var/cache/apk/*

COPY --from=builder --chmod=755 /usr/local/bin/microsocks /usr/bin/microsocks
COPY --chmod=755 ./docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
