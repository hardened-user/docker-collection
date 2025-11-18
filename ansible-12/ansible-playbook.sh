#!/bin/bash
docker run -it --rm --network host --name ansible-12-playbook \
  $(test -f .env && echo "--env-file .env") \
  -v $(pwd):/ansible \
  -v ~/.ssh:/home/ansible/.ssh:ro \
  -v /tmp:/tmp \
  ansible:12 ansible-playbook $@
