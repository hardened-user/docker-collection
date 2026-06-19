#!/bin/bash
# shellcheck disable=SC2164
cd "$(dirname "${0}")"
source .venv/bin/activate
source .env
./src/start.py
