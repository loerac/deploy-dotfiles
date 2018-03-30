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
mkdir ~/.config/i3/ -p 
cp 1.jpg ~/.config/i3
cp config ~/.config/i3
cp randWallPaper.sh ~/bin
cp .i3status.conf ~/
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
	git config --global user.name "$name"
	git config --global user.email "$email"
    echo "Success! [git settings setup]"
fi
