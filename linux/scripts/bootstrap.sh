#!/usr/bin/env bash

set -eu

if [ -e "$HOME/dotfiles-master" ] || [ -e "$HOME/workspace/ghq/github.com/ymkz/dotfiles" ]; then
  echo >&2 "Quit bootstrap because dotfiles already exist."
  exit 1
fi

curl https://github.com/ymkz/dotfiles/archive/master.zip -o $HOME/dotfiles.zip
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
  unzip \
  curl \
  git \
  exa \
  zsh

chsh -s $(which zsh)

cp ./gitconfig $HOME/.gitconfig
ghq get git@github.com:ymkz/dotfiles.git
rm $HOME/.gitconfig

scripts/symlink.sh
echo

scripts/install.sh
echo

rm -rf $HOME/dotfiles-master
