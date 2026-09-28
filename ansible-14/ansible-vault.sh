#!/bin/bash
docker run -it --rm --network host --name ansible-14-vault-$RANDOM \
  -v "$(pwd)":/ansible \
  -v /tmp:/tmp \
  hardeneduser/ansible:14 ansible-vault "$@"
