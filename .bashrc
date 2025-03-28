# .bashrc

HISTCONTROL=$HISTCONTROL:ignorespace

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
#PS1="\[${COLOR_NC}\][\[${COLOR_CYAN}\]\u\[${COLOR_NC}\]:\[${COLOR_YELLOW}\]\W\[${COLOR_NC}\]] \[${COLOR_LIGHT_GREEN}\]→\[${COLOR_LIGHT_GRAY}\] "
PS1="\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ "

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# exports
mkcd() {
    mkdir -p $1 && cd -P $1
}
mvcd() {
    DIR="${@: -1}"
    ARGC=$#
    ARGC=$((ARGC - 1))
    ARGV=($@)

    for (( i=0; i<ARGC; i++)); do
        mv ${ARGV[i]} ${DIR}
    done
    cd ${DIR} && ls
}
cpcd() {
    cp ${1} ${2} && cd ${2} && ls
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
   find ${DIR}/* -type f \( -name '*.c' -o -name '*.h' \) > ${DIR}/cscope.files

   # C++ Files
   find ${DIR}/* -type f \( -name '*.c++' -o -name '*.h++' \) >> ${DIR}/cscope.files
   find ${DIR}/* -type f \( -name '*.cpp' -o -name '*.hpp' \) >> ${DIR}/cscope.files

   # Go Files
   find ${DIR}/* -type f -name '*.go' >> ${DIR}/cscope.files

   # SELinux Files
   find ${DIR}/* -type f \( -name '*.te' -o -name '*.if' -o -name '*.fc' \) >> ${DIR}/cscope.files

   # Makefile files
   find ${DIR}/* -type f \( -name '*.make' -o -name 'Makefile' \) >> ${DIR}/cscope.files

   # Build cscope.file
   cscope -b
}
gclone() {
    if [ ${#} -ge 1 ]; then
        CLONE="${1}"
        DIR_GIT=${CLONE##*/}
        [[ ${#} -eq 2 ]] && DIR=${2} || DIR=${DIR_GIT%.git}

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
        FILENAME=$(basename -- "${EXECUTABLE}")
        EXTENSION="${FILENAME##*.}"
        FILE_NAME="valgrind_${FILENAME%.*}.txt"

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

        # Only run valgrind if no errors occured
        if [ 0 -eq ${failed} ]; then
            valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=${FILE_NAME} ${EXECUTABLE}

            echo
            echo "Result is saved in ${FILE_NAME}"
        fi
    else
        echo "Usage: val [executable]"
        echo "executable: The executable file that Valgrind will use. (Preferably in this notation './exe' or it will not work)"
    fi
}
bd() {
    cd_num=1

    # Passing an integer with 'bd' will act as how
    # many times to go back a directory
    if [ ! -z ${1} ]; then
        cd_num=${1}

        # Check if value given is not valid
        regex='^[1-9]+$'
        if ! [[ ${cd_num} =~ ${regex} ]]; then
            echo "Invalid value ${1}"
            cd_num=1
        fi
    fi
    back="../"
    back_total=""
    for (( i=0; i<cd_num; i++ )); do
        back_total=${back_total}${back}
    done

    cd ${back_total} && ls
}

# Set up a working directory to navigate to
set-my-wkdir() {
	[[ $# -eq 0 ]] && SET_HOME=${PWD} || SET_HOME=${1}
	export TMHOME=${SET_HOME}
}
take-me-wkdir() {
	cd ${TMHOME} && ls ${1}
}

#export mkcd
#export mvcd
#export cl
#export gitdiff
#export svndiff
#export igrep
#export csr
#export gclone
#export val
#export bd

# Listing (ls)
alias ll="ls -l"
alias la="ls -A"
alias al="ls -Al"
alias lh="ls -lh"

# Going back one directory
alias cd="cl"
alias db="cl .."
alias dbd="cl .."

# Updating
alias yum="sudo apt"
alias yummy="sudo apt install"

# Manjaro
#alias aup="yaourt -Syu --aur"
#alias grubup="sudo update-grud"

alias upbashrc="vim ~/.bashrc && source ~/.bashrc"

# Exiting
alias x="exit"
alias bye="echo \"bye hot stuff\"; sleep 0.25; exit"

# GNU Compiler
alias gp="g++ -Wall -Werror -o"
alias gc="gcc -Wall -Werror -fstack-protector -o"

# Remove
alias rmd="rm -rf"

# Tmux
alias m="tmux"

# Shutdown
alias dieCow="sudo shutdown -h now"
#alias python=python3

# Random
alias who_is_the_man="echo \"You're the man\""
alias password_me_please="pwgen 20 1"
alias sl="sl -alFe"
alias please="sudo"

# Fuzzy Finder
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#alias fzfp="fzf --preview='head -$LINES {}'"

