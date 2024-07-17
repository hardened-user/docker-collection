#!/bin/bash
# ------------------------------------------------------------------------------
if [[ "$@" =~ ^(/|(ba)?sh) ]]; then
  # overriding cmd (example: /bin/bash)
  exec $@;
else
  # starting app
  exec /usr/bin/helm $@;
fi
