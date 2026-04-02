#!/bin/bash
set -eu
###############################################################################
export MICROSOCKS_RELEASE="1.0.5"

docker build --pull --force-rm --progress=plain \
    --build-arg "MICROSOCKS_RELEASE=${MICROSOCKS_RELEASE}" \
    -t "microsocks:${MICROSOCKS_RELEASE}" -t "hardeneduser/microsocks:${MICROSOCKS_RELEASE}" .
