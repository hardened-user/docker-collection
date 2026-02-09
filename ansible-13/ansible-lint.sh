#!/bin/bash
docker run -it --rm --network host --name ansible-13-lint \
  -v $(pwd):/ansible \
  ansible:13 ansible-lint $@
