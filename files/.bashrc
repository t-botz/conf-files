#!/usr/bin/env bash

# Tune History
HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth
shopt -s histappend
# check the window size after each command
shopt -s checkwinsize

# Aliases
alias ll='ls -alFh'
alias tf=terraform

# Enable Completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Starship - https://starship.rs/
eval "$(starship init bash)"

# direnv - https://direnv.net/
eval "$(direnv hook bash)"

# fnm - https://github.com/Schniz/fnm
eval "$(fnm env)"

# pyenv - https://github.com/pyenv/pyenv#set-up-your-shell-environment-for-pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

