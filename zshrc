#!/usr/bin/env zsh

source $HOME/.config/zsh/zsh-completions/zsh-completions.plugin.zsh
source $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $HOME/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh

autoload -Uz compinit; compinit
autoload -Uz colors; colors

zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${LS_COLORS}"

setopt no_beep
setopt auto_cd
setopt auto_pushd
setopt auto_menu
setopt list_packed
setopt list_types
setopt pushd_ignore_dups

setopt correct
setopt magic_equal_subst
setopt complete_aliases
setopt extended_glob
setopt nonomatch

setopt share_history
setopt extended_history
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_reduce_blanks

unsetopt caseglob
unsetopt promptcr

typeset -U PATH

export LESS="-R"
export LANG="ja_JP.UTF-8"
export EDITOR="code --wait"
export FCEDIT="code --wait"

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=1000000

export FZF_DEFAULT_OPTS="--height 40% --ansi --cycle --reverse --select-1 --exit-0 --bind=tab:down --bind=btab:up"

export XDG_CONFIG_HOME="$HOME/.config"

export GOPATH="$HOME/.go"

export PATH="/usr/local/go/bin:$HOME/.deno/bin:$HOME/.fnm:$HOME/.local/bin:$PATH"

if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
elif  [[ "$OSTYPE" == "linux-gnu"* ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [[ -e "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

if [[ -e "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

if type fnm > /dev/null 2>&1; then
  eval "$(fnm env --use-on-cd)"
fi

if type starship > /dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

function fzf_history() {
  BUFFER=$(history -n -r 1 | fzf -e +s +m --query="$LBUFFER" --prompt="history > ")
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N fzf_history
bindkey '^r' fzf_history

function fzf_ghq() {
  local repository=$(ghq list | fzf +m --query="$LBUFFER" --prompt="repository > ")
  if [[ -n "$repository" ]]; then
    BUFFER="cd $(ghq root)/${repository}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf_ghq
bindkey '^g' fzf_ghq

function fzf_switch() {
  local branch=$(git for-each-ref --format='%(refname:short)' refs/heads refs/remotes | sed 's/origin\///' | awk '!a[$1]++' | grep -x -v 'HEAD' | grep -x -v $(git symbolic-ref --short HEAD) | fzf +m --query="$LBUFFER" --prompt="branch > ")
  if [[ -n "$branch" ]]; then
    BUFFER="git switch ${branch}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf_switch
bindkey '^b' fzf_switch

function dev() {
  if [[ -e "pnpm-lock.yaml" ]]; then
    pnpm run dev
  elif [[ -e "package-lock.json" ]]; then
    npm run dev
  fi
}

function build() {
  if [[ -e "pnpm-lock.yaml" ]]; then
    pnpm run build
  elif [[ -e "package-lock.json" ]]; then
    npm run build
  fi
}

alias cd-="cd -"
alias cds="cd ~/work/sandbox"

if type npm > /dev/null; then
  alias nd="npm run dev"
  alias nb="npm run build"
  alias ns="npm run start"
  alias nf="npm run fmt"
  alias nl="npm run lint"
  alias nt="npm run test"
  alias ng="npm ls -g --depth=0"
fi

if type exa > /dev/null; then
  alias l="exa -F"
  alias ls="exa -F"
  alias la="exa -Fa"
  alias ll="exa -bhlHF --sort=type --time-style=long-iso"
  alias lla="exa -bhlHFa --sort=type --time-style=long-iso"
else
  alias l="ls -hFG"
  alias ls="ls -hFG"
  alias la="ls -hA"
  alias ll="ls -hl"
  alias lla="ls -hAlF"
fi

if type code > /dev/null; then
  alias code.="code ."
  alias coder="code . --reuse-window"
  alias codeextensions="code --list-extensions | xargs -L 1 echo code --install-extension"
fi

if type git > /dev/null; then
  alias gpl="git pull"
  alias gps="git push"
  alias gf="git fetch"
  alias gs="git status --short --branch"
  alias gl="git log -n 10 --date=short --pretty=format:'%C(yellow)%h %C(green)%cd %C(blue)%cn %C(reset)%s'"
  alias gll="git log --date=short --pretty=format:'%C(yellow)%h %C(green)%cd %C(blue)%cn %C(reset)%s'"
  alias gb="git branch"
  alias gbl="git branch -a -vv"
  alias ga="git add"
  alias gd="git diff"
  alias gdc="git diff --cached"
  alias gdw="git diff --color-words"
  alias gds="git diff --color-words --word-diff-regex='\\\w+|[^[:space:]]'"
  alias gnew="git switch --create"
  alias grs="git restore"
  alias gun="git reset HEAD"
  alias gcm="git commit --message"
  alias gini="git commit --allow-empty -m 'chore: initial empty commit'"
  alias gam="git commit --amend -C HEAD"
  alias grecm="git commit --amend -m"
fi

if type clip.exe > /dev/null 2>&1; then
  alias pbcopy="clip.exe"
fi

if type powershell.exe > /dev/null 2>&1; then
  alias pbpaste="powershell.exe -command 'Get-Clipboard'"
fi
