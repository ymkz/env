# ---- BASE ---- #
TZ="Asia/Tokyo"
LESS="-R"
LANG="ja_JP.UTF-8"
EDITOR="code --wait"
FCEDIT="code --wait"

# ---- XDG BASE DIRECTORY ---- #
# https://wiki.archlinux.jp/index.php/XDG_Base_Directory
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/state"}

# ---- ZSH ---- #
ZDOTDIR="$XDG_CONFIG_HOME/zsh"
