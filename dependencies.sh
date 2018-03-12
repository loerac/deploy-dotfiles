
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

# if debian based
if [ "$DEBIAN" -ne -1 ]; then
      	INSTALL='apt-get install'
	YES='-y'

# if fedora based
elif [ "$FEDORA" -ne -1 ] || [ "$ID" == "fedora" ]; then 
	INSTALL='yum install'
	YES='-y'

# otherwise it's arch?
else 
	INSTALL='pacman -S' 
	YES='--noconfirm'
fi

# fedora 22 and later uses dnf
if [ "$ID" == "fedora" ]  && [ "$VERSION_ID" -ge "22" ]; then
	INSTALL='dnf install'
	YES='-y'
fi	

# install vim
eval "sudo $INSTALL vim $YES"

# install tmux
eval "sudo $INSTALL tmux $YES"

# install git
eval "sudo $INSTALL git $YES"

# instll ntpdate (for vm timesyncing)
#eval "sudo $INSTALL ntpdate $YES"

# Example for installing Vundle, the Vim dependency manager
git clone https://github.com/ctrlpvim/ctrlp.vim.git  ~/.vim/bundle/ctrlp.vim

