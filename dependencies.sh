# Returns -1 if not subset
strindex() {
  x="${1%%$2*}"
  [[ "$x" = "$1" ]] && echo -1 || echo "${#x}"
}


# get os-type to select multiple package managers
ID_LIKE=`awk -F= '/^ID_LIKE/{print $2}' /etc/os-release`
ID=`awk -F= '/^ID/{print $2}' /etc/os-release`
VERSION_ID=`awk -F= '/^VERSION_ID/{print $2}' /etc/os-release`

# Get the distro family
DEBIAN=`strindex "$ID_LIKE" 'debian'`
FEDORA=`strindex "$ID_LIKE" 'fedora'`
SUSE=`strindex "$ID_LIKE" 'suse'`

# if debian based
if [ "$DEBIAN" -ne -1 ]; then
      	INSTALL='apt-get install'
	YES='-y'

# if fedora/redhat/centos based
elif [ "$FEDORA" -ne -1 ] || [ "$ID" == "fedora" ]; then
	INSTALL='yum install'
	YES='-y'

# if suse based
elif [ "$SUSE" -ne -1 ]; then
    INSTALL='zypper install -y'
    YES=''


# otherwise its arch?
else
	INSTALL='brew install'
	#INSTALL='pacman -S'
	#YES='--noconfirm'
fi

# fedora 22 and later uses dnf
if [ "$ID" == "fedora" ]  && [ "$VERSION_ID" -ge "22" ]; then
	INSTALL='dnf install'
	YES='-y'
fi

# install vim
eval "$INSTALL vim $YES"

# install tmux
eval "$INSTALL tmux $YES"

# install git
eval "$INSTALL git $YES"

# htop
eval "$INSTALL htop $YES"

# install i3 and other dependencies
#eval "sudo $INSTALL i3 i3status dmenu i3lock xbacklight feh conky $YES"

# install urxvt
#eval "sudo $INSTALL rxvt-unicode $YES"

# install nmtui
#eval "sudo $INSTALL NetworkManager-tui  $YES"

# install ntpdate (for vm timesyncing)
#eval "sudo $INSTALL ntpdate $YES"

# install cscope
eval "$INSTALL cscope $YES"

# Example for installing Vundle, the Vim dependency manager
git clone https://github.com/ctrlpvim/ctrlp.vim.git  ~/.vim/bundle/ctrlp.vim
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
git clone https://github.com/w0rp/ale.git ~/.vim/bundle/ale
git clone https://github.com/terryma/vim-multiple-cursors.git ~/.vim/bundle/vim-multiple-cursors
git clone https://github.com/junegunn/fzf.git  ~/.fzf
git clone https://github.com/sjl/gundo.vim.git  ~/.vim/bundle/gundo.vim
git clone https://github.com/jeetsukumaran/vim-indentwise.git  ~/.vim/bundle/vim-indentwise
