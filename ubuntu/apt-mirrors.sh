#!/usr/bin/env bash
set -euf -o pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../utils/bash-utils.sh"

# A fast mirror in Sydney
mirror="http://ubuntu.mirror.serversaustralia.com.au/ubuntu/"


log "Updating /etc/apt/sources.list with mirror [$mirror]"
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bkup
sudo sed -i "s#http://security.ubuntu.com/ubuntu/#$mirror#" /etc/apt/sources.list
sudo sed -i "s#http://archive.ubuntu.com/ubuntu/#$mirror#" /etc/apt/sources.list

log "Running apt-get update"
sudo apt-get update

log "Cleanning backed up sources.list"
sudo rm /etc/apt/sources.list.bkup