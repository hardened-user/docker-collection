#!/bin/bash
set -eu
###############################################################################
docker build --pull --force-rm -t "hardeneduser/vector:latest" .
