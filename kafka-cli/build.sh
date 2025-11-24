#!/bin/bash
set -eu
###############################################################################
docker build --pull --force-rm --network=host --progress=plain \
    --build-arg JAVA_VERSION=11 \
    --build-arg KAFKA_VERSION=3.5.2 \
    --build-arg SCALA_VERSION=2.13 \
    -t "hardeneduser/kafka-cli:3.5.2" $@ .
