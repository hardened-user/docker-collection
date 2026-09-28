#!/bin/bash
# shellcheck disable=SC2046
docker run -it --rm --network host --name ansible-14-playbook-$RANDOM \
  $(test -f .env && echo '--env-file .env') \
  -v "$(pwd)":/ansible \
  -v /tmp:/tmp \
  -v ~/.ssh:/home/ansible/.ssh:ro \
  -v ~/github/ansible-collection:/home/lexa/github/ansible-collection:ro \
  hardeneduser/ansible:14 ansible-playbook "$@"
