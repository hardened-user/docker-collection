#!/bin/bash
set -eu
###############################################################################
docker build --pull --force-rm --progress=plain \
   -t "hardeneduser/toolkit:latest" .
