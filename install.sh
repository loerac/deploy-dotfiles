#!/bin/bash

check_error() {
	if [ $? -ne 0 ]; then
		echo "ERROR: ${1}"
		exit 1
	fi
}

WORKING_DIR=${HOME}
BIN_PATH=${WORKING_DIR}/.bin
#i3_PATH=${WORKING_DIR}/.config/i3

# Copy the dotfiles
echo -n "copying dotfiles...   "
cp .vimrc ${WORKING_DIR}
cp -r .vim/ ${WORKING_DIR}
cp .tmux.conf ${WORKING_DIR}
#cat .bashrc >> ${WORKING_DIR}/.bashrc
cat .zshrc >> ${WORKING_DIR}/.zshrc
#cp .Xdefaults ${WORKING_DIR}
#cp .printActiveIP.sh ${WORKING_DIR}
mkdir -p ${BIN_PATH}
check_error "Failed to make directory ${BIN_PATH}"

echo "Success! [dotfiles copied]"
echo

# i3 setup
#echo "setting up i3 configs..."
#mkdir -p ${i3_PATH}                     # i3 config directory
#check_error "Failed to make directory ${i3_PATH}"

#cp 1.jpg ${i3_PATH}                     # starter wallpaper
#cp config ${i3_PATH}                    # i3 core config
#cp randWallPaper.sh ${BIN_PATH}         # wallpaper randomizer
#cp .i3status.conf ${WORKING_DIR}        # status conf
#cp mac.conf /etc/NetworkManager/conf.d/ # mac address randomization
#echo "Success! [i3 config copied]"
#echo

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
git_conf=$(echo "${git_conf}" | awk '{print tolower($0)}')

# Git config
if [ "y" == "${git_conf}" ]; then
	echo -n "Enter user.name: "
	read name
    echo ""
	echo -n "Enter user.email: "
	read email
    echo ""
	echo -n "Enter core.editor: "
	read editor
    echo ""
    	echo -n "Enter help.autocorrect: "
	read auto_time
    echo ""
	git config --global user.name "$name"
	git config --global user.email "$email"
	git config --global core.editor "$editor"
	git config --global help.autocorrect "$auto_time"
    echo "Success! [git settings setup]"
fi

source $HOME/.bashrc
