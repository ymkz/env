# dotfiles for ubuntu

### Setup Protocol

```sh

sudo apt update
sudo apt upgrade

# install pre-setup dependencies from `apt`
sudo apt install build-essential automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev unzip file curl

# install linuxbrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
brew update
brew upgrade

# install modules from `brew`
brew install git zsh ghq fzf exa asdf htop zplug

# setup my dotfiles
git config --global ghq.root ~/workspace/ghq
ghq get ymkz/dotfiles
./workspace/ghq/github.com/ymkz/dotfiles/linux/setup.sh

# change default shell to `zsh`
chsh -s /bin/zsh

# restart shell
exec $SHELL -l

# setup language to develop
asdf plugin-add nodejs
asdf plugin-add yarn
asdf install nodejs 10.16.3
asdf install yarn 1.17.3
asdf global nodejs 10.16.3
asdf global yarn 1.17.3

# install LaTeX environment
sudo apt install texlive-lang-cjk xdvik-ja texlive-fonts-recommended texlive-fonts-extra latexmk

# download GUI application
- VSCode: https://code.visualstudio.com/
- Alacritty: https://github.com/jwilm/alacritty

```
