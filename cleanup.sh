#!/bin/bash
docker ps -f "status=exited" -q | xargs -rn 1 docker rm
docker images -f "dangling=true" -q | xargs -rn 1 docker rmi
