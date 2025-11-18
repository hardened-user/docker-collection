#!/bin/bash
docker run -it --rm --network host --name ansible-12-galaxy \
  -v $(pwd):/ansible \
  ansible:12 ansible-galaxy $@
