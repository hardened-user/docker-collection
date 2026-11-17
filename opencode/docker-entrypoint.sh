#!/bin/bash
set -euo pipefail
# ----------------------------------------------------------------------------------------------------------------------
if [[ "${1:-}" =~ ^(/.*/)?(ba)?sh ]]; then
  # override cmd (example: docker run image /bin/bash)
  exec su-exec "${USER_NAME}" "$@"
else
  # run default cmd
  chown "${USER_NAME}:${USER_NAME}" "$(getent passwd "${USER_NAME}" | cut -d: -f6)/.config/opencode"
  chown "${USER_NAME}:${USER_NAME}" "$(getent passwd "${USER_NAME}" | cut -d: -f6)/.local/share/opencode"
  exec su-exec "${USER_NAME}" /usr/local/bin/opencode "$@"
fi
