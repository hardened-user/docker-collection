#!/bin/bash
set -euo pipefail
# ----------------------------------------------------------------------------------------------------------------------
if [[ "${1:-}" =~ ^(/.*/)?(ba)?sh ]]; then
  # override cmd (example: docker run image /bin/bash)
  exec su-exec "${USER_NAME}" "$@"
else
  # run default cmd
  chown "${USER_NAME}:${USER_NAME}" "${CLAUDE_CONFIG_DIR}"
  chmod 700 "${CLAUDE_CONFIG_DIR}"
  exec su-exec "${USER_NAME}" /usr/bin/claude "$@"
fi
