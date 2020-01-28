#!/usr/bin/env bash

set -eu

if [ -e "$HOME/dotfiles-master" ] || [ -e "$HOME/workspace/ghq/github.com/ymkz/dotfiles" ]; then
  echo >&2 "Quit bootstrap because dotfiles already exist."
  exit 1
fi

LANG=C xdg-user-dirs-gtk-update

# updatedbの無効化(locateコマンド使わないなら絶対しておくべき)
# もとに戻すなら `sudo chmod 755 /etc/cron.daily/mlocate`
sudo chmod 644 /etc/cron.daily/mlocate

sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean
sudo apt install -y \
  automake \
  autoconf \
  apt-transport-https \
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
  git \
  exa \
  zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

brew install ghq

wget https://github.com/ymkz/dotfiles/archive/master.zip -O $HOME/dotfiles.zip
unzip $HOME/dotfiles.zip
rm $HOME/dotfiles.zip
cd $HOME/dotfiles-master/linux

sudo chsh $USER -s $(which zsh)

cp ./gitconfig $HOME/.gitconfig
ghq get ymkz/dotfiles
rm $HOME/.gitconfig

ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/linux/asdfrc $HOME/.asdfrc
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/linux/editorconfig $HOME/.editorconfig
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/linux/gitconfig $HOME/.gitconfig
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/linux/globalgitignore $HOME/.globalgitignore
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/linux/latexmkrc $HOME/.latexmkrc
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/linux/npmrc $HOME/.npmrc
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/linux/starship.toml $HOME/.config/starship.toml
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/linux/vimrc $HOME/.vimrc
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/linux/zshenv $HOME/.zshenv
ln -nfs $HOME/workspace/ghq/github.com/ymkz/dotfiles/linux/zshrc $HOME/.zshrc

echo "Install zplug"
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

echo "Install starship shell prompt"
curl -s https://api.github.com/repos/starship/starship/releases/latest \
  | grep browser_download_url \
  | grep -m 1 x86_64-unknown-linux-gnu.tar.gz \
  | cut -d '"' -f 4 \
  | wget -qi -
tar xvf starship-*.tar.gz
sudo mv x86_64-unknown-linux-gnu/starship /usr/local/bin/
starship --version

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
sudo apt update -y
sudo apt install code -y

echo "Install Cascadia Code font from GitHub Release"
mkdir $HOME/.fonts
curl https://github.com/microsoft/cascadia-code/releases/download/v1911.21/CascadiaPL.ttf -o $HOME/.fonts/CascadiaPL.ttf

rm -rf $HOME/dotfiles-master
