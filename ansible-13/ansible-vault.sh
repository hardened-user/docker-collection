#!/bin/bash
docker run -it --rm --network host --name ansible-13-vault-$RANDOM \
  -v $(pwd):/ansible \
  -v /tmp:/tmp \
  ansible:13 ansible-vault $@
