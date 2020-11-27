#!/bin/zsh

printf '\033[32m%s\033[m\n' 'installing xcode...'
xcode-select --install

printf '\033[32m%s\033[m\n' 'installing homebrew...'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

printf '\033[32m%s\033[m\n' 'run brew update'
brew update

printf '\033[32m%s\033[m\n' 'installing homebrew packages...'
brew bundle

printf '\033[32m%s\033[m\n' 'run brew upgrade and cleanup...'
brew upgrade && brew cleanup

printf '\033[32m%s\033[m\n' 'remove some files for symlinks'
rm -rf ~/.zshrc ~/.zprofile ~/.gitconfig ~/.vimrc ~/.commit_template ~/.config/starship.toml
rm -rf ~/.ocamlinit ~/.octaverc

printf '\033[32m%s\033[m\n' 'make symbolic links...'
ln -sf $(pwd)/.zshrc ~/.zshrc 
ln -sf $(pwd)/.zprofile ~/.zprofile
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.vimrc ~/.vimrc
ln -sf $(pwd)/.commit_template ~/.commit_template
ln -s  $(pwd)/.config/starship.toml ~/.config/starship.toml
ln -sf $(pwd)/.ocamlinit  ~/.ocamlinit
ln -sf $(pwd)/.octaverc ~/.octaverc
ln -s  $(pwd)/.tmux.conf ~/.tmux.conf
ln -s $(pwd)/homebrew-update.plist ~/Library/LaunchAgents/homebrew-update.plist
launchctl load ~/Library/LaunchAgents/homebrew-update.plist

printf '\033[32m%s\033[m\n' 'source .zshrc...'
source ~/.zshrc

printf '\033[32m%s\033[m\n' 'installing xxxenv...'
opam init
anyenv install --init
anyenv install rbenv 
anyenv install goenv
anyenv install jenv
anyenv install nodenv
anyenv install scalaenv
anyenv install sbtenv

printf '\033[32m%s\033[m\n' 'installing vim color scheme...'
git clone  https://github.com/altercation/vim-colors-solarized.git ~/vim-colors-solarized
mkdir -p ~/.vim/colors/
cp ~/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/

exec $SHELL -l
echo -e "\e[32m finish setting!\e[0m"
