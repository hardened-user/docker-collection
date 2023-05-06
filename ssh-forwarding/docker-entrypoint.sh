#!/bin/bash
set -u
###############################################################################
if [[ -z "$@" ]]; then
    # starting cmd
    while true; do
        echo "=====" $(date '+%Y/%m/%d %H:%M:%S') "=====";
        ssh -N ${SSH_ARGS};
        echo "";
        sleep 3;
    done
else
    # cutsom cmd (example: /bin/bash)
    exec $@;
fi
