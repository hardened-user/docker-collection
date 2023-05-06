#!/bin/bash
set -o pipefail
set -eu
###############################################################################
: ${DBHost:=127.0.0.1}
: ${DBUser:=postgres}
: ${DBPort:=5432}
: ${DBName:=zabbix}

PSQL="psql -h $DBHost -p $DBPort -U $DBUser -d $DBName"

create_db_schema_postgresql() {
    DBVERSION_TABLE_EXISTS=$($PSQL -A -q -t \
                            -c "SELECT 1 FROM pg_catalog.pg_class c JOIN pg_catalog.pg_namespace n ON n.oid =
                                c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'dbversion'" 2>/dev/null)
    if [ ! -n "${DBVERSION_TABLE_EXISTS}" ]; then
        stdbuf -o0 echo "[..] Creating '${DBName}' schema in PostgreSQL"
        zcat /usr/share/doc/zabbix-server-postgresql/create.sql.gz | $PSQL -q 1>/dev/null
    fi
}
###############################################################################
if [[ -z "$@" ]]; then
    # starting cmd
    { $PSQL -c "SELECT 1" 1>/dev/null && create_db_schema_postgresql; } || exit 1
    chown -R zabbix:zabbix /etc/zabbix
    exec su zabbix -s "/bin/bash" -c "/usr/sbin/zabbix_server --foreground -c /etc/zabbix/zabbix_server.conf"
else
    # cutsom cmd (example: /bin/bash)
    exec "$@"
fi
