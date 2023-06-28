#!/bin/bash
set -eu
###############################################################################
docker build --pull --force-rm --progress=plain \
    --build-arg USER_NAME=${USER} \
    --build-arg USER_UID=$(id -u) \
    --build-arg USER_GID=$(id -g) \
    -t "ansible:7" .
