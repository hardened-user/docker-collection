#!/bin/bash
set -o pipefail
set -eu
###############################################################################
if [[ -z "$@" ]]; then
    # starting cmd
    chown -R zabbix:zabbix /etc/zabbix
    exec su zabbix -s "/bin/bash" -c "/usr/sbin/zabbix_proxy --foreground -c /etc/zabbix/zabbix_proxy.conf"
else
    # cutsom cmd (example: /bin/bash)
    exec "$@"
fi
