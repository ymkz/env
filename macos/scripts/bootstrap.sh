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

echo ">>> Install zplug"
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

echo ">>> Install volta"
curl https://get.volta.sh | bash

echo ">>> Configure macOS default settings"
scripts/configure.sh

echo ">>> Fetch dotfiles"
mkdir -p $HOME/workspace/ghq/github.com/ymkz
git clone https://github.com/ymkz/dotfiles.git $HOME/workspace/ghq/github.com/ymkz/dotfiles

echo ">>> Link dotfiles"
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/linux/editorconfig $HOME/.editorconfig
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/linux/gitconfig $HOME/.gitconfig
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/linux/globalgitignore $HOME/.globalgitignore
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/linux/starship.toml $HOME/.config/starship.toml
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/linux/vimrc $HOME/.vimrc
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/linux/zshenv $HOME/.zshenv
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/linux/zshrc $HOME/.zshrc

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

echo ">>> Download and deploy fonts"
mkdir $HOME/.fonts
wget https://download.jetbrains.com/fonts/JetBrainsMono-1.0.2.zip -o $HOME/JetBrainsMono.zip
unzip $HOME/JetBrainsMono.zip
rm $HOME/JetBrainsMono.zip
mv $HOME/JetBrainsMono-* $HOME/JetBrainsMono
mv $HOME/JetBrainsMono $HOME/.fonts

echo ">>> ---"
echo ">>> Done!"
echo ">>> Please restart computer to activate brand new environment."
echo ">>> ---"
