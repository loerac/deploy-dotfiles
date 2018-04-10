#!/bin/bash

# Copy the dotfiles
echo -n "copying dotfiles...   " 
cp .vimrc ~/
cp .tmux.conf ~/
cat .bashrc >> ~/.bashrc
cp .Xdefaults ~/
cp .printActiveIP.sh ~/
mkdir ~/bin/ -p 
cp google ~/bin/
echo "Success! [dotfiles copied]"
echo 

# i3 setup
echo "setting up i3 configs..."
mkdir ~/.config/i3/ -p                  # i3 config directory
cp 1.jpg ~/.config/i3                   # starter wallpaper
cp config ~/.config/i3                  # i3 core config
cp randWallPaper.sh ~/bin               # wallpaper randomizer
cp .i3status.conf ~/                    # status conf
cp mac.conf /etc/NetworkManager/conf.d/ # mac address randomization
echo "Success! [i3 config copied]"
echo

# Install any required dependencies
echo -n "install applications from dependencies.sh? [y/n] "
read install
install=$(echo "$install" | awk '{print tolower($0)}')

if [ "y" == "$install" ]; then
	echo -n "installing dependencies...   " 
	/bin/bash dependencies.sh 
	echo "Success! [dependencies installed]"
    echo ""
fi

# Setup git config
echo -n "Setup git settings? [y/n] "
read git_conf
git_conf=$(echo "$git_conf" | awk '{print tolower($0)}')

# Git config
if [ "y" == "$git_conf" ]; then
	echo -n "Enter user.name: " 
	read name
    echo ""
	echo -n "Enter user.email: " 
	read email
    echo ""
	echo -n "Enter core.editor: " 
	read editor
    echo ""
	git config --global user.name "$name"
	git config --global user.email "$email"
	git config --global core.editor "$editor"
    echo "Success! [git settings setup]"
fi
