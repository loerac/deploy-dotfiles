# Prompt
PS1='[${debian_chroot:+($debian_chroot)}\[\033[01;30m\]\u\[\033[00m\]:\[\033[00;36m\]\W\[\033[00m\]]$ '

# Actual Commands
alias ll="ls -l"
alias la="ls -a"
alias al="ls -al"

# Going back one directory
alias bd="cd .."
alias db="cd .."
alias dbd="cd .."

# Exiting
alias x="exit"
alias bye="echo \"bye bye\"; sleep 0.5; exit"

# GNU Compiler
alias gp="g++ -o"
alias gc="gcc -o"

# Remove
#alias rm="sudo rm"
alias rmd="sudo rm -rf"

# Yum
alias yum="sudo yum"
alias yummy="sudo yum install"
alias pippy="sudo pip install"

# Tmux
alias m="tmux"

# Shutdown
alias dieCow="sudo shutdown -h now"
alias python=python3

# Random
alias whoIsTheMan="echo \"You're man\""
