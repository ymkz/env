#!/usr/bin/env bash

set -eu

function before_all() {
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt install -y build-essential procps
}

function fetch_dotfiles() {
  if [[ ! -e "$HOME/work/ghq/github.com/ymkz/dotfiles" ]]; then
    git clone https://github.com/ymkz/dotfiles.git "$HOME/work/ghq/github.com/ymkz/dotfiles"
  fi
}

function make_xdg_directories() {
  mkdir -p $HOME/.config
  mkdir -p $HOME/.cache
  mkdir -p $HOME/.local/share
  mkdir -p $HOME/.local/bin
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

function restore_homebrew_formulae() {
  brew bundle --file "$HOME/work/ghq/github.com/ymkz/dotfiles/brew/Brewfile"
}

function install_aqua() {
  # https://aquaproj.github.io/docs/products/aqua-installer
  curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v2.1.1/aqua-installer | bash
}

function install_aqua_tools() {
  $HOME/.local/share/aquaproj-aqua/bin/aqua --config "$HOME/.config/aquaproj-aqua/aqua.yaml" install
}

function install_sdkman() {
  # https://sdkman.io/
  if [[ ! -e "$HOME/.sdkman" ]]; then
    curl -s "https://get.sdkman.io?rcupdate=false" | bash
  fi
}

function deploy_zsh_plugin() {
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
  echo ">>> 1. ssh-keygen -t ed25519"
  echo ">>> 2. cat $HOME/.ssh/id_ed25519.pub"
  echo ">>> 3. open https://github.com/settings/keys"
  echo ">>> 4. git remote set-url origin git@github.com:ymkz/dotfiles.git"
  echo ">>> 5. reboot"
  echo ">>> 6. sdk install java"
  echo ">>> 7. fnm install --lts"
  echo ">>> 8. npm install --location=global npm-check-updates @antfu/ni"
  echo ">>> 9. Configure Applications"
  echo ">>> ========================================"
}

before_all
fetch_dotfiles
make_xdg_directories
deploy_config_files
update_nameserver
install_homebrew
restore_homebrew_formulae
install_aqua
install_aqua_tools
install_sdkman
deploy_zsh_plugin
use_zsh
after_all
