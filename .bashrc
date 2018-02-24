# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Additions from deploy-dotfiles
alias timesync='ntpdate -b pool.ntp.org'
(timesync& )  > /dev/null
