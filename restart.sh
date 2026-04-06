#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="mercurjs"
CONTAINER_NAME="mercurjs-dev"

DOCKER_BUILDKIT=1 docker build -t "$IMAGE_NAME" .
docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true
docker run -d \
	--name "$CONTAINER_NAME" \
	--add-host=host.docker.internal:host-gateway \
	"$IMAGE_NAME"
docker exec -it "$CONTAINER_NAME" bash