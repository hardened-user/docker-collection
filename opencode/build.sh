#!/bin/bash
set -euo pipefail
# ----------------------------------------------------------------------------------------------------------------------
ALPINE_VERSION="3.24"
OPENCODE_VERSION="2.3.0"
docker build --pull --force-rm --network=host --progress=plain \
    --build-arg ALPINE_VERSION="${ALPINE_VERSION}" \
    --build-arg OPENCODE_VERSION="${OPENCODE_VERSION}" \
    --build-arg USER_UID="$(id -u)" \
    --build-arg USER_GID="$(id -g)" \
    -t "hardeneduser/opencode:latest" . "$@"
