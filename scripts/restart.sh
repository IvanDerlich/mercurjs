#!/usr/bin/env bash
set -euo pipefail

docker compose down -v
# docker compose build --no-cache
docker compose up -d --build
docker exec -it mercurjs-dev bash
