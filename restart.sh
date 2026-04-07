#!/usr/bin/env bash
set -euo pipefail

docker compose down
docker compose up -d --build
docker exec -it mercurjs-dev bash
