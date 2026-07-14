#!/bin/bash
# ----------------------------------------------------------------------------------------------------------------------
docker run -it --rm --network host --name claude-$RANDOM \
  -v "$(pwd):/workspace" \
  -v "${HOME}/.claude:/.claude" \
  -e "CLAUDE_CODE_OAUTH_TOKEN=sk-ant-************" \
  -e "DISABLE_TELEMETRY=1" \
  -e "DISABLE_ERROR_REPORTING=1" \
  hardeneduser/claude-code:latest $@
