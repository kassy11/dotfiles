#!/bin/zsh

printf '\033[32m%s\033[m\n' 'Installing commnad line tools...'
xcode-select --install

printf '\033[32m%s\033[m\n' 'Installing homebrew...'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

printf '\033[32m%s\033[m\n' 'Run brew update'
brew update

printf '\033[32m%s\033[m\n' 'Installing homebrew packages...'
brew bundle

printf '\033[32m%s\033[m\n' 'Run brew upgrade and cleanup...'
brew upgrade && brew cleanup

printf '\033[32m%s\033[m\n' 'Remove some files for symlinks'
rm -rf ~/.zshrc ~/.zprofile ~/.gitconfig ~/.vimrc ~/.commit_template ~/.config/starship.toml
rm -rf ~/.ocamlinit ~/.octaverc

printf '\033[32m%s\033[m\n' 'Make symbolic links...'
ln -sf $(pwd)/.zshrc ~/.zshrc 
ln -sf $(pwd)/.zprofile ~/.zprofile
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.gitignore_global ~/.gitignore_global
ln -sf $(pwd)/.vimrc ~/.vimrc
ln -sf $(pwd)/.commit_template ~/.commit_template
ln -s  $(pwd)/.config/starship.toml ~/.config/starship.toml
ln -s  $(pwd)/.config/gh/config.yml ~/.config/gh/config.yml
ln -sf $(pwd)/.ocamlinit  ~/.ocamlinit
ln -sf $(pwd)/.octaverc ~/.octaverc
ln -s  $(pwd)/.tmux.conf ~/.tmux.conf

printf '\033[32m%s\033[m\n' 'Source .zshrc...'
source ~/.zshrc

printf '\033[32m%s\033[m\n' 'Installing zplug...'
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer

printf '\033[32m%s\033[m\n' 'Installing xxxenv...'

if [ ! -e ~/.anyenv ];then
  printf '\033[32m%s\033[m\n' 'Init anyenv...'
  anyenv install --init
fi
if [ ! -e ~/.anyenv/envs/nodenv ];then
  printf '\033[32m%s\033[m\n' 'Installing node through nodenv...'
  anyenv install nodenv
  nodenv install 15.2.1
fi
if [ ! -e ~/.anyenv/envs/rbenv ];then
  printf '\033[32m%s\033[m\n' 'Installing ruby through rbenv...'
  anyenv install rbenv
  rbenv install 3.0.0
fi
if [ ! -e ~/.anyenv/envs/goenv ];then
  printf '\033[32m%s\033[m\n' 'Installing golang through goenv...' 
  anyenv install goenv
  goenv install 1.15.3
fi
if [ ! -e ~/.anyenv/envs/pyenv ];then
  printf '\033[32m%s\033[m\n' 'Installing golang through goenv...' 
  anyenv install pyenv
  pyenv install 3.9.0
fi

printf '\033[32m%s\033[m\n' 'Init opam...'
if [ ! -e ~/.opam ];then
  opam init
fi

printf '\033[32m%s\033[m\n' 'Installing JVM languages through sdkman...'
if [ ! -e ~/.sdkman ];then
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk env init
  sdk install java
  sdk install gradle
  sdk install maven
  sdk install kotlin
  sdk install groovy
  sdk install sbt
fi

printf '\033[32m%s\033[m\n' 'installing vim color scheme...'
if [ ! -e ~/vim-colors/vim-color-solarized ];then
  mkdir ~/vim-colors
  git clone  https://github.com/altercation/vim-colors-solarized.git ~/vim-colors/vim-colors-solarized
fi
if [ ! -e ~/.vim/colors/solarized.vim ];then
  mkdir -p ~/.vim/colors/
  cp ~/vim-colors/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/
fi


exec $SHELL -l
echo -e "\e[32m finish setting!\e[0m"
