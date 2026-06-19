#!/bin/bash
# ----------------------------------------------------------------------------------------------------------------------
# shellcheck disable=SC2068,SC2199
if [[ -z "$@" ]]; then
  # starting cmd
  exec python3 start.py;
else
  # overriding cmd (example: /bin/bash)
  exec $@;
fi
