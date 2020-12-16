# ----------------------------------
# environment
#-----------------------------------
# prompt

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'e:|[._-]=* e:|=*' 'l:|=* e:|=*'
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
unsetopt cdable_vars
unsetopt cdablevars
## cdしたあとにlsするようにする
chpwd() {
    if [[ $(pwd) != $HOME ]]; then;
        ls
    fi
}

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

# path
export MANPATH="/usr/local/share/man/ja_JP.UTF-8:$(manpath)"
export PATH="/usr/local/opt/binutils/bin:$PATH"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
## jetbrains command
export PATH="/usr/local/sbin:$PATH"

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
alias py='python3'
alias p='python3'
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
alias crepo='gh repo create'
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

# # tmux
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

### zplug
source ~/.zplug/init.zsh

# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
zplug "zsh-users/zsh-syntax-highlighting"
# タイプ補完
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

#compdef _gh gh
# zsh completion for gh                                   -*- shell-script -*-

__gh_debug()
{
    local file="$BASH_COMP_DEBUG_FILE"
    if [[ -n ${file} ]]; then
        echo "$*" >> "${file}"
    fi
}

_gh()
{
    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16

    local lastParam lastChar flagPrefix requestComp out directive compCount comp lastComp
    local -a completions

    __gh_debug "\n========= starting completion logic =========="
    __gh_debug "CURRENT: ${CURRENT}, words[*]: ${words[*]}"

    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $CURRENT location, so we need
    # to truncate the command-line ($words) up to the $CURRENT location.
    # (We cannot use $CURSOR as its value does not work when a command is an alias.)
    words=("${=words[1,CURRENT]}")
    __gh_debug "Truncated words[*]: ${words[*]},"

    lastParam=${words[-1]}
    lastChar=${lastParam[-1]}
    __gh_debug "lastParam: ${lastParam}, lastChar: ${lastChar}"

    # For zsh, when completing a flag with an = (e.g., gh -n=<TAB>)
    # completions must be prefixed with the flag
    setopt local_options BASH_REMATCH
    if [[ "${lastParam}" =~ '-.*=' ]]; then
        # We are dealing with a flag with an =
        flagPrefix="-P ${BASH_REMATCH}"
    fi

    # Prepare the command to obtain completions
    requestComp="${words[1]} __complete ${words[2,-1]}"
    if [ "${lastChar}" = "" ]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go completion code.
        __gh_debug "Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi

    __gh_debug "About to call: eval ${requestComp}"

    # Use eval to handle any environment variables and such
    out=$(eval ${requestComp} 2>/dev/null)
    __gh_debug "completion output: ${out}"

    # Extract the directive integer following a : from the last line
    local lastLine
    while IFS='\n' read -r line; do
        lastLine=${line}
    done < <(printf "%s\n" "${out[@]}")
    __gh_debug "last line: ${lastLine}"

    if [ "${lastLine[1]}" = : ]; then
        directive=${lastLine[2,-1]}
        # Remove the directive including the : and the newline
        local suffix
        (( suffix=${#lastLine}+2))
        out=${out[1,-$suffix]}
    else
        # There is no directive specified.  Leave $out as is.
        __gh_debug "No directive found.  Setting do default"
        directive=0
    fi

    __gh_debug "directive: ${directive}"
    __gh_debug "completions: ${out}"
    __gh_debug "flagPrefix: ${flagPrefix}"

    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        __gh_debug "Completion received error. Ignoring completions."
        return
    fi

    compCount=0
    while IFS='\n' read -r comp; do
        if [ -n "$comp" ]; then
            # If requested, completions are returned with a description.
            # The description is preceded by a TAB character.
            # For zsh's _describe, we need to use a : instead of a TAB.
            # We first need to escape any : as part of the completion itself.
            comp=${comp//:/\\:}

            local tab=$(printf '\t')
            comp=${comp//$tab/:}

            ((compCount++))
            __gh_debug "Adding completion: ${comp}"
            completions+=${comp}
            lastComp=$comp
        fi
    done < <(printf "%s\n" "${out[@]}")

    if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
        # File extension filtering
        local filteringCmd
        filteringCmd='_files'
        for filter in ${completions[@]}; do
            if [ ${filter[1]} != '*' ]; then
                # zsh requires a glob pattern to do file filtering
                filter="\*.$filter"
            fi
            filteringCmd+=" -g $filter"
        done
        filteringCmd+=" ${flagPrefix}"

        __gh_debug "File filtering command: $filteringCmd"
        _arguments '*:filename:'"$filteringCmd"
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only
        local subDir
        subdir="${completions[1]}"
        if [ -n "$subdir" ]; then
            __gh_debug "Listing directories in $subdir"
            pushd "${subdir}" >/dev/null 2>&1
        else
            __gh_debug "Listing directories in ."
        fi

        _arguments '*:dirname:_files -/'" ${flagPrefix}"
        if [ -n "$subdir" ]; then
            popd >/dev/null 2>&1
        fi
    elif [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ] && [ ${compCount} -eq 1 ]; then
        __gh_debug "Activating nospace."
        # We can use compadd here as there is no description when
        # there is only one completion.
        compadd -S '' "${lastComp}"
    elif [ ${compCount} -eq 0 ]; then
        if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
            __gh_debug "deactivating file completion"
        else
            # Perform file completion
            __gh_debug "activating file completion"
            _arguments '*:filename:_files'" ${flagPrefix}"
        fi
    else
        _describe "completions" completions $(echo $flagPrefix)
    fi
}

# don't run the completion function when being source-ed or eval-ed
if [ "$funcstack[1]" = "_gh" ]; then
	_gh
fi

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/kotarokashihara/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;
# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
}
compctl -K _pip_completion pip
# pip zsh completion end

