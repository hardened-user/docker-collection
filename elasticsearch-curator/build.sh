#!/bin/bash
set -eu
###############################################################################
docker build --pull --force-rm -t "elasticsearch-curator:latest" .
