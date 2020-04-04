#!/usr/bin/env bash

set -eu

if [ -e "$HOME/workspace/ghq/github.com/ymkz/dotfiles" ]; then
  echo >&2 "Quit bootstrap because dotfiles already exist."
  exit 1
fi

echo ">>> Update user directories name to English"
LANG=C xdg-user-dirs-gtk-update

# updatedbの無効化(locateコマンド使わないなら絶対しておくべき)
# もとに戻すなら `sudo chmod 755 /etc/cron.daily/mlocate`
sudo chmod 644 /etc/cron.daily/mlocate

echo ">>> Add latest git repository"
sudo add-apt-repository ppa:git-core/ppa -y

echo ">>> Install system from apt"
sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean
sudo apt install -y \
  automake \
  autoconf \
  apt-transport-https \
  ca-certificates \
  gnupg-agent \
  software-properties-common \
  build-essential \
  libreadline-dev \
  libncurses-dev \
  libssl-dev \
  libyaml-dev \
  libxslt-dev \
  libffi-dev \
  libtool \
  unixodbc-dev \
  unzip \
  curl \
  file \
  xsel \
  git \
  exa \
  fzf \
  zsh

echo ">>> Install linuxbrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo ">>> Activate linuxbrew for temporarily"
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

echo ">>> Install system from linuxbrew"
brew install ghq
brew install starship
brew install github/gh/gh

echo ">>> Install zplug"
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

echo ">>> Install volta"
curl https://get.volta.sh | bash

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

# reference: UbuntuにVSCodeをインストールする3つの方法 - https://qiita.com/yoshiyasu1111/items/e21a77ed68b52cb5f7c8
echo ">>> Install VSCode"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > $HOME/microsoft.gpg
sudo install -o root -g root -m 644 $HOME/microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update -y
sudo apt install code -y
rm $HOME/microsoft.gpg

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

echo ">>> Install Docker CE"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update -y
sudo apt install docker-ce -y
sudo usermod -aG docker $USER

echo ">>> Install Docker Compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo ">>> Change default shell"
sudo chsh $USER -s $(which zsh)

echo ">>> ---"
echo ">>> Done!"
echo ">>> Please restart computer to activate brand new environment."
echo ">>> ---"
