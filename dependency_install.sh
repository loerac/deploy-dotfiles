
# get os-type to support debian AND centos
if [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then
	INSTALL='apt-get install'
else
	INSTALL='yum install' 
fi

# install vim
eval "sudo $INSTALL vim -y"

# install tmux
eval "sudo $INSTALL tmux -y"

# Example for installing Vundle, the Vim dependency manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/ctrlpvim/ctrlp.vim.git  ~/.vim/bundle/ctrlp.vim

# installing syntastic
vim +PluginInstall +qall
