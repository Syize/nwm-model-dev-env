#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MOUNT_LIST="${SCRIPT_DIR}/mount/mount-list"
OUTPUT_FILE="${SCRIPT_DIR}/docker-compose.mounts.yml"

cat > "${OUTPUT_FILE}" <<EOF
services:
  numerical-model-dev:
    volumes:
EOF

if [[ ! -f "${MOUNT_LIST}" ]]; then
    echo "Mount list not found: ${MOUNT_LIST}" >&2
    exit 1
fi

while IFS= read -r raw_line || [[ -n "${raw_line}" ]]; do
    line="${raw_line#"${raw_line%%[![:space:]]*}"}"
    line="${line%"${line##*[![:space:]]}"}"

    if [[ -z "${line}" || "${line:0:1}" == "#" ]]; then
        continue
    fi

    if [[ ! -e "${line}" ]]; then
        echo "Mount source does not exist: ${line}" >&2
        exit 1
    fi

    target_name="$(basename "${line}")"
    target_path="/home/syize/Documents/${target_name}"
    printf "      - '%s:%s'\n" "${line}" "${target_path}" >> "${OUTPUT_FILE}"
done < "${MOUNT_LIST}"
