#!/usr/bin/env sh

set -eu

if [ -e "$HOME/work/ghq/github.com/ymkz/dotfiles" ]; then
  echo >&2 "[ERROR] Exit bootstrapping because dotfiles already exist."
  exit 1
fi

# pre-setup
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y patch build-essential zsh locales-all

# fetch dotfiles
mkdir -p $HOME/work/ghq/github.com/ymkz
git clone https://github.com/ymkz/dotfiles.git $HOME/work/ghq/github.com/ymkz/dotfiles

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# install rust for rust/cargo toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
export PATH="$HOME/.cargo/bin:$PATH"

# install volta for node.js toolchain
curl https://get.volta.sh | bash -s -- --skip-setup
export PATH="$HOME/.volta/bin:$PATH"
volta install node@12

# install sdkman for java/jvm toolchain
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# install homebrew formulae
brew bundle --file $HOME/work/ghq/github.com/ymkz/dotfiles/Brewfile.wsl

# deploy dotfiles
mkdir -p $HOME/.config
ln -nfs $HOME/work/ghq/github.com/ymkz/dotfiles/editorconfig $HOME/.editorconfig
ln -nfs $HOME/work/ghq/github.com/ymkz/dotfiles/gitconfig $HOME/.gitconfig
ln -nfs $HOME/work/ghq/github.com/ymkz/dotfiles/globalgitignore $HOME/.globalgitignore
ln -nfs $HOME/work/ghq/github.com/ymkz/dotfiles/starship.toml $HOME/.config/starship.toml
ln -nfs $HOME/work/ghq/github.com/ymkz/dotfiles/vimrc $HOME/.vimrc
ln -nfs $HOME/work/ghq/github.com/ymkz/dotfiles/zshrc $HOME/.zshrc

# configure shell
echo $(which zsh) | sudo tee -a /etc/shells
chsh $USER -s $(which zsh)

echo ">>> ========================================"
echo ">>> 1. reboot"
echo ">>> 2. change dotfiles repository remote origin to ssh"
echo ">>> 3. configure system preferences"
echo ">>> 4. install GUI applications and setup"
echo ">>> 5. add ssh key for github"
echo ">>> ========================================"