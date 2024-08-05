#!/bin/bash
docker run -it --rm --network host --name ansible-9-playbook \
  -v $(pwd):/ansible \
  -v ~/.ssh:/home/ansible/.ssh:ro \
  -v /tmp:/tmp \
  ansible:9 ansible-playbook $@
