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

# sdkman
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/kotarokashihara/.sdkman"
[[ -s "/Users/kotarokashihara/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/kotarokashihara/.sdkman/bin/sdkman-init.sh"

# ruby
eval "$(rbenv init -)"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1"

# zsh
export MANPATH="/usr/local/share/man/ja_JP.UTF-8:$(manpath)"
export PATH="/usr/local/opt/binutils/bin:$PATH"
## zsh-completion
if type brew &>/dev/null; then
  FPATH=/usr/local/share/zsh-completions:/path/to/homebrew/share/zsh-completions:/Users/kotarokashihara/.zinit/completions:/path/to/homebrew/share/zsh-completions:/usr/local/share/zsh/site-functions:/usr/share/zsh/site-functions:/usr/share/zsh/5.8/functions

  autoload -Uz compinit
  compinit
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
## jetbrains command
export PATH="/usr/local/sbin:$PATH"
## zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
## zsh-autosuggest
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# local/bin my commands
export PATH="$HOME/local/bin:$PATH"

# psql
export PATH="/usr/local/Cellar/postgresql/12.3_4/bin:$PATH"
export PGDATA='/usr/local/var/postgres'

# hub
eval "$(hub alias -s)"

# mysql
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# pkg-config to find openblas
export PKG_CONFIG_PATH="/usr/local/opt/openblas/lib/pkgconfig"

# julia
export PATH="/Applications/Julia-1.5.app/Contents/Resources/julia/bin:$PATH"

# rust
export PATH="/Users/kotarokashihara/.cargo/bin:$PATH"

# android
export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"

# brew
export PATH="/usr/local/sbin:$PATH"


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

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###



# ----------------------------------
# alias
#-----------------------------------
## basics
alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin brew"
alias ls='ls -F'
alias la='ls -a'
alias ll='ls -alF'
alias vi='vim'
alias rm='trash'
alias cat='bat'
alias ps='procs'
alias p='\ps'
alias top='htop'
alias t='\top'
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
alias dcom='docker-compose'
alias docom='docker-compose'
alias path="echo $PATH | gsed 's/:/\n/g'"
alias clean="rm -rf *(*)"
alias brewup='brew update && brew upgrade && brew upgrade --cask && brew cleanup'
alias docker9cc='docker run --rm -it -v $HOME/Develop/my-dev/9cc:/home/user/9cc compilerbook'
alias python='python3'
alias ocaml="rlwrap ocaml"
alias tl="tldr"
alias fzf='fzf --layout=reverse'
alias moji='(){echo -n $1 | tr -d '\n' | wc -m}'
alias word='(){echo -n $1 | tr -d '\n' | wc -w}'
## abount git & local repo
alias get='ghq get -p'
## git checkout woth fzf
alias co='git checkout $(git branch -a | tr -d " " |fzf --layout=reverse --height 100% --prompt "CHECKOUT BRANCH>" --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")' 
alias github='open https://github.com/kassy11'
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
bindkey '^]' ghq-fzf ## control+]でgcdが起動するように
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
alias repo='git browse' ### open github.com page
alias grepo='git browse $(ghq list | fzf --layout=reverse --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*" | cut -d "/" -f 2,3)'
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi


# tmux
# function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
# function is_osx() { [[ $OSTYPE == darwin* ]]; }
# function is_screen_running() { [ ! -z "$STY" ]; }
# function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
# function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
# function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
# function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

# function tmux_automatically_attach_session()
# {
#     if is_screen_or_tmux_running; then
#         ! is_exists 'tmux' && return 1

#         if is_tmux_runnning; then
#             echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
#             echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
#             echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
#             echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
#             echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
#         elif is_screen_running; then
#             echo "This is on screen."
#         fi
#     else
#         if shell_has_started_interactively && ! is_ssh_running; then
#             if ! is_exists 'tmux'; then
#                 echo 'Error: tmux command not found' 2>&1
#                 return 1
#             fi

#             if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
#                 # detached session exists
#                 tmux list-sessions
#                 echo -n "Tmux: attach? (y/N/num) "
#                 read
#                 if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
#                     tmux attach-session
#                     if [ $? -eq 0 ]; then
#                         echo "$(tmux -V) attached session"
#                         return 0
#                     fi
#                 elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
#                     tmux attach -t "$REPLY"
#                     if [ $? -eq 0 ]; then
#                         echo "$(tmux -V) attached session"
#                         return 0
#                     fi
#                 fi
#             fi

#             if is_osx && is_exists 'reattach-to-user-namespace'; then
#                 # on OS X force tmux's default command
#                 # to spawn a shell in the user's namespace
#                 tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
#                 tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
#             else
#                 tmux new-session && echo "tmux created new session"
#             fi
#         fi
#     fi
# }
# tmux_automatically_attach_session

# ### Added by Zinit's installer
# if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
#     print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
#     command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
#     command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
#         print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
#         print -P "%F{160}▓▒░ The clone has failed.%f%b"
# fi

# source "$HOME/.zinit/bin/zinit.zsh"
# autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit

# # Gitの変更状態がわかる ls。ls の代わりにコマンド `k` を実行するだけ。
# zinit light supercrabtree/k
# # AWS CLI v2の補完。
# # 要 AWS CLI v2
# # この順序で記述しないと `complete:13: command not found: compdef` のようなエラーになるので注意
# autoload bashcompinit && bashcompinit
# source ~/.zinit/plugins/drgr33n---oh-my-zsh_aws2-plugin/aws2_zsh_completer.sh
# complete -C '/usr/local/bin/aws_completer' aws
# zinit light drgr33n/oh-my-zsh_aws2-plugin
# # iTerm2を使っている場合に、コマンド `tt タブ名` でタブ名を変更できる
# zinit light gimbo/iterm2-tabs.zsh
# ### End of Zinit's installer chunk


