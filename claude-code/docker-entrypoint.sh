#!/bin/bash
set -eu
# ----------------------------------------------------------------------------------------------------------------------
chown "${USER_NAME}:${USER_NAME}" "${CLAUDE_CONFIG_DIR}"
chmod 700 "${CLAUDE_CONFIG_DIR}"
#
if [[ "${1:-}" =~ ^(/.*/)?(ba)?sh ]]; then
  # overriding cmd (example: /bin/bash)
  exec su-exec "${USER_NAME}" "$@"
else
  # starting cmd
  exec su-exec "${USER_NAME}" /usr/bin/claude
fi
