# dotfiles

## Usage

setup

```sh
curl -sSfL https://raw.githubusercontent.com/ymkz/dotfiles/HEAD/setup.sh | bash
```

then

```sh
# change ymkz/dotfiles upstream
git remote set-url origin git@github.com:ymkz/dotfiles.git

# generate ssh key
ssh-keygen -t ed25519
cat ${HOME}/.ssh/id_ed25519.pub

# install node and java
mise install node@20
mise install java@21
mise use -g node@20
mise use -g java@21

# install global packages
npm install --location=global @antfu/ni tiged taze

# install docker (https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script)
# setup docker (https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
newgrp docker
rm get-docker.sh
```

## Reset WSL

```sh
wsl.exe --unregister Ubuntu
```
