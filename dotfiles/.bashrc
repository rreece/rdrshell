#!/bin/bash
#-----------------------------------------------------------------------------
# file: .bashrc
# author: Ryan Reece <ryan.reece@cern.ch>
# date : 2010-06-21
#
# how to check out:
#    cd ~/
#    SVNUCSC=svn+ssh://reece@svn.cern.ch/reps/atlasinst/Institutes/UCSC
#    svn co $SVNUCSC/reece/dotfiles/trunk .
#
# -----------------------------------------------------------------------------

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


#-----------------------------------------------------------------------------
# enable color support
#-----------------------------------------------------------------------------
#if [ "$TERM" != "dumb" ]; then
#    eval "`dircolors -b`"
#fi

if [ -f ~/.bash_colors ]; then
    source ~/.bash_colors
fi


#-----------------------------------------------------------------------------
# shell prompt
#-----------------------------------------------------------------------------
#   Need \[X\] so that non-printing characters do not screw up lines when
#   scrolling up through history.
#   See: http://tldp.org/HOWTO/Bash-Prompt-HOWTO/nonprintingchars.html
# export PS1=$' \W \[\033[1;31m\]\xe2\x98\x85\[\033[0m\] '
case "$USER" in 
    root)
#       export PS1="[\[${LIGHTRED}\]\h\[${NC}\]:\[${LIGHTBLUE}\]\W\[${NC}\]]  "
#       export star=$'\[\033[1;31m\]\xe2\x98\x85\[\033[0m\]'
#       export PS1="\[${LIGHTRED}\]\u@\h\[${NC}\]:\[${LIGHTBLUE}\]\W\[${NC}\] $star  "
        export PS1="[\[${LIGHTRED}\]\u${NC}@${LIGHTGREEN}\h\[${NC}\]:\[${LIGHTBLUE}\]\W\[${NC}\]]  "
#        export PS1="\[${LIGHTGREEN}\][\[${LIGHTRED}\]\u\[${LIGHTGREEN}\]@\[${NC}\]\h\[${LIGHTGREEN}\]:\[${LIGHTBLUE}\]\W\[${LIGHTGREEN}\]]\[${NC}\]  "
    ;;
    *)
#       export star=$'\[\033[1;31m\]\xe2\x98\x85\[\033[0m\]'
#       export PS1="\[${LIGHTGREEN}\]\u@\h\[${NC}\]:\[${LIGHTBLUE}\]\W\[${NC}\] $star  "
        export PS1="[\[${LIGHTGREEN}\]\u${NC}@${LIGHTGREEN}\h\[${NC}\]:\[${LIGHTBLUE}\]\W\[${NC}\]]  "
#       export PS1="\[${LIGHTGREEN}\][\[${LIGHTCYAN}\]\u@\h\[${NC}\]:\[${LIGHTBLUE}\]\W\[${LIGHTGREEN}\]]\[${NC}\]  "
    ;;
esac


# X Terminal titles
# - force writing history before each new command
#   http://blog.sanctum.geek.nz/better-bash-history/
case "$TERM" in 
    xterm*|rxvt*)
#        PROMPT_COMMAND='history -a; history -n; echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
        PROMPT_COMMAND='history -a; history -n'
    ;;
    *)
        true
    ;;
esac


#-----------------------------------------------------------------------------
# count bashrc calls (for debugging purposes)
#-----------------------------------------------------------------------------
if [ "$MY_BASHRC_CALLS" ]; then
#    echo "MY_BASHRC_CALLS is defined"
    export MY_BASHRC_CALLS=$(( MY_BASHRC_CALLS + 1 ))
else
#    echo "MY_BASHRC_CALLS is not defined"
    export MY_BASHRC_CALLS=1
fi


#-----------------------------------------------------------------------------
# source other environment setup files
#-----------------------------------------------------------------------------

# initial settings
[ -f ~/.bash_init ] && source ~/.bash_init

# alias definitions
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# environment definitions (setup depending on the host, $ME)
[ -f ~/.bash_env ] && source ~/.bash_env


#-----------------------------------------------------------------------------
# source other environment setup files in plugins/
#-----------------------------------------------------------------------------

#!/bin/bash
BASH_FILES=$HOME/.rdrshell_init/*
for f in $BASH_FILES
do
    # take action on each file.
    # echo "Processing $f file..."
    source $f
done


#-----------------------------------------------------------------------------
# clean up PATHs (removing duplicates)
#-----------------------------------------------------------------------------
remove_dups_path()
{
    echo $1 | awk -F: '{for (i=1;i<=NF;i++) { if ( !x[$i]++ ) printf("%s:",$i); }}'
}

export PATH=`remove_dups_path $PATH`
export LD_LIBRARY_PATH=`remove_dups_path $LD_LIBRARY_PATH`
export PYTHONPATH=`remove_dups_path $PYTHONPATH`


# EOF
