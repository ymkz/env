source $HOME/.zplug/init.zsh

zplug "zsh-users/zsh-completions", defer:0
zplug "zsh-users/zsh-autosuggestions", defer:0
zplug "zsh-users/zsh-history-substring-search", defer:1
zplug "zdharma/fast-syntax-highlighting", defer:1
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug "zplug/zplug", hook-build:"zplug --self-manage"

if ! zplug check; then
  zplug install
fi

zplug load

autoload -Uz compinit; compinit
autoload -Uz colors; colors

zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${LS_COLORS}"

HISTFILE=$HOME/.zhistory
HISTSIZE=100000
SAVEHIST=100000

setopt no_beep
setopt auto_cd
setopt auto_pushd
setopt auto_menu
setopt list_packed
setopt list_types
setopt pushd_ignore_dups
setopt share_history
setopt correct
setopt magic_equal_subst
setopt complete_aliases
setopt extended_glob
setopt nonomatch
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_reduce_blanks

unsetopt caseglob
unsetopt promptcr

# fzf: history search
function history-fzf() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N history-fzf
bindkey '^r' history-fzf

# fzf: ghq search
function cd-fzf-ghqlist() {
  local selected_dir=$(ghq list | fzf --query="$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd $(ghq root)/${selected_dir}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N cd-fzf-ghqlist
bindkey '^g' cd-fzf-ghqlist

# fzf: git change branch
function checkout-fzf-gitbranch() {
  local GIT_BRANCH=$(git branch --all | grep -v HEAD | fzf --ansi +m)
  if [ -n "$GIT_BRANCH" ]; then
    git checkout $(echo "$GIT_BRANCH" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
  fi
  zle accept-line
}
zle -N checkout-fzf-gitbranch
bindkey '^o' checkout-fzf-gitbranch

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# rvm
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# exa as ls
if [[ -x `which exa` ]]; then
  alias l="exa -F"
  alias ls="exa -F"
  alias la="exa -Fa"
  alias ll="exa -bhlHF"
  alias lla="exa -bhlHFa"
else
  case ${OSTYPE} in
    darwin*)
      alias ls="ls -GF"
      ;;
    linux*)
      alias ls="ls -F --color=auto"
      ;;
  esac
  alias la="ls -A"
  alias ll="ls -l"
  alias lla="ls -lA"
fi

# git alias
alias g="git"
alias gf="git fetch"
alias gs="git status --short --branch"
alias gl="git log --date=short --pretty=format:'%C(yellow)%h %Cgreen%cd %Cblue%cn %Creset%s'"
alias gb="git branch"
alias gbl="git branch -a -vv"
alias ga="git add"
alias gd="git diff"
alias gn="git checkout -b"
alias gcm="git commit -m"
alias gco="git checkout"
alias gro="git rebase origin/master"

# gomi-cli alias
alias rm="gomi -s"

# python alias
alias python="python3"
