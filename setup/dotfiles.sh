#!/bin/sh
source ~/dotfiles/setup/functions.sh


dotfiles=(
zsh
bin
aliases
agignore
gitconfig
gitconfig.local
gitmessage
gvimrc
tmux.conf
zshenv
zshrc
vimrc.bundles
vimrc
vim
)

fancy_echo "Configuring neovim"
p10k configure
if command -v curl >/dev/null 2>&1; then
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/weiyunfei/nvimdots/HEAD/scripts/install.sh)"
else
	bash -c "$(wget -O- https://raw.githubusercontent.com/weiyunfei/nvimdots/HEAD/scripts/install.sh)"
fi

