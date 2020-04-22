#!/usr/bin/env zsh

set -eu

if [ -e "$HOME/workspace/ghq/github.com/ymkz/dotfiles" ]; then
  echo >&2 "Quit bootstrap because dotfiles already exist."
  exit 1
fi

echo ">>> Install xcode components"
xcode-select --install

echo ">>> Install homebrew"
if ! builtin command -v brew > /dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo
fi

echo ">>> Install homebrew components"
curl -OL https://raw.githubusercontent.com/ymkz/dotfiles/master/macos/Brewfile
brew bundle
rm Brewfile

echo ">>> Fetch dotfiles"
mkdir -p $HOME/workspace/ghq/github.com/ymkz
git clone https://github.com/ymkz/dotfiles.git $HOME/workspace/ghq/github.com/ymkz/dotfiles

echo ">>> Link dotfiles"
mkdir -p $HOME/.config
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/macos/editorconfig $HOME/.editorconfig
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/macos/gitconfig $HOME/.gitconfig
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/macos/globalgitignore $HOME/.globalgitignore
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/macos/starship.toml $HOME/.config/starship.toml
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/macos/vimrc $HOME/.vimrc
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/macos/zshenv $HOME/.zshenv
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/macos/zshrc $HOME/.zshrc

echo ">>> Configure macOS default settings"
$HOME/workspace/ghq/github.com/ymkz/dotfiles/macos/scripts/configure.sh

echo ">>> Instal VSCode Extensions"
code --install-extension bierner.markdown-preview-github-styles
code --install-extension dbaeumer.vscode-eslint
code --install-extension EditorConfig.EditorConfig
code --install-extension esbenp.prettier-vscode
code --install-extension jpoissonnier.vscode-styled-components
code --install-extension mechatroner.rainbow-csv
code --install-extension monokai.theme-monokai-pro-vscode
code --install-extension ms-azuretools.vscode-docker
code --install-extension MS-CEINTL.vscode-language-pack-ja
code --install-extension PKief.material-icon-theme
code --install-extension satokaz.vscode-bs-ctrlchar-remover
code --install-extension stylelint.vscode-stylelint
code --install-extension VisualStudioExptTeam.vscodeintellicode
code --install-extension WakaTime.vscode-wakatime
code --install-extension wmaurer.change-case
code --install-extension yahya-gilany.vscode-clock

echo ">>> Generate workspace"
mkdir -p $HOME/workspace/cic

echo ">>> ---"
echo ">>> Done!"
echo ">>> Please restart computer to activate brand new environment."
echo ">>> ---"
