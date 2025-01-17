#!/bin/bash
docker run -it --rm --network host --name ansible-10-vault \
  -v $(pwd):/ansible \
  -v /tmp:/tmp \
  ansible:10 ansible-vault $@
