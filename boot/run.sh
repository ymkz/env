#!/usr/bin/env bash

set -eu

function before_all() {
  echo ">>> ========================================"
  echo ">>> SETUP START"
  echo ">>> ========================================"
}

function update_apt() {
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt install -y build-essential procps
}

function fetch_dotfiles() {
  if [[ ! -e "$HOME/work/ghq/github.com/ymkz/dotfiles" ]]; then
    git clone https://github.com/ymkz/dotfiles.git "$HOME/work/ghq/github.com/ymkz/dotfiles"
  fi
}

function make_base_directories() {
  mkdir -p $HOME/.config
  mkdir -p $HOME/.cache
  mkdir -p $HOME/.local/share
 
  mkdir -p $HOME/.local/bin
 
  mkdir -p $HOME/work/sandbox
}

function deploy_config_files() {
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/zsh/zshrc" "$HOME/.zshrc"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/vim/vimrc" "$HOME/.vimrc"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/node/npmrc" "$HOME/.npmrc"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/misc/editorconfig" "$HOME/.editorconfig"

  mkdir -p $HOME/.config/aquaproj-aqua
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/aqua/aqua.yaml" "$HOME/.config/aquaproj-aqua/aqua.yaml"

  mkdir -p "$HOME/.config/zsh/user"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/zsh/user/alias.zsh" "$HOME/.config/zsh/user/alias.zsh"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/zsh/user/function.zsh" "$HOME/.config/zsh/user/function.zsh"

  mkdir -p "$HOME/.config/git"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/git/config" "$HOME/.config/git/config"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/git/ignore" "$HOME/.config/git/ignore"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/git/attributes" "$HOME/.config/git/attributes"

  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/starship/starship.toml" "$HOME/.config/starship.toml"
}

function update_nameserver() {
  sudo unlink /etc/resolv.conf
  sudo cp "$HOME/work/ghq/github.com/ymkz/dotfiles/wsl/wsl.conf" "/etc/wsl.conf"
  sudo cp "$HOME/work/ghq/github.com/ymkz/dotfiles/wsl/resolv.conf" "/etc/resolv.conf"
}

function install_homebrew() {
  # https://brew.sh/
  if [[ ! -e "/home/linuxbrew/.linuxbrew" ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
}

function restore_homebrew_packages() {
  brew bundle --file "$HOME/work/ghq/github.com/ymkz/dotfiles/brew/Brewfile"
}

function install_aqua() {
  # https://aquaproj.github.io/docs/products/aqua-installer
  curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v2.1.1/aqua-installer | bash
}

function restore_aqua_packages() {
  $HOME/.local/share/aquaproj-aqua/bin/aqua --config "$HOME/.config/aquaproj-aqua/aqua.yaml" install
}

function install_sdkman() {
  # https://sdkman.io/
  if [[ ! -e "$HOME/.sdkman" ]]; then
    curl -s "https://get.sdkman.io?rcupdate=false" | bash
  fi
}

function fetch_zsh_plugins() {
  if [[ ! -e "$HOME/.config/zsh/plugin" ]]; then
    mkdir -p "$HOME/.config/zsh/plugin"
    git clone https://github.com/zsh-users/zsh-completions $HOME/.config/zsh/plugin/zsh-completions
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.config/zsh/plugin/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.config/zsh/plugin/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-history-substring-search $HOME/.config/zsh/plugin/zsh-history-substring-search
  fi
}

function use_zsh() {
  which zsh | sudo tee -a /etc/shells
  sudo chsh "$USER" -s "$(which zsh)"
}

function after_all() {
  echo ">>> ========================================"
  echo ">>> SETUP COMPLETE"
  echo ">>> - ssh-keygen -t ed25519"
  echo ">>> - cat $HOME/.ssh/id_ed25519.pub"
  echo ">>> - open https://github.com/settings/keys"
  echo ">>> - git remote set-url origin git@github.com:ymkz/dotfiles.git"
  echo ">>> - reboot"
  echo ">>> - sdk install java"
  echo ">>> - fnm install --lts"
  echo ">>> - npm install --location=global npm-check-updates @antfu/ni"
  echo ">>> - Configure Applications"
  echo ">>> ========================================"
}

before_all
update_apt
fetch_dotfiles
make_base_directories
deploy_config_files
update_nameserver
install_homebrew
restore_homebrew_packages
install_aqua
restore_aqua_packages
install_sdkman
fetch_zsh_plugins
use_zsh
after_all
