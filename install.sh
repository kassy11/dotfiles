#!/bin/zsh

echo -e "\e[32m installing xcode... \e[0m"
xcode-select --install

echo -e "\e[32m installing homebrew...\e[0m"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo -e "\e[32m run brew update...\e[0m"
brew update

echo -e "\e[32m install homebrew packages...\e[0m"
brew bundle
echo -e "\e[32m successfully installed! \e[0m"

echo -e "\e[32m run brew upgrade and cleanup...\e[0m"
brew upgrade && brew cleanup

echo -e "\e[32m rm some files...\e[0m"
rm -rf ~/.zshrc ~/.zprofile ~/.gitconfig ~/.vimrc ~/.commit_template ~/.config/starship.toml
rm -rf ~/.ocamlinit ~/.octaverc
echo -e "\e[32m make symbolic links...\e[0m"
ln -sf $(pwd)/.zshrc ~/.zshrc 
ln -sf $(pwd)/.zprofile ~/.zprofile
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.vimrc ~/.vimrc
ln -sf $(pwd)/.commit_template ~/.commit_template
ln -sf $(pwd)/starship.toml ~/.config/starship.toml
ln -sf $(pwd)/.ocamlinit  ~/.ocamlinit
ln -sf $(pwd)/.octaverc ~/.octaverc
echo -e "\e[32m successfully linked!\e[0m"

echo -e "\e[32m source .zshrc\e[0m"
source ~/.zshrc

# echo -e "\e[32m installing some repositories...\e[0m"
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# mkdir -p $(anyenv root)/plugins
# git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
# anyenv install rbenv nodenv goenv pyenv jenv

exec $SHELL -l
echo -e "\e[32m finish setting!\e[0m"
