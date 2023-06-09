#!/usr/bin/env bash

if [ -n "${BASH_UTILS_LOADED:-}" ]; then
  return 0
fi

BASH_UTILS_LOADED=1
UTILS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJ_DIR=$(dirname "$UTILS_DIR")

nicedate() {
    date +'%Y-%m-%d %H:%M:%S'
}

log() { 
    echo -e "\e[33m$(nicedate)\e[0m $*"
}
logerr() { 
    echo -e "\e[31m$(nicedate)\e[0m $*"  >&2
}