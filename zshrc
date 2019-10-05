source $HOME/.zplug/init.zsh

zplug "zsh-users/zsh-completions", defer:0
zplug "zsh-users/zsh-autosuggestions", defer:0
zplug "zsh-users/zsh-history-substring-search", defer:1
zplug "zdharma/fast-syntax-highlighting", defer:1
zplug "voronkovich/gitignore.plugin.zsh", defer:1
zplug "zplug/zplug", hook-build:"zplug --self-manage"

if ! zplug check; then
  zplug install
fi

zplug load

if type "brew" &> /dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

if type "starship" &> /dev/null; then
  eval "$(starship init zsh)"
fi

if type "anyenv" &> /dev/null; then
  eval "$(anyenv init -)"
fi

if type "direnv" &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

if type "hub" &> /dev/null; then
  eval "$(hub alias -s)"
fi

autoload -Uz compinit; compinit
autoload -Uz colors; colors

zstyle ':completion:*:default' menu select=1
zstyle ':completion::complete:*' use-cache true
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

setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_reduce_blanks

unsetopt caseglob
unsetopt promptcr

[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh

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

alias cdw="cd ~/workspace"
alias cds="cd ~/workspace/sandbox"

alias gf="git fetch"
alias gp="git fetch --prune"
alias gs="git status --short --branch"
alias gl="git log --date=short --pretty=format:'%C(yellow)%h %Cgreen%cd %Cblue%cn %Creset%s'"
alias gr="git grep"
alias gb="git branch"
alias gbl="git branch -a -vv"
alias ga="git add"
alias gd="git diff"
alias gn="git switch -c"
alias grs="git restore"
alias grb="git rebase"
alias gu="git reset HEAD"
alias gcm="git commit -m"
alias grecm="git commit --amend -m"
alias gam="git commit --amend -C HEAD"
alias gwip="git commit -m 'chore(wip): work in progress'"
alias gci="git commit --allow-empty -m 'chore(git): initialize'"

if type "code" &> /dev/null; then
  alias codec="code ."
  alias coder="code . -r"
fi

if type "exa" &> /dev/null; then
  alias l="exa -F"
  alias ls="exa -F"
  alias la="exa -Fa"
  alias lt="exa -T"
  alias ll="exa -bhlHF"
  alias lla="exa -bhlHFa"
  alias llg="exa -bhlHFa --sort=type"
else
  alias l="ls -F --color=auto"
  alias ls="ls -F --color=auto"
  alias la="ls -A"
  alias ll="ls -lh"
  alias lla="ls -AlhF"
fi

if type "gomi" &> /dev/null; then
  alias rm="gomi -s"
fi

if [ -d "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" ]; then
  alias simulator="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
fi

if [ -d "/Applications/Yoink.app" ]; then
  alias yoink="open -a Yoink"
fi
