#!/usr/bin/env bash
set -euf -o pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../utils/bash-utils.sh"

log "Runnning generic Ubuntu setup"

log "Change default behaviour of do-release-upgrade to all, not just LTS"
sudo cp "$PROJ_DIR/ubuntu/release-upgrades" /etc/update-manager/release-upgrades

"$PROJ_DIR"/ubuntu/apt-mirrors.sh

log "Install Utilities from apt"
sudo apt-get -y install \
    curl binutils git jq direnv shellcheck \
    wget gpg unzip build-essential

log "Install Starship"
curl -sS https://starship.rs/install.sh | sh -s - -f > /dev/null

log "Install fnm"
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell --install-dir /tmp
chmod +x /tmp/fnm && sudo chown root:root /tmp/fnm && sudo mv /tmp/fnm /usr/local/bin

log "Install pyenv"
if [ ! -d "$HOME/.pyenv" ]; then
    curl -fsSL https://pyenv.run | bash
fi

log "Copy dotfiles"
cd "$PROJ_DIR"/files
cp -r .config .bashrc .gitconfig "$HOME/"
cd -


log "Done! You should probably run \`source ~/.bashrc\`"