#!/bin/sh

printf '\033[32m%s\033[m\n' 'apt updating'
sudo apt update
sudo apt upgrade -y
sudo apt-get update
sudo apt-get upgrade -y

printf '\033[32m%s\033[m\n' 'Install zsh and set default'
sudo apt-get install zsh -y
chsh -s $(which zsh)
exec $SHELL -l

printf '\033[32m%s\033[m\n' 'Remove some files for symlinks'
rm -rf ~/.zshrc ~/.zprofile ~/.gitconfig ~/.vimrc ~/.commit_template ~/.config/starship.toml

printf '\033[32m%s\033[m\n' 'Install curl and git'
sudo apt install curl git -y

printf '\033[32m%s\033[m\n' 'Download some binary'
cd
# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
# starship
curl -sS https://starship.rs/install.sh | sh
# go
wget https://go.dev/dl/go1.21.3.linux-amd64.tar.gz
rm -rf ~/go && sudo tar -C ~/ -xzfgo1.21.3.linux-amd64.tar.gz
# Anaconda
wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
chmod +x Anaconda3-2023.09-0-Linux-x86_64.sh
./Anaconda3-2023.09-0-Linux-x86_64.sh
conda init zsh

# back to dotfiles
cd -
exec $SHELL -l

printf '\033[32m%s\033[m\n' 'Make symbolic links...'
ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.zprofile ~/.zprofile
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.gitignore_global ~/.gitignore_global
ln -sf $(pwd)/.vimrc ~/.vimrc
ln -sf $(pwd)/.commit_template ~/.commit_template
ln -s  $(pwd)/.config/starship.toml ~/.config/starship.toml
ln -sf $(pwd)/update.sh ~/update.sh

printf '\033[32m%s\033[m\n' 'Install some CLI tools'
go install github.com/x-motemen/ghq@latest
go install github.com/simonwhitaker/gibo@latest
cargo install tokei
cargo install exa
sudo apt install fzf bat trash-cli -y
sudo apt-get install ripgrep -y
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y

printf '\033[32m%s\033[m\n' 'Source .zshrc...'
source ~/.zshrc

exec $SHELL -l
echo -e "\e[32m finish setting!\e[0m"
