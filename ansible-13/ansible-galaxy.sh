#!/bin/bash
docker run -it --rm --network host --name ansible-13-galaxy \
  -v $(pwd):/ansible \
  ansible:13 ansible-galaxy $@
