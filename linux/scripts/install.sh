#!/usr/bin/env bash

set -eu

echo "Install GHQ binary from GitHub Release"
curl https://github.com/motemen/ghq/releases/download/v1.0.1/ghq_linux_amd64.zip -o $HOME/ghq.zip
unzip $HOME/ghq.zip
rm $HOME/ghq.zip
cp $HOME/ghq_linux_amd64/ghq $HOME/workspace/bin
rm -r $HOME/ghq_linux_amd64

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

echo "Install starship shell prompt"
curl -fsSL https://starship.rs/install.sh | bash
source $HOME/.zshrc
