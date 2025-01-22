#!/bin/bash
# ----------------------------------------------------------------------------------------------------------------------
if [[ "$@" =~ ^(/|(ba)?sh) ]]; then
  # overriding cmd (example: /bin/bash)
  exec $@;
else
  # starting cmd
  exec /usr/bin/helm $@;
fi
