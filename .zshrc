# zsh settings
typeset -U path cdpath fpath manpath
autoload -U compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'e:|[._-]=* e:|=*' 'l:|=* e:|=*'
autoload colors
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' insert-tab false
zstyle ':completion:*:default' menu select=2
autoload -U zmv
bindkey -e
setopt share_history
setopt histignorealldups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt auto_pushd
setopt pushd_ignore_dups
setopt correct
setopt no_beep
unsetopt cdable_vars
unsetopt cdablevars

# zplug settings
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"
zplug "simonwhitaker/gibo", use:'shell-completions/gibo-completion.zsh', as:plugin #verify
## install zplug packages
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

# tool settings
## sdkman
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
## goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
## pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
## nodenv
eval "$(nodenv init -)"
## rbenv
eval "$(rbenv init - zsh)"
## starship
eval "$(starship init zsh)"


# ----------------------------------
# alias and shell-func
#-----------------------------------
alias ls='exa -F'
alias la='exa -aF'
alias ll='exa -alF'
alias vi='vim'
alias rm='trash'
alias cat='bat'
alias grep='rg'
alias dfind='fd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias back='cd -'
alias mv='mv -i'
alias cp='cp -i'
alias mkdir='mkdir -p'
alias so='source'
alias soz='source ~/.zshrc'
alias path="echo $PATH | gsed 's/:/\n/g'"
alias brewup='brew update && brew upgrade && brew upgrade && brew cleanup'
alias tl="tldr"
alias fzf='fzf --layout=reverse'
alias typora="open -a typora"

### ls-a after cd
chpwd() {
    if [[ $(pwd) != $HOME ]]; then;
        ls -a
    fi
}

### history with fzf
function fzf-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | fzf --layout=reverse`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-history-selection
bindkey '^R' fzf-history-selection

### ghq get with SSH
alias get='ghq get -p'
### git checkout with fzf
function co() {
  local branch
  branch=$(git branch -a | tr -d " " |fzf --layout=reverse --height 100% --prompt "checkout branch>" --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")
  git checkout $(echo "$branch")
  zle accept-line
}
### delete merged branch
alias brad='git branch --merged | egrep -v "\*|master|develop" | xargs git branch -D'

### clone specific repo
function gclone(){
  local repo
  repo=$(gh repos $(echo "$1") | fzf --layout=reverse --height 100% --prompt "repositories>")
  ghq get -p $(echo "$repo")
  zle accept-line
}

alias github='open https://github.com/kassy11'

### cd ghq project
function ghq-fzf() {
  local src=$(ghq list | fzf --layout=reverse --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/(README|readme).*")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf

### open repo top page
alias repo='gh repo view --web'

### open specific repo page
function grepo(){
  local repo
  repo=$(gh repos $(echo "$1") | fzf --layout=reverse --height 100% --prompt "repositories>")
  gh repo view $(repo) --web
  zle accept-line
}

### create repo
alias crepo='gh repo create'

### open PR page of current branchgh
alias pr="gh pr view --web"

### open PR page of specific PR num
function gpr(){
  local pr=$(gh pr list |fzf --layout=reverse --height 100% --prompt "Pull Requests>")
  local prnum=$(echo $pr | awk '{print $1}')
  gh pr view $(echo $prnum) --web
}

if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

# brew completion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi
