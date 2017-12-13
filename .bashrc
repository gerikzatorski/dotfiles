# Ruby Version Manager for MSR portfolio template
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
source ~/.rvm/scripts/rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# ROS
source /opt/ros/indigo/setup.bash
source ~/catkin_ws/devel/setup.bash

# Mechatronics Class
export PATH="$PATH:"/opt/microchip/xc32/v1.42/bin""

# Rllab
# export PYTHONPATH="/home/gerik/git/rllab:$PYTHONPATH"

##################################################
# Aliases
##################################################

## Colorize the ls output ##
alias ls='ls --color=auto'
 
## Use a long listing format ##
alias ll='ls -la'

## Show hidden files ##
alias l.='ls -d .* --color=auto'

## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'
 
# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# distro specific  - Debian / Ubuntu and friends #
# install with apt-get
alias apt-get="sudo apt-get"
alias updatey="sudo apt-get --yes"
 
# update on one command
alias update='sudo apt-get update && sudo apt-get upgrade'

# reboot / halt / poweroff
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'

## Choose Python Version ##
alias python=python2

# system commands *
alias hibernate='sudo systemctl hibernate'


##################################################
# Functions
##################################################

# finds and replaces text within documents
function findreplace() {
    grep -lr -e "$1" * | xargs sed -i "s/$1/$2/g" ;
}

# finds and replaces files by name
function findreplacefilename() {
    find . -depth -name "*$1*" -exec bash -c 'for f; do base=${f##*/}; mv -- "$f" "${f%/*}/${base//'$1'/'$2'}"; done' _ {} +
}

# change into directory after making it
mcd () {
    mkdir -p $1
    cd $1
}


# function Extract for common file formats
# https://github.com/xvoland/Extract/blob/master/extract.sh
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}