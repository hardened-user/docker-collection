#!/bin/bash
docker run -it --rm --network host --name ansible-7-vault \
  -v $(pwd):/ansible \
  -v /tmp:/tmp \
  ansible:7 ansible-vault $@

