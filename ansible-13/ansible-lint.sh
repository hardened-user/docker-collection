#!/bin/bash
docker run -it --rm --network host --name ansible-13-lint-$RANDOM \
  -v $(pwd):/ansible \
  hardeneduser/ansible:13 ansible-lint $@
