#!/bin/bash
set -euo pipefail
# ----------------------------------------------------------------------------------------------------------------------
ALPINE_VERSION="3.22"
docker build --pull --force-rm --network=host --progress=plain \
    --build-arg ALPINE_VERSION="${ALPINE_VERSION}" \
    --build-arg USER_UID="10001" \
    --build-arg USER_GID="10001" \
    -t "hardeneduser/tinyproxy:latest" . $@
TINYPROXY_VERSION=$(docker run --rm hardeneduser/tinyproxy:latest apk list -I tinyproxy | awk -F '[- ]' '/tinyproxy/ {print $2}')
docker tag "hardeneduser/tinyproxy:latest" "hardeneduser/tinyproxy:${TINYPROXY_VERSION}"
echo "hardeneduser/tinyproxy:${TINYPROXY_VERSION}"
