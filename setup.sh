#!/usr/bin/env bash

set -eu

# setup dir
mkdir -p "${HOME}/.config"
mkdir -p "${HOME}/.cache"
mkdir -p "${HOME}/.local/share"
mkdir -p "${HOME}/.local/bin"
mkdir -p "${HOME}/work/sandbox"

# fetch dotfiles
if [[ ! -e "${HOME}/work/ghq/github.com/ymkz/dotfiles" ]]; then
  git clone https://github.com/ymkz/dotfiles.git "${HOME}/work/ghq/github.com/ymkz/dotfiles"
fi

# setup linux on wsl
if [[ "${OSTYPE}" == linux* ]]; then
  sudo add-apt-repository -y ppa:git-core/ppa
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt install -y build-essential language-pack-ja procps curl wget git zip unzip zsh sqlite3
  sudo unlink /etc/resolv.conf
  sudo cp "${HOME}/work/ghq/github.com/ymkz/dotfiles/wsl/wsl.conf" "/etc/wsl.conf"
  sudo cp "${HOME}/work/ghq/github.com/ymkz/dotfiles/wsl/resolv.conf" "/etc/resolv.conf"
  sudo chattr +i /etc/resolv.conf
fi

# deploy dotfiles
if [[ -e "${HOME}/work/ghq/github.com/ymkz/dotfiles" ]]; then
  mkdir -p "${HOME}/.config/git"
  mkdir -p "${HOME}/.config/zsh"
  mkdir -p "${HOME}/.config/atuin"
  mkdir -p "${HOME}/.config/aquaproj-aqua"
  ln -nfs "${HOME}/work/ghq/github.com/ymkz/dotfiles/misc/editorconfig" "${HOME}/.editorconfig"
  ln -nfs "${HOME}/work/ghq/github.com/ymkz/dotfiles/node/default-npm-packages" "${HOME}/.default-npm-packages"
  ln -nfs "${HOME}/work/ghq/github.com/ymkz/dotfiles/node/npmrc" "${HOME}/.npmrc"
  ln -nfs "${HOME}/work/ghq/github.com/ymkz/dotfiles/vim/vimrc" "${HOME}/.vimrc"
  ln -nfs "${HOME}/work/ghq/github.com/ymkz/dotfiles/zsh/zshrc" "${HOME}/.zshrc"
  ln -nfs "${HOME}/work/ghq/github.com/ymkz/dotfiles/zsh/alias.zsh" "${HOME}/.config/zsh/alias.zsh"
  ln -nfs "${HOME}/work/ghq/github.com/ymkz/dotfiles/zsh/function.zsh" "${HOME}/.config/zsh/function.zsh"
  ln -nfs "${HOME}/work/ghq/github.com/ymkz/dotfiles/git/config" "${HOME}/.config/git/config"
  ln -nfs "${HOME}/work/ghq/github.com/ymkz/dotfiles/git/ignore" "${HOME}/.config/git/ignore"
  ln -nfs "${HOME}/work/ghq/github.com/ymkz/dotfiles/git/attributes" "${HOME}/.config/git/attributes"
  ln -nfs "${HOME}/work/ghq/github.com/ymkz/dotfiles/atuin/config.toml" "${HOME}/.config/atuin/config.toml"
  ln -nfs "${HOME}/work/ghq/github.com/ymkz/dotfiles/starship/starship.toml" "${HOME}/.config/starship.toml"
  ln -nfs "${HOME}/work/ghq/github.com/ymkz/dotfiles/aqua/aqua.yaml" "${HOME}/.config/aquaproj-aqua/aqua.yaml"
fi

# fetch zsh plugins
if [[ ! -e "${HOME}/.config/zsh/plugin" ]]; then
  mkdir -p "${HOME}/.config/zsh/plugin"
  git clone https://github.com/zsh-users/zsh-completions "${HOME}/.config/zsh/plugin/zsh-completions"
  git clone https://github.com/zsh-users/zsh-autosuggestions "${HOME}/.config/zsh/plugin/zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "${HOME}/.config/zsh/plugin/zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-history-substring-search "${HOME}/.config/zsh/plugin/zsh-history-substring-search"
fi

# install aqua (https://aquaproj.github.io/docs/products/aqua-installer)
if ! type aqua > /dev/null 2>&1; then
  curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v2.3.2/aqua-installer | bash
  "${HOME}/.local/share/aquaproj-aqua/bin/aqua" --config "${HOME}/.config/aquaproj-aqua/aqua.yaml" install
fi

# change default shell
if type zsh > /dev/null 2>&1; then
  which zsh | sudo tee -a /etc/shells
  sudo chsh "${USER}" -s "$(which zsh)"
fi
