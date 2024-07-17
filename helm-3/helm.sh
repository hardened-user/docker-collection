#!/bin/bash
docker run -ti --rm --network host --name helm-3-$RANDOM \
    -v "$(pwd)":/apps \
    -v /opt/helm3:/home/helm \
    -v "${HOME}/.kube":/home/helm/.kube \
    -e SOPS_AGE_KEY="${SOPS_AGE_KEY}" \
    helm:3 ${@}
