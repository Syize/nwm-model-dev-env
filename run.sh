#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"${SCRIPT_DIR}/generate-mounts.sh"

sudo docker compose \
    -f "${SCRIPT_DIR}/docker-compose.yml" \
    -f "${SCRIPT_DIR}/docker-compose.mounts.yml" \
    up -d --force-recreate

echo "================================"
echo "Container status:"
sudo docker compose \
    -f "${SCRIPT_DIR}/docker-compose.yml" \
    -f "${SCRIPT_DIR}/docker-compose.mounts.yml" \
    ps
echo "================================"
echo "Container logs:"
sudo docker compose \
    -f "${SCRIPT_DIR}/docker-compose.yml" \
    -f "${SCRIPT_DIR}/docker-compose.mounts.yml" \
    logs
