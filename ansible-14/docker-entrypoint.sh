#!/bin/bash
set -euo pipefail
# ----------------------------------------------------------------------------------------------------------------------
if [[ $# -gt 0 ]]; then
  # overriding cmd (example: docker run image /bin/bash)
  exec "$@"
fi
# starting cmd
exec /bin/bash
