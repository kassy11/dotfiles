#!/bin/zsh

printf '\033[32m%s\033[m\n' 'Installing commnad line tools...'
xcode-select --install

printf '\033[32m%s\033[m\n' 'Installing homebrew...'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

printf '\033[32m%s\033[m\n' 'Run brew update'
brew update

printf '\033[32m%s\033[m\n' 'Installing homebrew packages...'
brew bundle

printf '\033[32m%s\033[m\n' 'Run brew upgrade and cleanup...'
brew upgrade && brew cleanup

printf '\033[32m%s\033[m\n' 'Remove some files for symlinks'
rm -rf ~/.zshrc ~/.zprofile ~/.gitconfig ~/.vimrc ~/.commit_template ~/.config/starship.toml

printf '\033[32m%s\033[m\n' 'Make symbolic links...'
ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.zprofile ~/.zprofile
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.gitignore_global ~/.gitignore_global
ln -sf $(pwd)/.vimrc ~/.vimrc
ln -sf $(pwd)/.commit_template ~/.commit_template
ln -s  $(pwd)/.config/starship.toml ~/.config/starship.toml
ln -s $(pwd)/clean.sh ~/clean.sh

printf '\033[32m%s\033[m\n' 'Source .zshrc...'
source ~/.zshrc

printf '\033[32m%s\033[m\n' 'Installing JVM languages through sdkman...'
if [ ! -e ~/.sdkman ];then
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk env init
  sdk install java
fi

exec $SHELL -l
echo -e "\e[32m finish setting!\e[0m"
