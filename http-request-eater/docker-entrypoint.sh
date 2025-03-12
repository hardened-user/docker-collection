#!/bin/bash
# ----------------------------------------------------------------------------------------------------------------------
if [[ -z "$@" ]]; then
  # starting cmd
  exec python3 start.py;
else
  # overriding cmd (example: /bin/bash)
  exec $@;
fi
