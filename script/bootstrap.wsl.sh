#!/usr/bin/env bash

set -eu

function pre_setup() {
  if [[ ! -e "$HOME/work/ghq/github.com/ymkz/dotfiles" ]]; then
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install -y build-essential procps
  fi
}

function pre_setup_nameserver() {
  sudo cp "$HOME/work/ghq/github.com/ymkz/dotfiles/wsl/wsl.conf" "/etc/wsl.conf"
  sudo rm -f /etc/resolv.conf
  sudo sh -c "echo 'nameserver 8.8.8.8' > /etc/resolv.conf"
}

function fetch_dotfiles() {
  if [[ ! -e "$HOME/work/ghq/github.com/ymkz/dotfiles" ]]; then
    git clone https://github.com/ymkz/dotfiles.git "$HOME/work/ghq/github.com/ymkz/dotfiles"
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

function install_go() {
  # https://go.dev/
  if [[ ! -e "/usr/local/go" ]]; then
    wget https://go.dev/dl/go1.17.3.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.17.3.linux-amd64.tar.gz
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

function setup_zsh() {
  if [[ ! -e "$HOME/.config/zsh" ]]; then
    mkdir -p "$HOME/.config/zsh"
    git clone https://github.com/zsh-users/zsh-completions $HOME/.config/zsh/zsh-completions
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.config/zsh/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.config/zsh/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-history-substring-search $HOME/.config/zsh/zsh-history-substring-search
    which zsh | sudo tee -a /etc/shells
    sudo chsh "$USER" -s "$(which zsh)"
  fi
}

function deploy_dotfiles() {
  mkdir -p "$HOME/.config/git"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/editorconfig" "$HOME/.editorconfig"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/gitconfig" "$HOME/.gitconfig"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/gitignore" "$HOME/.config/git/ignore"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/gitattributes" "$HOME/.config/git/attributes"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/npmrc" "$HOME/.npmrc"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/starship.toml" "$HOME/.config/starship.toml"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/vimrc" "$HOME/.vimrc"
  ln -nfs "$HOME/work/ghq/github.com/ymkz/dotfiles/zshrc" "$HOME/.zshrc"
}

pre_setup
pre_setup_nameserver
fetch_dotfiles
install_homebrew
install_homebrew_formulae
install_go
install_rust
install_sdkman
setup_zsh
deploy_dotfiles

echo ">>> ========================================"
echo ">>> 1. reboot"
echo ">>> 2. ssh-keygen -t ed25519"
echo ">>> 3. cat $HOME/.ssh/id_ed25519.pub | pbcopy"
echo ">>> 4. open https://github.com/settings/keys"
echo ">>> 5. git remote set-url origin git@github.com:ymkz/dotfiles.git"
echo ">>> 6. sdk install java"
echo ">>> 7. fnm install --lts"
echo ">>> 8. Configure Applications"
echo ">>> ========================================"