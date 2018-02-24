#!/bin/bash


# Copy the dotfiles
echo "copying dotfiles...   "
cp .vimrc ~/
cp .tmux.conf ~/
echo .bashrc >> ~/.bashrc

echo "[dotfiles copied]"

# Install any required dependencies
echo "installing dependencies...   "
/bin/bash dependencies.sh 
echo "[dependencies installed]"


