FROM alpine:3.9

ENV TERM="xterm"
ENV TZ="Europe/Moscow"

RUN apk update && \
    apk add --no-cache coreutils tzdata bash

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo "$TZ" > /etc/timezone

RUN apk add --no-cache python3 py3-pip && \
    pip3 --disable-pip-version-check install elasticsearch-curator

# http://veithen.io/2014/11/16/sigterm-propagation.html
CMD ["/bin/bash", "-c", "trap 'kill -TERM $PID' 0 1 2 3 9 15 SIGUSR1 SIGSTOP; sleep infinity & PID=$!; wait $PID"]
