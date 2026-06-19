#!/bin/bash
set -eu
# ----------------------------------------------------------------------------------------------------------------------
VERSION="3.16.1"
# shellcheck disable=SC2068
docker build --pull --force-rm --progress=plain \
    --build-arg VERSION="${VERSION}" \
    --build-arg USER_UID="$(id -u)" \
    --build-arg USER_GID="$(id -g)" \
    -t "hardeneduser/helm:${VERSION}" -t "hardeneduser/helm:3" . $@
