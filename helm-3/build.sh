#!/bin/bash
set -eu
###############################################################################
docker build --pull --force-rm --progress=plain \
    --build-arg USER_UID=$(id -u) \
    --build-arg USER_GID=$(id -g) \
    -t "helm:3" -t "hardeneduser/helm:3" .
