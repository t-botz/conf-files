#!/usr/bin/env zsh

# brew Shell Completion -- https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# Starship - https://starship.rs/
eval "$(starship init zsh)"

# direnv - https://direnv.net/
eval "$(direnv hook zsh)"

# fnm - https://github.com/Schniz/fnm
eval "`fnm env`"

# pyenv - https://github.com/pyenv/pyenv#set-up-your-shell-environment-for-pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


# Terraform
alias tf=terraform

