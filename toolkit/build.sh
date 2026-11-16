#!/bin/bash
set -euo pipefail
###############################################################################
ALPINE_VERSION="3.22"
docker build --pull --force-rm --network=host --progress=plain \
   --build-arg ALPINE_VERSION="${ALPINE_VERSION}" \
   -t "hardeneduser/toolkit:latest" . "$@"
