#!/usr/bin/env bash

set -eu

if [ -e "$HOME/workspace/ghq/github.com/ymkz/dotfiles" ]; then
  echo >&2 "Quit bootstrap because dotfiles already exist."
  exit 1
fi

echo ">>> Install system from apt"
sudo apt update -y
sudo apt install -y build-essential

echo ">>> Install linuxbrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo ">>> Activate linuxbrew for temporarily"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

echo ">>> Install system from linuxbrew"
brew install bat
brew install exa
brew install fzf
brew install ghq
brew install gh
brew install jq
brew install loc
brew install nkf
brew install starship
brew install volta
brew install wget
brew install zplug

echo ">>> Fetch dotfiles"
mkdir -p "$HOME"/workspace/ghq/github.com/ymkz
git clone https://github.com/ymkz/dotfiles.git "$HOME"/workspace/ghq/github.com/ymkz/dotfiles

echo ">>> Link dotfiles"
mkdir -p "$HOME"/.config/bat
ln -nfs "$HOME"/workspace/ghq/github.com/ymkz/dotfiles/wsl/editorconfig "$HOME"/.editorconfig
ln -nfs "$HOME"/workspace/ghq/github.com/ymkz/dotfiles/wsl/gitconfig "$HOME"/.gitconfig
ln -nfs "$HOME"/workspace/ghq/github.com/ymkz/dotfiles/wsl/globalgitignore "$HOME"/.globalgitignore
ln -nfs "$HOME"/workspace/ghq/github.com/ymkz/dotfiles/wsl/starship.toml "$HOME"/.config/starship.toml
ln -nfs "$HOME"/workspace/ghq/github.com/ymkz/dotfiles/wsl/vimrc "$HOME"/.vimrc
ln -nfs "$HOME"/workspace/ghq/github.com/ymkz/dotfiles/wsl/zshrc "$HOME"/.zshrc
ln -nfs "$HOME"/workspace/ghq/github.com/ymkz/dotfiles/macos/batconfig "$HOME"/.config/bat/config

# echo ">>> Install Docker CE"
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo apt-key fingerprint 0EBFCD88
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# sudo apt update -y
# sudo apt install docker-ce -y
# sudo usermod -aG docker "$USER"
# 
# echo ">>> Install Docker Compose"
# sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose

# echo ">>> Change default shell"
# sudo chsh "$USER" -s "$(command -v zsh)"

echo ">>> ---"
echo ">>> Done!"
echo ">>> Please restart computer to activate brand new environment."
echo ">>> ---"
