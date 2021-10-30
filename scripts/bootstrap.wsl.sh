#!/usr/bin/env bash

set -eu

function pre_setup() {
  if [[ ! -e "$HOME/work/ghq/github.com/ymkz/dotfiles" ]]; then
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install -y build-essential procps pkg-config libssl-dev zip unzip
  fi
}

function fetch_dotfiles() {
  if [[ ! -e "$HOME/work/ghq/github.com/ymkz/dotfiles" ]]; then
    git clone https://github.com/ymkz/dotfiles.git "$HOME/work/ghq/github.com/ymkz/dotfiles"
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

function install_nodejs() {
  # https://github.com/Schniz/fnm
  if [[ ! -e "$HOME/.fnm" ]]; then
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
  fi
}

function install_deno() {
  # https://deno.land/
  if [[ ! -e "$HOME/.deno" ]]; then
    curl -fsSL https://deno.land/x/install/install.sh | sh
  fi
}

function install_homebrew() {
  # https://brew.sh/
  if [[ ! -e "/home/linuxbrew/.linuxbrew" ]]; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
}

function install_homebrew_formulae() {
  if [[ ! -e "/home/linuxbrew/.linuxbrew/bin/starship" ]]; then
    brew bundle --file "$HOME/work/ghq/github.com/ymkz/dotfiles/Brewfile"
  fi
}

function setup_zinit() {
  # https://github.com/zdharma/zinit
  if [[ ! -e "$HOME/.zinit" ]]; then
    which zsh | sudo tee -a /etc/shells
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/HEAD/doc/install.sh)"
    sudo chsh "$USER" -s "$(which zsh)"
  fi
}

function deploy_dotfiles() {
  mkdir -p "$HOME/.config/git"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/editorconfig" "$HOME/.editorconfig"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/gitconfig" "$HOME/.gitconfig"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/gitignore" "$HOME/.config/git/ignore"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/npmrc" "$HOME/.npmrc"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/starship.toml" "$HOME/.config/starship.toml"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/vimrc" "$HOME/.vimrc"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/zshrc" "$HOME/.zshrc"
}

pre_setup

fetch_dotfiles

install_rust
install_sdkman
install_nodejs
install_deno
install_homebrew
install_homebrew_formulae

setup_zinit

deploy_dotfiles

echo ">>> ========================================"
echo ">>> 1. reboot"
echo ">>> 2. ssh-keygen -t ed25519"
echo ">>> 3. cat $HOME/.ssh/id_ed25519.pub | pbcopy && open https://github.com/settings/keys"
echo ">>> 4. git remote set-url origin git@github.com:ymkz/dotfiles.git"
echo ">>> 5. sdk install java"
echo ">>> 6. fnm install --lts"
echo ">>> 9. Configure Applications"
echo ">>> ========================================"