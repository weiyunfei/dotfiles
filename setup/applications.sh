#!/bin/sh
source ~/dotfiles/setup/functions.sh

if ! command -v brew >/dev/null; then
	fancy_echo "Installing Homebrew ..."
	curl -fsS \
		'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

	append_to_zshrc '# recommended by brew doctor'

	# shellcheck disable=SC2016
	append_to_zshrc 'export PATH="/usr/local/bin:$PATH"' 1

	export PATH="/usr/local/bin:$PATH"
fi

if brew list | grep -Fq brew-cask; then
	fancy_echo "Uninstalling old Homebrew-Cask ..."
	brew uninstall --force brew-cask
fi

brew update && brew install $(brew outdated)

fancy_echo "Installing CLI tools"
brew install openssl
brew install zsh
brew install zsh-completions
brew install bash
brew install bash-completion
brew install fzf
brew install the_silver_searcher
brew install wget

fancy_echo "Installing python and setting up Neovim"
brew install python
brew install python3
brew install git lazygit zoxide ripgrep fd yarn nvm make unzip neovim
# curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
# https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

fancy_echo "Setting up tmux"
brew install tmux
brew install reattach-to-user-namespace
brew install tree
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

fancy_echo "Setting up Node with NVM"
nvm install 18
nvm use 18

fancy_echo "Installing global npm packages"
npm install -g npm@latest
npm install -g npm-check-updates browser-sync

brew install chrome-cli
brew install git

brew tap caskroom/cask
brew cask install google-chrome
brew cask install iterm2
brew cask install github-desktop
# brew cask install dropbox
brew cask install divvy
brew cask install caffeine
brew cask install screenflow
brew cask install macdown

fancy_echo "Installing Misc Apps"
# brew cask install discord
brew cask install disk-inventory-x
brew cask install vlc

fancy_echo "Installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh
cp cargo/config ~/.cargo/config

fancy_echo "Configuring neovim"
p10k configure
if command -v curl >/dev/null 2>&1; then
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/weiyunfei/nvimdots/HEAD/scripts/install.sh)"
else
	bash -c "$(wget -O- https://raw.githubusercontent.com/weiyunfei/nvimdots/HEAD/scripts/install.sh)"
fi
