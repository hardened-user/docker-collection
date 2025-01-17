#!/bin/bash
docker run -it --rm --network host --name ansible-10-galaxy \
  -v $(pwd):/ansible \
  ansible:10 ansible-galaxy $@
