#!/bin/bash
set -eu
# ----------------------------------------------------------------------------------------------------------------------
NODE_VERSION="24"
# shellcheck disable=SC2068
docker build --pull --force-rm --progress=plain \
    --build-arg NODE_VERSION="${NODE_VERSION}" \
    --build-arg USER_UID="$(id -u)" \
    --build-arg USER_GID="$(id -g)" \
    -t "hardeneduser/claude-code:latest" . $@
