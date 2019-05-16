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

# exports
mkcd() {
    mkdir -p $1 && cd -P $1
}
cl() {
    cd $1
    if [ 2 -eq $# ]; then
        ls $2
    else
        ls
    fi
}
gitdiff() {
    git diff --color=always | less -r
}
svndiff() {
   svn diff $@ | colordiff | less -R;
}
igrep() {
   [[ "${2}" = "" ]] && dir=. || dir=${2}
   [[ "${3}" = "" ]] && color=always || color=${3}
   [[ "${4}" = "" ]] && exp="-rn" || exp="${4}"
   [[ "${5}" = "" ]] && filter="" || filter="\|${5}"
   grep ${exp} "${1}" ${dir} --color=${color} | grep -v "Binary file\|\.svn\|cscope${filter}"
}
csr() {
   [[ "${1}" == "" ]] && DIR=$PWD || DIR=${1}
   
   #TODO: Maybe add bitwise notation for these three states
   
   # C Files
   find ${DIR}/* -type f \( -name *.c -o -name *.h \) >> ${DIR}/cscope.files

   # SELinux Files
   find ${DIR}/* -type f \( -name '*.te' -o -name '*.if' -o -name '*.fc' \) >> ${DIR}/cscope.files

   # Makefile files                                                                                                                                                                                                                                                              
   find ${DIR}/* -type f \( -name '*.make' -o -name 'Makefile' \) >> ${DIR}/cscope.files
   
   # Build cscope.file
   cscope -b
}
gclone() {
    if [ $# -eq 1 ]; then
        CLONE="${1}"
        DIR_GIT=${CLONE##*/}
        DIR=${DIR_GIT%.git}

        mkdir -p ${DIR}
        if [ $? -eq 0 ]; then
            git clone ${CLONE} ${DIR}
            cd -P ${DIR}
        else
            echo "Making directory ${DIR} failed..."
        fi
    else
        echo "Usage: gclone [Github Repo]"
        echo "Github Repo: https://github.com/[repo]"
    fi
}
val() {
    if [ $# -eq 1 ]; then
        failed=0
        EXECUTABLE=${1}
        FILE_NAME="valgrind_${EXECUTABLE#"./"}.txt"

        # Check if valgrind file already exist
        if [ -f ${FILE_NAME} ]; then

            # Delete pre-existing valgrind file
            echo "Removing existing '${FILE_NAME}'"
            rm ${FILE_NAME}
            if [ ! $? -eq 0 ]; then
                # Removing the file failed. Not allowing
                # to run valgrind since this might
                # require root privalges
                echo "Removing existing '${FILE_NAME}' failed..."
                failed=1
            fi  
        fi  

        # Only run valgrind if removing if no errors occured
        if [ 0 -eq ${failed} ]; then
            valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=${FILE_NAME} ${EXECUTABLE}

            echo
            echo "Result is saved in ${FILE_NAME}"
        fi  
    else
        echo "Usage: val [executable]"                                                                                                                                                                                                                                          
        echo "executable: The executable file that Valgrind will use. (Preferably in this notation './exe')"
    fi  
}

export mkcd
export cl
export gitdiff
export svndiff
export igrep
export csr
export gclone
export val

# Listing (ls)
alias ll="ls -l"
alias la="ls -a"
alias al="ls -al"

# Going back one directory
alias cd="cl"
alias bd="cl .."
alias db="cl .."
alias dbd="cl .."

# Updating
alias yum="sudo pacman"
alias yummy="sudo pacman -Syu"
alias aup="yaourt -Syu --aur"
alias upbashrc="vim ~/.bashrc && source ~/.bashrc"
alias grubup="sudo update-grud"

# Exiting
alias x="exit"
alias bye="echo \"bye hot stuff\"; sleep 0.25; exit"

# GNU Compiler
alias gp="g++ -Wall -Werror -o"
alias gc="gcc -Wall -Werror  -o"

# Remove
alias rmd="rm -rf"

# Tmux
alias m="tmux"

# Bash Scripts
alias bkup="$HOME/bin/./.bkup.sh"

# Shutdown
alias dieCow="sudo shutdown -h now"
#alias python=python3

# Random
alias who_is_the_man="echo \"You're the man\""
alias password_me_please="pwgen 20 1"
alias sl="sl -alFe"
