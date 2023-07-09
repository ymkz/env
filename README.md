# dotfiles

## Usage

setup

```sh
curl -sSfL https://raw.githubusercontent.com/ymkz/dotfiles/HEAD/setup.sh | bash
```

then

```sh
ssh-keygen -t ed25519
cat ${HOME}/.ssh/id_ed25519.pub | clip.exe
open https://github.com/settings/keys
git remote set-url origin git@github.com:ymkz/dotfiles.git
npm install --location=global @antfu/ni tiged taze
reboot
```

## Reset WSL

```sh
wsl.exe --unregister Ubuntu
```
