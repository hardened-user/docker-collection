#!/bin/bash
set -eu
###############################################################################
docker build --pull --force-rm -t "zabbix40-proxy-sqlite3:latest" .
