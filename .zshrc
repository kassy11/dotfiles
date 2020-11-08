# ----------------------------------
# environment
#-----------------------------------
# prompt
cdpath=(~)

zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' insert-tab false
zstyle ':completion:*:default' menu select=2

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

function fzf-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | fzf --layout=reverse`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-history-selection
bindkey '^R' fzf-history-selection

# wakatime
export ZSH_WAKATIME_PROJECT_DETECTION=true

# oh-my-zsh
plugins=(
  git
  bundler
  dotenv
  osx
  aws
  cargo
  gradle
  vagrant
  sbt
  brew
  node
  pip
  pyenv
  yarn
  zsh-interactive-cd
  zsh-navigation-tools
  vscode
  docker
  docker-compose
  ripgrep
  go
  golang
  npm
  rust
  repo
  sudo
  tig
  rake
  rbenv
  ruby
  zsh-wakatime
)

# anyenv
eval "$(anyenv init -)"

# nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# ocaml
eval "$(opam env)"

# golang
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

# goby
export GOBY_ROOT=$GOPATH/src/github.com/goby-lang/goby

# ruby
eval "$(rbenv init -)"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1"

# zsh+
export MANPATH="/usr/local/share/man/ja_JP.UTF-8:$(manpath)"
export PATH="/usr/local/opt/binutils/bin:$PATH"
fpath=(/path/to/homebrew/share/zsh-completions $fpath)
autoload -U compinit
compinit -u
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PATH="/usr/local/sbin:$PATH"
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# local/bin my commands
export PATH="$HOME/local/bin:$PATH"

# psql
export PATH="/usr/local/Cellar/postgresql/12.3_4/bin:$PATH"
export PGDATA='/usr/local/var/postgres'

# jenv
export JENV_ROOT="$HOME/.jenv"
if [ -d "${JENV_ROOT}" ]; then
  export PATH="$JENV_ROOT/bin:$PATH"
  eval "$(jenv init -)"
fi

# mysql
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# pkg-config to find openblas
export PKG_CONFIG_PATH="/usr/local/opt/openblas/lib/pkgconfig"

# julia
export PATH="/Applications/Julia-1.5.app/Contents/Resources/julia/bin:$PATH"

# rust
export PATH="/Users/kotarokashihara/.cargo/bin:$PATH"

# python
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/kotarokashihara/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/kotarokashihara/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/kotarokashihara/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/kotarokashihara/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
export PYENV_ROOT=${HOME}/.pyenv
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# zinit
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk


# ----------------------------------
# alias
#-----------------------------------
## basics
alias ls='ls -F'
alias la='ls -a'
alias ll='exa -ahl --git'
alias vi='vim'
alias rm='trash'
alias c='\cat'
alias cat='bat'
alias ps='procs'
alias p='\ps'
alias grep='rg'
alias dfind='fd'
alias ..='cd ..'
alias mv='mv -i'
alias cp='cp -i'
alias mkdir='mkdir -p'
alias so='source'
alias soz='source ~/.zshrc'
alias dcom='docker-compose'
alias path="echo $PATH | gsed 's/:/\n/g'"
alias clean="rm -rf *(*)"
alias brewup='brew update && brew upgrade && brew cleanup'
alias docker9cc='docker run --rm -it -v $HOME/Develop/my-dev/9cc:/home/user/9cc compilerbook'
alias python='python3'
alias ocaml="rlwrap ocaml"
alias tl="tldr"
alias fzf='fzf --layout=reverse'
### open Jetbrains IDE
alias goland="open -b com.jetbrains.goland"
alias intelliJ="open -b com.jetbrains.intelliJ"
alias clion="open -b com.jetbrains.clion"
alias pycharm="open -b com.jetbrains.pycharm"
alias rubymine="open -b com.jetbrains.rubymine"
alias webstorm="open -b com.jetbrains.webstorm"
## abount git & local repo
alias get='ghq get -p'
alias co='git checkout $(git branch -a | tr -d " " |fzf --layout=reverse --height 100% --prompt "CHECKOUT BRANCH>" --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")' 
### checkout previewing commit log 
alias d='cd $(ghq root)/github.com'
### cd ghq project
alias gcd='cd $(ghq root)/$(ghq list | fzf --layout=reverse --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")'
### gcd with key-bind
function ghq-fzf() {
  local src=$(ghq list | fzf --layout=reverse --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf
### gcd with project name
ghq-cd () {
    if [ -n "$1" ]; then
        dir="$(ghq list --full-path --exact "$1")"
        if [ -z "$dir" ]; then
            echo "no directroies found for '$1'"
            return 1
        fi
        cd "$dir"
        return
    fi
    echo 'usage: ghq-cd $repo'
    return 1
}
alias repo='hub browse .' ### open github.com page
alias grepo='hub browse $(ghq list | fzf --layout=reverse --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*" | cut -d "/" -f 2,3)'
alias updaterepo='ghq list | ghq get --update --parallel'
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi


