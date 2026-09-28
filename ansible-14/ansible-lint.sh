#!/bin/bash
docker run -it --rm --network host --name ansible-14-lint-$RANDOM \
  -v "$(pwd)":/ansible \
  hardeneduser/ansible:14 ansible-lint $@
