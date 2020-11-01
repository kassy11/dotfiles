#!/bin/zsh

echo "installing homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "run brew update..."
brew update

echo "install homebrew packages..."
brew bundle
echo "successfully installed!"

echo "run brew upgrade and cleanup..."
brew upgrade && brew cleanup

echo "run brew doctor..."
brew doctor

echo "touch some files..."
touch ~/.zshrc ~/.zprofile ~/.gitconfig ~/.vimrc ~/.commit_template ~/.config/starship.toml
touch ~/.ocamlinit ~/.octaverc
echo "make symbolic links..."
ln -s .zhsrc ~/.zshrc 
ln -s .zprofile ~/.zprofile
ln -s .gitconfig ~/.gitconfig
ln -s .vimrc ~/.vimrc
ln -s .commit_template ~/.commit_template
ln -s .starship.toml ~/.config/starship.toml
ln -s .ocamlinit  ~/.ocamlinit
ln -s .octaverc ~/.octaverc
echo "successfully linked!"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "source .zshrc"
source ~/.zshrc
echo "finish setting!"