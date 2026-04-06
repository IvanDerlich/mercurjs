#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="mercurjs"
CONTAINER_NAME="mercurjs-dev"

docker build --progress=plain -t "$IMAGE_NAME" .
docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true
docker run -d --name "$CONTAINER_NAME" "$IMAGE_NAME"
docker exec -it "$CONTAINER_NAME" bash