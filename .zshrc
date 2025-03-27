# Path to your oh-my-zsh installation.
export ZSH="/Users/ChristianLoera/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="kphoen"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git zsh-syntax-highlighting zsh-autocomplete)
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

mkcd () {
   if [[ -z "$1" ]] ; then
      echo "Usage: mkcd <directory_name>"
      return 1
   fi

   mkdir -p "$1" && cd "$1"
}

src_to_dest () {
   OPERATION=$1
   shift

   if [[ $# -lt 2 ]]; then
      echo "Usage: ${OPERATION}cd <src_1> <src_2> ... <dir>"
      return 1
   fi

   DESTINATION="${@: -1}"
   SOURCES=("${@:1:$#-1}")

   if [[ ! -d "$DESTINATION" ]]; then
      echo "Error: Destination must be a directory"
      return 1
   fi

   $OPERATION "${SOURCES[@]}" "${DESTINATION}"
   cd ${DESTINATION} && ls
}
mvcd () {
   src_to_dest mv "$@"
}
cpcd () {
   src_to_dest cp "$@"
}

gclone () {
   if [ ${#} -ge 1 ]; then
      CLONE="${1}"
      DIR_GIT=${CLONE##*/}
      [[ ${#} -eq 2 ]] && DIR=${2} || DIR=${DIR_GIT%.git}

      mkdir -p ${DIR}
      if [ $? -eq 0 ]; then
	 git clone ${CLONE} ${DIR}
	 cd -P ${DIR} && echo && ls
      else
	 echo "Making directory ${DIR} failed"
      fi
   else
      echo "Usage: gclone [Github Repo]"
      echo "Github Repo: https://github.com/[repo]"
   fi
}
co () {
   BRANCH=$(git branch | fzf-tmux)
   [[ -n ${BRANCH} ]] && git checkout ${BRANCH##*( )}
}
gbranch () {
   git branch | fzf
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

   # Python Files
   find ${DIR}/* -type f -name '*.py' >> ${DIR}/cscope.files

   # Makefile files
   find ${DIR}/* -type f \( -name '*.make' -o -name 'Makefile' \) >> ${DIR}/cscope.files

   # Build cscope.file
   cscope -b
}
igrep () {
   [[ "${2}" = "" ]] && dir=. || dir=${2}
   [[ "${3}" = "" ]] && exp="-rn" || exp="${3}"
   [[ "${4}" = "" ]] && color=always || color=${4}
   [[ "${5}" = "" ]] && filter="" || filter="\|${5}"
   grep ${exp} "${1}" ${dir} --color=${color} | grep -v "\.git\|\.svn\|cscope\|.pytest_cache\|__pycache__\|.pyc\|.ipynb${filter}"
}
ch () {
   [[ "${1}" = "" ]] && DIR=${HOME} || DIR=${1}
   cd ${DIR} && ls
}
old_bd () {
   cd_num=1

   if [ ! -z ${1} ]; then
      cd_num=${1}

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
bd () {
   CD_NUM=1
   if [ ! -z ${1} ]; then
      CD_NUM=$1
      if [[ -z "${CD_NUM}" || ! "${CD_NUM}" =~ ^[0-9]+$ ]]; then
	 echo "Usage: bd <number of dirs>"
	 return 1
      fi
   fi

   bd_cmd=""
   for ((i=0; i<${CD_NUM}; i++)); do
      bd_cmd="${bd_cmd}""../"
   done

   cd "${bd_cmd}" && ls
}
fftp () {
   fzf-tmux --preview="bat --color=always {}"
}
vif () {
   VFILE=$(fzf --preview='bat --color=always {}')
   [[ -n ${VFILE} ]] && echo "${VFILE}" && vim "${VFILE}"
}
set-my-wkdir () {
   [[ $# -eq 0 ]] && SET_HOME=${PWD} || SET_HOME=${1}
   export TMHOME=${SET_HOME}
}
take-me-wkdir () {
cd ${TMHOME} && ls
}
del_orig_files () {
   find . -name '*.orig' -delete 
}

# List (ls)
alias ll="ls -l"
alias la="ls -A"
alias al="ls -Al"
alias lh="ls -lh"

# Git
alias giff="git diff"
alias full="git fetch && git pull"
alias chrunk="git checkout trunk"
alias chrev="git checkout -"

# Vim binding
set -o vi

# Tmux Window
alias TMUX_THREE="tmux new-session -s three_window_sessions -n main \; split-window -h \; split-window -v"

# fd
alias rf="fd --type f --hidden --exclude .git | fzf-tmux --preview='bat --color=always {}' | xargs -o vim"
alias uzf="fd -e zip -x unzip"
change_ext () {
   if [[ $# -lt 2 ]]; then
      echo "Usage: change_ext <orig> <mod>"
      return 1
   fi

   ORIG_EXT="${1}"
   MOD_EXT="${2}"
   fd -e ${ORIG_EXT} -x convert {} {.}.${MOD_EXT}
}
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi"

my_ip () {
    dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com | tr -d '"'
}
json_clip_pp() {
    pbpaste | sed "s/'/\"/g" | json_pp
}

# Fuzzy Finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init --cmd cd zsh)"
z() {
   command z "$@" && ls
}
