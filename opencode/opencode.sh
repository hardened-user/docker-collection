#!/bin/bash
# ----------------------------------------------------------------------------------------------------------------------
docker run -it --rm --network host --name opencode-$RANDOM \
  -v "$(pwd):/workspace" \
  -v "${HOME}/.opencode/config:/home/opencode/.config/opencode:rw" \
  -v "${HOME}/.opencode/share:/home/opencode/.local/share/opencode:rw" \
  -v "${HOME}/.opencode/tmp:/tmp:rw" \
  hardeneduser/opencode:latest "$@"
