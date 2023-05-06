#!/bin/bash
set -eu
###############################################################################
docker build --pull --force-rm -t "zabbix40-server-pgsql:latest" .
