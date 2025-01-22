#!/bin/bash
# ----------------------------------------------------------------------------------------------------------------------
if [[ -z "$@" ]]; then
  # starting cmd
  exec /bin/bash
else
  # overriding cmd (example: /bin/bash)
  exec $@;
fi
