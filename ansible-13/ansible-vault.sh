#!/bin/bash
docker run -it --rm --network host --name ansible-13-vault \
  -v $(pwd):/ansible \
  -v /tmp:/tmp \
  ansible:13 ansible-vault $@
