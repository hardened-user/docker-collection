#!/bin/bash
set -eu
###############################################################################
docker build --pull --force-rm -t "zabbix40-web-nginx:latest" .
