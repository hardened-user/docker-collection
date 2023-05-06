#!/bin/bash
docker run --name="ssh-forwarding" -t -d --restart=on-failure \
    --net="host" \
    -e SSH_ARGS="-R2022:127.0.0.1:22 user@host" \
    ssh-forwarding
