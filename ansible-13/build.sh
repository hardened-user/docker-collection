#!/bin/bash
set -eu
# ----------------------------------------------------------------------------------------------------------------------
# shellcheck disable=SC2068
docker build --pull --force-rm --progress=plain \
    --build-arg USER_UID="$(id -u)" \
    --build-arg USER_GID="$(id -g)" \
    -t "hardeneduser/ansible:13" . $@
