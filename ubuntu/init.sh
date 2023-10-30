#!/bin/zsh

printf '\033[32m%s\033[m\n' 'Remove some files for symlinks'
rm -rf ~/.zshrc ~/.zprofile ~/.gitconfig ~/.vimrc ~/.commit_template ~/.config/starship.toml

cd
# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
# starship
curl -sS https://starship.rs/install.sh | sh

# back to dotfiles
cd -

printf '\033[32m%s\033[m\n' 'Make symbolic links...'
ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.zprofile ~/.zprofile
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.gitignore_global ~/.gitignore_global
ln -sf $(pwd)/.vimrc ~/.vimrc
ln -sf $(pwd)/.commit_template ~/.commit_template
ln -s  $(pwd)/.config/starship.toml ~/.config/starship.toml

printf '\033[32m%s\033[m\n' 'Source .zshrc...'
source ~/.zshrc

exec $SHELL -l
echo -e "\e[32m finish setting!\e[0m"
