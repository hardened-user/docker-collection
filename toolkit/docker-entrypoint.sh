#!/bin/bash
# ----------------------------------------------------------------------------------------------------------------------
if [ -z "$@" ]; then
  # starting cmd
  exec /bin/bash -c "sleep infinity";
else
  # overriding cmd (example: /bin/bash)
  exec $@;
fi
