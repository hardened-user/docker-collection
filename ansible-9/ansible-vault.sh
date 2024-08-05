#!/bin/bash
docker run -it --rm --network host --name ansible-9-vault \
  -v $(pwd):/ansible \
  -v /tmp:/tmp \
  ansible:9 ansible-vault $@
