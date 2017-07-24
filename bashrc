# ROS
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
source ~/.rvm/scripts/rvm
source /opt/ros/indigo/setup.bash
source ~/catkin_ws/devel/setup.bash

# Mechatronics Class
export PATH="$PATH:"/opt/microchip/xc32/v1.42/bin""

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Rllab
export PYTHONPATH="/home/gerik/git/rllab:$PYTHONPATH"

# added by Anaconda2 4.3.1 installer
export PATH="/home/gerik/anaconda2/bin:$PATH"


# add python -c "import sys; print('\n'.join(x for x in sys.path if x))"

function findreplace() {
    grep -lr -e "$1" * | xargs sed -i "s/$1/$2/g" ;
}

function findreplacefilename() {
    find . -depth -name "*$1*" -exec bash -c 'for f; do base=${f##*/}; mv -- "$f" "${f%/*}/${base//'$1'/'$2'}"; done' _ {} +
}