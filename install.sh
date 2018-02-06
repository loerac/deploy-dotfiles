#!/bin/bash


# Copy the dotfiles
echo "copying dotfiles...   "
cp .vimrc ~/
cp .tmux.conf ~/
echo "[dotfiles copied]"

# Install any required dependencies
echo "installing dependencies...   "
/bin/bash dependency_install.sh 
echo "[dependencies installed]"
