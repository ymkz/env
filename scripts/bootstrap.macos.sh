#!/usr/bin/env sh

set -eu

if [ -e "$HOME/workspace/ghq/github.com/ymkz/dotfiles" ]; then
  echo >&2 "[ERROR] Exit bootstrapping because dotfiles already exist."
  exit 1
fi

# fetch dotfiles
mkdir -p $HOME/workspace/ghq/github.com/ymkz
git clone https://github.com/ymkz/dotfiles.git $HOME/workspace/ghq/github.com/ymkz/dotfiles

# install xcode
if [ ! -e "/Library/Developer/CommandLineTools" ]; then
  sudo xcode-select --install
fi

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# install rust for rust/cargo toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
export PATH="$HOME/.cargo/bin:$PATH"

# install volta for node.js toolchain
curl https://get.volta.sh | bash

# install sdkman for java/jvm toolchain
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# install homebrew formulae
brew bundle --file $HOME/workspace/ghq/github.com/ymkz/dotfiles/Brewfile

# install nodejs
volta install node@14

# create my bin directory
mkdir -p $HOME/workspace/bin

# configure shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
chsh $USER -s /usr/local/bin/zsh
chmod 755 /usr/local/share/zsh/site-functions
chmod 755 /usr/local/share/zsh

# deploy dotfiles
mkdir -p $HOME/.config
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/editorconfig $HOME/.editorconfig
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/gitconfig $HOME/.gitconfig
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/globalgitignore $HOME/.globalgitignore
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/starship.toml $HOME/.config/starship.toml
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/vimrc $HOME/.vimrc
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/zshrc $HOME/.zshrc

# configure finder
sudo rm -f /Applications/.localized $HOME/Applications/.localized $HOME/Desktop/.localized $HOME/Documents/.localized $HOME/Downloads/.localized $HOME/Library/.localized $HOME/Movies/.localized $HOME/Music/.localized $HOME/Pictures/.localized $HOME/Public/.localized

# configure system preferences on macos
$HOME/workspace/ghq/github.com/ymkz/dotfiles/scripts/configure.macos.sh

echo ">>> ========================================"
echo ">>> 1. reboot"
echo ">>> 2. change dotfiles repository remote origin to ssh"
echo ">>> 3. configure system preferences"
echo ">>> 4. install GUI applications and setup"
echo ">>> 5. add ssh key for github"
echo ">>> ========================================"