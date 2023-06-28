#!/bin/bash
docker run -it --rm --network host --name ansible-7-playbook \
  -v $(pwd):/ansible \
  -v ~/.ssh:/home/${USER}/.ssh:ro \
  -v /tmp:/tmp \
  ansible:7 ansible-playbook $@
