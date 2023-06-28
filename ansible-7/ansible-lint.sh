#!/bin/bash
docker run -it --rm --network host --name ansible-7-lint \
  -v $(pwd):/ansible \
  ansible:7 ansible-lint $@
