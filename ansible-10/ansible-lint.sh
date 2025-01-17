#!/bin/bash
docker run -it --rm --network host --name ansible-10-lint \
  -v $(pwd):/ansible \
  ansible:10 ansible-lint $@
