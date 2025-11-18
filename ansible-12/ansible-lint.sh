#!/bin/bash
docker run -it --rm --network host --name ansible-12-lint \
  -v $(pwd):/ansible \
  ansible:12 ansible-lint $@
