cdpath=(~)

zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' insert-tab false
zstyle ':completion:*:default' menu select=2

export LESS='--no-init'
export GIT_PAGER="less -R"

# alias
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
alias find='fd'
alias ..='cd ..'
alias mv='mv -i'
alias cp='cp -i'
alias mkdir='mkdir -p'
alias so='source'
alias dcom='docker-compose'
alias d='cd ~/Desktop'
alias dd='cd ~/Develop/my-dev'
alias dj='cd ~/Develop/job-dev'
alias duni='cd ~/Develop/uni-dev'
alias di='cd ~/Develop/input-dev'
alias path="echo $PATH | gsed 's/:/\n/g'"
alias brewup='brew update && brew upgrade && brew cleanup'
alias docker9cc='docker run --rm -it -v $HOME/Develop/my-dev/9cc:/home/user/9cc compilerbook'

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

# ruby
eval "$(rbenv init -)"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1"

# zsh
export MANPATH="/usr/local/share/man/ja_JP.UTF-8:$(manpath)"
export PATH="/usr/local/opt/binutils/bin:$PATH"
fpath=(/path/to/homebrew/share/zsh-completions $fpath)
autoload -U compinit
compinit -u
eval "$(starship init zsh)"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PATH="/usr/local/sbin:$PATH"
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ngrok
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
