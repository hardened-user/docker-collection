#!/bin/bash
set -eu
###############################################################################
docker build --pull --force-rm -t "ssh-forwarding:latest" .
