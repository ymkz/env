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

function update_nameserver() {
  sudo rm -f /etc/resolv.conf
  sudo cp "$HOME/work/ghq/github.com/ymkz/dotfiles/wsl/wsl.conf" "/etc/wsl.conf"
  sudo cp "$HOME/work/ghq/github.com/ymkz/dotfiles/wsl/resolv.conf" "/etc/resolv.conf"
}

function install_homebrew() {
  # https://brew.sh/
  if [[ ! -e "/home/linuxbrew/.linuxbrew" ]]; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
}

function install_rust() {
  # https://www.rust-lang.org/
  if [[ ! -e "$HOME/.rustup" ]]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
  fi
}

function install_sdkman() {
  # https://sdkman.io/
  if [[ ! -e "$HOME/.sdkman" ]]; then
    curl -s "https://get.sdkman.io?rcupdate=false" | bash
  fi
}

function restore_homebrew_formulae() {
  brew bundle --file "$HOME/work/ghq/github.com/ymkz/dotfiles/brew/Brewfile"
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

function deploy_config_files() {
  mkdir -p "$HOME/.config/git"
  mkdir -p "$HOME/.config/zsh"

  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/zsh/.zshenv" "$HOME/.zshenv"

  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/vim/vimrc" "$HOME/.vimrc"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/node/npmrc" "$HOME/.npmrc"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/misc/editorconfig" "$HOME/.editorconfig"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/starship/starship.toml" "$HOME/.config/starship.toml"

  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/zsh/zshrc" "$HOME/.config/zsh/.zshrc"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/zsh/alias.zsh" "$HOME/.config/zsh/alias.zsh"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/zsh/function.zsh" "$HOME/.config/zsh/function.zsh"

  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/git/config" "$HOME/.config/git/config"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/git/ignore" "$HOME/.config/git/ignore"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/git/attributes" "$HOME/.config/git/attributes"
}

function use_zsh() {
  which zsh | sudo tee -a /etc/shells
  sudo chsh "$USER" -s "$(which zsh)"
}

function after_all() {
  echo ">>> ========================================"
  echo ">>> 1. ssh-keygen -t ed25519"
  echo ">>> 2. cat $HOME/.ssh/id_ed25519.pub | pbcopy"
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
update_nameserver
install_homebrew
install_rust
install_sdkman
restore_homebrew_formulae
deploy_zsh_plugin
deploy_config_files
use_zsh
after_all
