#!/bin/bash
set -eu

mkdir -p /var/run/sshd

HOST_KEY_DIR=/etc/ssh/keys
mkdir -p "${HOST_KEY_DIR}"
chmod 700 "${HOST_KEY_DIR}"

if [ ! -f "${HOST_KEY_DIR}/ssh_host_ed25519_key" ]; then
    ssh-keygen -t ed25519 -f "${HOST_KEY_DIR}/ssh_host_ed25519_key" -N ''
fi

if [ ! -f "${HOST_KEY_DIR}/ssh_host_rsa_key" ]; then
    ssh-keygen -t rsa -b 4096 -f "${HOST_KEY_DIR}/ssh_host_rsa_key" -N ''
fi

exec /usr/sbin/sshd -D -e
