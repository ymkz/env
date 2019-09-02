source $HOME/.zplug/init.zsh

zplug "zsh-users/zsh-completions", defer:0
zplug "zsh-users/zsh-autosuggestions", defer:0
zplug "zsh-users/zsh-history-substring-search", defer:1
zplug "zdharma/fast-syntax-highlighting", defer:1
zplug "mollifier/anyframe", defer:1
zplug "voronkovich/gitignore.plugin.zsh", defer:1
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug "zplug/zplug", hook-build:"zplug --self-manage"

if ! zplug check; then
  zplug install
fi

zplug load

autoload -Uz compinit; compinit
autoload -Uz colors; colors

zstyle ':completion:*:default' menu select=1
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

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

# activate `anyenv`
eval "$(anyenv init -)"

# activate `direnv`
eval "$(direnv hook zsh)"

# activate `yvm`
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh

# activate `fzf` keybinding and completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# alias `git`
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
alias gwip="git commit -m 'chore(wip): work-in-progress'"
alias gci="git commit --allow-empty -m 'chore(git): initialize'"

# alias `gomi`
alias rm="gomi -s"

# alias `simulator`
alias simulator="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"

# alias `ls` if `exa` is installed
if [[ -x `which exa` ]]; then
  alias l="exa -F"
  alias ls="exa -F"
  alias la="exa -Fa"
  alias lt="exa -T"
  alias ll="exa -bhlHF"
  alias lla="exa -bhlHFa"
else
  alias ls="ls -GF"
  alias la="ls -A"
  alias ll="ls -l"
  alias lla="ls -lA"
fi

# alias to passing files to `Yoink`
if [ -d "/Applications/Yoink.app" ]; then
  alias yoink="open -a Yoink"
fi

# bind `fzf` selector function with `anyframe`
bindkey '^b' anyframe-widget-checkout-git-branch
bindkey '^h' anyframe-widget-put-history
bindkey '^g' anyframe-widget-cd-ghq-repository
