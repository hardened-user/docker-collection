#!/bin/bash
docker run -it --rm --network host --name ansible-12-vault \
  -v $(pwd):/ansible \
  -v /tmp:/tmp \
  ansible:12 ansible-vault $@
