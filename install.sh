#!/bin/bash


# Copy the dotfiles
echo "copying dotfiles...   "
cp .vimrc ~/
cp .tmux.conf ~/
cat .bashrc >> ~/.bashrc

echo "[dotfiles copied]"

# Install any required dependencies
echo "installing dependencies...   "
/bin/bash dependencies.sh 
echo "[dependencies installed]"

# Setup git config
echo "Setup git settings? [y/n]"
read git_conf
git_conf = $(echo "$git_conf" | awk '{print tolower($0)}')

if [ "y" == "$git_conf" ]; then
	echo "Enter user.name: "
	read name
	echo "Enter user.email: "
	read email
	git config --global user.name "$name"
	git config --global user.email "$email"

fi
