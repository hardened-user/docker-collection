FROM alpine

RUN apk update && \
    apk add --no-cache shadow tzdata bash openssh-client

ENV TZ="Europe/Moscow"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo "$TZ" >  /etc/timezone

ENV HOME="/home/sshfwd"
ENV USER="sshfwd"
RUN groupadd -g 1000 "${USER}" && \
    useradd -r --uid 1000 --gid 1000 -m -d "${HOME}" -s /sbin/nologin "${USER}" && \
    mkdir "${HOME}"/.ssh && \
    chmod 750 "${HOME}"/.ssh

COPY ./files/id_rsa "${HOME}"/.ssh/
RUN chown -R "${USER}":"${USER}" "${HOME}" && \
    chmod 600 "${HOME}"/.ssh/id_rsa

COPY ./files/ssh_config /etc/ssh/ssh_config
COPY ./docker-entrypoint.sh /

USER "${USER}"

ENTRYPOINT ["/docker-entrypoint.sh"]
