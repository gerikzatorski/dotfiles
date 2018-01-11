##################################################
# Basics
##################################################

export EDITOR=emacs

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# byobu-prompt
[ -r /home/gerik/.byobu/prompt ] && . /home/gerik/.byobu/prompt

# bind "set completion-ignore-case on"
shopt -s cdspell
shopt -s checkwinsize

# Alias definitions (see /usr/share/doc/bash-doc/examples)
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

##################################################
# Colors
##################################################

export CLICOLOR=1
export TERM="xterm-256color"

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

##################################################
# Misc
##################################################

# ROS
source /opt/ros/kinetic/setup.bash
source ~/catkin_ws/devel/setup.bash

# finds and replaces text within documents
function findreplace() {
    grep -lr -e "$1" * | xargs sed -i "s/$1/$2/g" ;
}

# finds and replaces files by name
function findreplacefilename() {
    find . -depth -name "*$1*" -exec bash -c 'for f; do base=${f##*/}; mv -- "$f" "${f%/*}/${base//'$1'/'$2'}"; done' _ {} +
}

# change into directory after making it
function mcd () {
    mkdir -p $1
    cd $1
}
