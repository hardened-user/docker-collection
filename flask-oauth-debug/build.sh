#!/bin/bash
set -eu
# ----------------------------------------------------------------------------------------------------------------------
docker build --pull --force-rm --network=host --progress=plain \
    --build-arg USER_UID=$(id -u) \
    --build-arg USER_GID=$(id -g) \
    -t "hardeneduser/flask-oauth-debug:latest" .
