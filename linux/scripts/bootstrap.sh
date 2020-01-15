#!/usr/bin/env bash

set -eu

if [ -e "$HOME/dotfiles-master" ] || [ -e "$HOME/workspace/ghq/github.com/ymkz/dotfiles" ]; then
  echo >&2 "Quit bootstrap because dotfiles already exist."
  exit 1
fi

wget https://github.com/ymkz/dotfiles/archive/master.zip -O $HOME/dotfiles.zip
unzip $HOME/dotfiles.zip
rm $HOME/dotfiles.zip
cd $HOME/dotfiles-master/linux

LANG=C xdg-user-dirs-gtk-update

# updatedbの無効化(locateコマンド使わないなら絶対しておくべき)
# もとに戻すなら `sudo chmod 755 /etc/cron.daily/mlocate`
sudo chmod 644 /etc/cron.daily/mlocate

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y \
  automake \
  autoconf \
  apt-transport-https \
  libreadline-dev \
  libncurses-dev \
  libssl-dev \
  libyaml-dev \
  libxslt-dev \
  libffi-dev \
  libtool \
  unixodbc-dev \
  curl \
  git \
  exa \
  zsh

sudo chsh $USER -s $(which zsh)

echo "Install GHQ binary from GitHub Release"
wget https://github.com/motemen/ghq/releases/download/v1.0.1/ghq_linux_amd64.zip -O $HOME/ghq.zip
unzip $HOME/ghq.zip
rm $HOME/ghq.zip
mkdir -p $HOME/workspace/bin
cp -rfp $HOME/ghq_linux_amd64/ghq $HOME/workspace/bin
rm -r $HOME/ghq_linux_amd64

cp ./gitconfig $HOME/.gitconfig
$HOME/workspace/bin/ghq get ymkz/dotfiles
rm $HOME/.gitconfig

scripts/symlink.sh
echo

echo "Install zplug"
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

echo "Install starship shell prompt"
curl -fsSL https://starship.rs/install.sh | bash

echo "Install asdf-vm from Git"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.6
source $HOME/.zshrc
asdf plugin-add nodejs
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf plugin-add yarn
asdf install nodejs 12.14.1
asdf install yarn 1.21.1
asdf global nodejs 12.14.1
asdf global yarn 1.21.1

# reference: UbuntuにVSCodeをインストールする3つの方法 - https://qiita.com/yoshiyasu1111/items/e21a77ed68b52cb5f7c8
echo "Install VSCode"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > $HOME/microsoft.gpg
sudo install -o root -g root -m 644 $HOME/microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code -y

echo "Install Cascadia Code font from GitHub Release"
mkdir $HOME/.fonts
curl https://github.com/microsoft/cascadia-code/releases/download/v1911.21/CascadiaPL.ttf -o $HOME/.fonts/CascadiaPL.ttf

rm -rf $HOME/dotfiles-master
