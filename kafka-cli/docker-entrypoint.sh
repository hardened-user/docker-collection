#!/bin/bash
export LC_ALL="C.UTF-8"
export LANG="C.UTF-8"
set -u
#------------------------------------------------------------------------------------
if [ -z "$@" ]; then
    # starting cmd
   exec /bin/bash -c "sleep infinity";
else
    # cutsom cmd (example: /bin/bash)
    exec $@;
fi
