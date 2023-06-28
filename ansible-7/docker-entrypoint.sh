#!/bin/bash
set -u
###############################################################################
if [[ -z "$@" ]]; then
    /bin/bash
else
    # cutsom cmd (example: /bin/bash)
    exec $@;
fi
