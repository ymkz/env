source "$HOME/.zinit/bin/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light "zsh-users/zsh-completions"
zinit light "zsh-users/zsh-autosuggestions"
zinit light "zsh-users/zsh-history-substring-search"
zinit light "zdharma/fast-syntax-highlighting"

if [[ "$OSTYPE" == "darwin"* ]]; then
  if builtin command -v brew > /dev/null; then
    FPATH="/usr/local/share/zsh/site-functions:$FPATH"
  fi
  if builtin command -v starship > /dev/null; then
    eval "$(starship init zsh)"
  fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if builtin command -v brew > /dev/null; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  fi
  if builtin command -v starship > /dev/null; then
    eval $(/home/linuxbrew/.linuxbrew/bin/starship init zsh)
  fi
fi

if [ -e "$HOME/.cargo" ]; then
  source "$HOME/.cargo/env"
fi

if [ -e "$HOME/.sdkman" ]; then
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

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
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_reduce_blanks

unsetopt caseglob
unsetopt promptcr

export LESS="-R"
export LANG="ja_JP.UTF-8"
export EDITOR="code --wait"
export FCEDIT="code --wait"

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000

export FZF_DEFAULT_OPTS="--height 40% --ansi --cycle --reverse --select-1 --exit-0 --bind=tab:down --bind=btab:up"

export XDG_CONFIG_HOME="$HOME/.config"
export VOLTA_HOME="$HOME/.volta"
export GOPATH="$HOME/.go"
export PATH="$HOME/.bin:$HOME/.cargo/bin:$VOLTA_HOME/bin:$PATH"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

function fzf-cd-under-current-dir() {
  local dir
  dir=$(find * -maxdepth 0 -type d -print 2> /dev/null | fzf +s +m --query="$LBUFFER" --prompt="dir > ")
  if [ -n "$dir" ]; then
    BUFFER="cd ${dir}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-cd-under-current-dir
bindkey '^f' fzf-cd-under-current-dir

function fzf-put-history() {
  BUFFER=$(history -n -r 1 | fzf +s +m --query="$LBUFFER" --prompt="history > ")
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N fzf-put-history
bindkey '^h' fzf-put-history

function fzf-cd-ghq-repository() {
  local repository=$(ghq list | fzf +m --query="$LBUFFER" --prompt="repository > ")
  if [ -n "$repository" ]; then
    BUFFER="cd $(ghq root)/${repository}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-cd-ghq-repository
bindkey '^g' fzf-cd-ghq-repository

function fzf-switch-git-branch() {
  local branch=$(git branch --all | grep -v HEAD | fzf +m --prompt="branch > ")
  if [ -n "$branch" ]; then
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
  fi
  zle accept-line
}
zle -N fzf-switch-git-branch
bindkey '^b' fzf-switch-git-branch

alias cd-="cd -"
alias cds="cd ~/workspace/sandbox"

alias nd="npm run dev"
alias nb="npm run build"
alias nf="npm run fmt"
alias nl="npm run lint"

if builtin command -v exa > /dev/null; then
  alias l="exa -F"
  alias ls="exa -F"
  alias la="exa -Fa"
  alias lt="exa -T"
  alias ll="exa -bhlHF"
  alias lla="exa -bhlHFa"
  alias llg="exa -bhlHFa --sort=type"
else
  alias l="ls -FG"
  alias ls="ls -FG"
  alias la="ls -A"
  alias ll="ls -l"
  alias lla="ls -AlF"
fi

if builtin command -v code > /dev/null; then
  alias code.="code ."
  alias coder="code . --reuse-window"
  alias codelistext="code --list-extensions | xargs -L 1 echo code --install-extension"
fi

if builtin command -v git > /dev/null; then
  alias gf="git fetch"
  alias gfp="git fetch --prune"
  alias gs="git status --short --branch"
  alias gl="git log --date=short --pretty=format:'%C(yellow)%h %Cgreen%cd %Cblue%cn %Creset%s'"
  alias gb="git branch"
  alias gbl="git branch -a -vv"
  alias gbd="git branch --merged | egrep -v '\*|develop|master' | xargs git branch -d"
  alias ga="git add"
  alias gd="git diff"
  alias gdc="git diff --cached"
  alias gdw="git diff --color-words"
  alias gds="git diff --color-words --word-diff-regex='\\\w+|[^[:space:]]"
  alias gnew="git switch --create"
  alias grs="git restore"
  alias grb="git rebase"
  alias gro="git rebase origin/master"
  alias gun="git reset HEAD"
  alias gcm="git commit --message"
  alias gini="git commit --allow-empty -m 'chore(git): initialize'"
  alias gam="git commit --amend -C HEAD"
  alias grecm="git commit --amend -m"
fi

if builtin command -v clip.exe > /dev/null; then
  alias pbcopy="clip.exe"
fi