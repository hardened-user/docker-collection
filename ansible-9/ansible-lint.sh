#!/bin/bash
docker run -it --rm --network host --name ansible-9-lint \
  -v $(pwd):/ansible \
  ansible:9 ansible-lint $@
