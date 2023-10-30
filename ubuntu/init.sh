#!/bin/zsh

printf '\033[32m%s\033[m\n' 'apt updating'
sudo apt update
sudo apt upgrade -y

printf '\033[32m%s\033[m\n' 'Remove some files for symlinks'
rm -rf ~/.zshrc ~/.zprofile ~/.gitconfig ~/.vimrc ~/.commit_template ~/.config/starship.toml

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

printf '\033[32m%s\033[m\n' 'Intall some CLI tools'
go install github.com/x-motemen/ghq@latest
cargo install tokei
sudo apt install exa -y
sudo apt install fzf -y
sudo apt install fd-find -y
sudo apt install trash-cli -y
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
