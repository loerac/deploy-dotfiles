# .bashrc

HISTCONTROL=ignorespace

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export COLOR_NC='\e[0m' # No Color
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_LIGHT_GRAY='\e[0;37m'

# User
PS1="[\[${COLOR_CYAN}\]\u\[${COLOR_NC}\]:\[${COLOR_YELLOW}\]\W\[${COLOR_NC}\]] \[${COLOR_LIGHT_GREEN}\]→\[${COLOR_LIGHT_GRAY}\] "

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# Listing (ls)
alias ll="ls -l"
alias la="ls -A"
alias al="ls -Al"
alias el="exa -l"
alias eg="exa -G"

# Going back one directory
alias bd="cd .."
alias db="cd .."
alias dbd="cd .."

# Exiting
alias x="exit"
alias bye="echo \"bye hot stuff\"; sleep 0.25; exit"

# GNU Compiler
alias gp="g++ -o"
alias gc="gcc -o"

# Remove
alias rmd="rm -rf"

# Yum
alias yum="sudo yum"
alias yummy="sudo yum install"
alias dnffy="sudo dnf install"
alias pippy="sudo pip install"

# Tmux
alias m="tmux"

# Bash Scripts
alias gitclone=". $HOME/bin/./.git_clone.sh"
alias bkup="$HOME/bin/./.bkup.sh"
alias bd_="$HOME/bin/./.bd.sh"

# Matlab
alias matwab="$HOME/Matlab/bin/./matlab"

# Shutdown
alias dieCow="sudo shutdown -h now"
#alias python=python3

# Random
alias who_is_the_man="echo \"You're man\""
alias password_me_please="pwgen 20 1"
