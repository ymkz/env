#!/usr/bin/env bash

set -eu

function fetch_dotfiles() {
  if [[ ! -e "$HOME/work/ghq/github.com/ymkz/dotfiles" ]]; then
    git clone https://github.com/ymkz/dotfiles.git "$HOME/work/ghq/github.com/ymkz/dotfiles"
  fi
}

function install_xcode_cli() {
  if [[ ! -e "/Library/Developer/CommandLineTools" ]]; then
    sudo xcode-select --install
  fi
}

function install_homebrew() {
  # https://brew.sh/
  if [[ ! -e "/usr/local/bin/brew" ]]; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

function install_homebrew_formulae() {
  if [[ ! -e "/usr/local/bin/starship" ]]; then
    brew bundle --file "$HOME/work/ghq/github.com/ymkz/dotfiles/Brewfile"
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

function setup_fonts() {
  # https://www.jetbrains.com/ja-jp/lp/mono/
  if [[ -e "$HOME/Library/Fonts/JetBrainsMono" ]]; then
    curl -sSOL https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip
    unzip -j JetBrainsMono-2.242.zip -d "$HOME/Library/Fonts" "*.ttf"
    rm -f JetBrainsMono-2.242.zip
  fi
}

function setup_zsh() {
  if [[ ! -e "$HOME/.config/zsh" ]]; then
    mkdir -p "$HOME/.config/zsh"
    git clone https://github.com/zsh-users/zsh-completions $HOME/.config/zsh/zsh-completions
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.config/zsh/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.config/zsh/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-history-substring-search $HOME/.config/zsh/zsh-history-substring-search
    chsh -s /usr/local/bin/zsh
    chmod 755 /usr/local/share/zsh
    chmod 755 /usr/local/share/zsh/site-functions
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

function remove_garbages() {
  rm -f "$HOME/Applications/.localized"
  rm -f "$HOME/Desktop/.localized"
  rm -f "$HOME/Documents/.localized"
  rm -f "$HOME/Downloads/.localized"
  rm -f "$HOME/Library/.localized"
  rm -f "$HOME/Movies/.localized"
  rm -f "$HOME/Music/.localized"
  rm -f "$HOME/Pictures/.localized"
  rm -f "$HOME/Public/.localized"
}

function configure_system_preferences() {
  if [[ ! -e "$HOME/work/ghq/github.com/ymkz/dotfiles" ]]; then
    bash "$HOME/work/ghq/github.com/ymkz/dotfiles/scripts/configure.macos.sh"
  fi
}

fetch_dotfiles
install_xcode_cli
install_homebrew
install_homebrew_formulae
install_rust
install_sdkman
setup_fonts
setup_zsh
deploy_dotfiles
remove_garbages
configure_system_preferences

echo ">>> =========================================================="
echo ">>> 1. reboot"
echo ">>> 2. ssh-keygen -t ed25519"
echo ">>> 3. cat $HOME/.ssh/id_ed25519.pub | pbcopy && open https://github.com/settings/keys"
echo ">>> 4. git remote set-url origin git@github.com:ymkz/dotfiles.git"
echo ">>> 5. sdk install java"
echo ">>> 6. fnm install --lts"
echo ">>> 7. Configure system preferences"
echo ">>> 8. Configure Applications"
echo ">>> =========================================================="