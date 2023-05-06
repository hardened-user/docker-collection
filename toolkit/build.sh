#!/bin/bash
set -eu
###############################################################################
docker build --pull --force-rm -t "hardeneduser/toolkit:latest" .
