#!/usr/bin/env bash
set -euf -o pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../utils/bash-utils.sh"

log "Enable systemd for WSL"
sudo cp "$PROJ_DIR/ubuntu/wsl.conf" /etc/wsl.conf

"$PROJ_DIR/ubuntu/setup.sh"