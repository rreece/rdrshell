#!/bin/bash
#-----------------------------------------------------------------------------
# file: .bash_aliases
# author: Ryan Reece <ryan.reece@cern.ch>
# date : 2010-06-21
# -----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# basics
#-----------------------------------------------------------------------------
## file moving/removal
alias mv="mv -i"
alias mc="mv -i"
#alias cp="cp -i"
alias rm="rm -i"
#alias rm="\mv -f --target-directory=$HOME/.Trash/"
alias empty_trash="\rm -rfv $HOME/.Trash/*"
alias del="\rm -rf"
alias pur="\rm -v *~"
alias purge='find . -name "*~" -print -exec \rm -f {} \;'
alias cp_existing="rsync -ahC --existing -I -i "
alias cp_rsync="rsync -ahC -i "

## ls
alias l="\ls -CFG"
alias ls="\ls -CFG"
alias lsd="\ls -CGd */"
alias ld="\ls -CGd */"
alias ll="\ls -GlhF"
alias la="\ls -GAF"
alias lt="\ls -GlhtFr"
alias l1="\ls -G1F"
alias lm="\ls -GAlhtFr | tail"
latest() { \ls -ct1 $* | head -1 ; }

## dir navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias back="cd -"

## apt
alias -- -search="apt-cache search"
alias -- -show="apt-cache show"
alias -- -install="sudo apt-get install"
alias -- -remove="sudo apt-get remove"
alias -- -update="sudo apt-get update"
alias -- -upgrade="sudo apt-get upgrade"
alias -- -source="dpkg -S"
alias -- -list="dpkg -l"
alias -- -files="dpkg -L"

## vi
alias v="vim"
alias vi="vim"
#alias e="vim"
#alias :e="vim"
alias vsp="vim -O"
alias svi="sudo vim"
alias sv="sudo vim"
alias vl="vim `latest`"

## emacs
alias e="emacs -nw"

## svn
alias svn_status='svn status --show-updates | grep "^[^?]"'
alias svns='svn status | grep "^[^?]"'
alias rm_svn_dirs="find . -type d -name .svn -exec rm -rf {} \;"
svn-tag()
{
    # svn cp svn+ssh://reece@svn.cern.ch/reps/atlasphys-susy/Physics/SUSY/Analyses/Diphoton/NonPointingDiphoton2016/trunk svn+ssh://reece@svn.cern.ch/reps/atlasphys-susy/Physics/SUSY/Analyses/Diphoton/NonPointingDiphoton2016/tags/NonPointingDiphoton2016-00-00-09 -m "Tagging: NonPointingDiphoton2016-00-00-09"
    # svn-tag svn+ssh://reece@svn.cern.ch/reps/atlasphys-susy/Physics/SUSY/Analyses/Diphoton/NonPointingDiphoton2016 NonPointingDiphoton2016-00-00-09
    svn cp $1/trunk $1/tags/$2 -m "Tagging: $2"
}

## git helper aliases
alias git-st="git status"
alias git-ci="git commit -a -m " # must give comment: git-ci "put comment here"
alias git-push="git push -u origin master"
alias git-pull="git pull"
alias git-add="git add"
alias git-last="git log -1 HEAD"
alias rm_git_dirs="find . -type d -name .git -exec rm -rf {} \;"
git-tag()
{
    # git tag -a v1.4 -m 'my version 1.4'
    git tag -a $1 -m 'tagging version $1'
    git push origin --tags
}

## python
alias py="python"
alias ipy="ipython"

## root
alias root="root -l"
alias pyroot="python -i -c \"from ROOT import *; import rootlogon;\""
alias pyrootb="python -i -c \"from ROOT import *; import rootlogon; b = TBrowser()\""

## screen
alias sc="screen"
alias scls="screen -ls"
alias scr="screen -r"
alias dupscreen='screen bash -c "cd \"$PWD\" && exec \"$SHELL\" --login"'
alias scd="dupscreen"

## misc shorts
alias f="find . -name "
alias h="history | grep "
alias p="ps aux | grep "
alias o="gnome-open "
alias t="tail"
alias tf="tail -f "
alias pc='python -ic "from __future__ import division; from math import *"'

## misc
alias clear="echo ''; echo ''; echo '________________________________________________________________________________'; clear"
#alias duh="du -k * | sort -rn | cut -f2 | xargs -d '\n' du -chs"
alias duh="du -hs */"
alias dud="du -k */ | sort -rn | cut -f2 | xargs -d '\n' du -chs"
alias grep="grep --color=auto"
alias less="less -I -R "
alias more="less"
alias newalias="vi ~/.bash_aliases"
alias stopssh="sudo /etc/init.d/ssh stop"


#-----------------------------------------------------------------------------
# working with strings and paths
#-----------------------------------------------------------------------------
lowercase()
{
    echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

split_base()
{
    filename=$(basename "$1")
    extension="${filename##*.}"
    filename="${filename%.*}"
    echo $filename
}

split_ext()
{
    filename=$(basename "$1")
    extension="${filename##*.}"
    filename="${filename%.*}"
    echo $extension
}

add_pwd_to_PYTHONPATH()
{
    export PYTHONPATH=$PWD:$PYTHONPATH
}

add_pwd_to_PATH()
{
    export PATH=$PWD:$PATH
}

## doesn't work on mac
abs_pwd()
{
    echo `readlink -f $PWD`
}

## another way:
abs_pwd2()
{
    echo $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
}

## python way, robust
real_path()
{
    if [ -n "$1" ]; then
        p="$1"
    else
        p=`pwd`
    fi
    python -c "import os, sys; print os.path.realpath('${p}')"
}

scp_path()
{
    echo "${USER}@${HOSTNAME}:`real_path`" 
}


#-----------------------------------------------------------------------------
# working with files
#-----------------------------------------------------------------------------
#dirsize - finds directory sizes and lists them for the current directory
dirsize()
{
    du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
    egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
    egrep '^ *[0-9.]*M' /tmp/list
    egrep '^ *[0-9.]*G' /tmp/list
    \rm -rf /tmp/list
}

disksize()
{
    df -h
}

grab()
{
    sudo chown -R ${USER} ${1:-.}
}

alias give="chmod -R a+r"

# Find a file with a pattern in name:
ff() { find . -type f -iname '*'$*'*' -ls ; }

# Find a pattern in a set of files and highlight them:
# (needs a recent version of egrep)
fstr()
{
    OPTIND=1
    local case=""
    local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
        i) case="-i " ;;
        *) echo "$usage"; return;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    find . -type f -name "${2:-*}" -print0 | \
    xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more 

}

# Swap 2 filenames around, if they exist
swap()  
{
    local TMPFILE=tmp.$$ 

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE 
    mv "$2" "$1"
    mv $TMPFILE "$2"
}


#-----------------------------------------------------------------------------
# compression
#-----------------------------------------------------------------------------
tgz()
{
    for f in "$@"
    do
        tar -cvzf $f.tgz $f
    done
}

tbz()
{   
    for f in "$@"
    do
        tar -cvjf $f.tbz $f
    done
}

extract()
{
    for f in "$@"
    do
        if [ -f $f ] ; then
            case $f in
                *.tar.bz2)  tar xjf $f      ;;
                *.tar.gz)   tar xzf $f      ;;
                *.bz2)      bunzip2 $f      ;;
                *.rar)      rar x $f        ;;
                *.gz)       gunzip $f       ;;
                *.tar)      tar xf $f       ;;
                *.tbz)      tar xjf $f      ;;
                *.tbz2)     tar xjf $f      ;;
                *.tgz)      tar xzf $f      ;;
                *.zip)      unzip $f        ;;
                *.Z)        uncompress $f   ;;
                *)          echo "'$f' cannot be extracted via extract()" ;;
            esac
        else
            echo "'$f' is not a valid file"
        fi
    done
}


#-----------------------------------------------------------------------------
## ssh keys
#-----------------------------------------------------------------------------
ssh_key_create()
{
    ssh-keygen -t rsa
}
ssh_key_send()
{
    # equiv to: ssh-copy-id <username>@<host>
    cat ~/.ssh/id_rsa.pub | ssh $1 'cat >> .ssh/authorized_keys'
}


#-----------------------------------------------------------------------------
# working with images
#-----------------------------------------------------------------------------
pdftoepsall()
{
    for f in "$@"
    do
        pdftops -eps $f
    done
}

epstopdfall()
{
    for f in "$@"
    do
        epstopdf $f
    done
}

epstopngall()
{
    for f in "$@"
    do
        width=500
        depth=8
        filename=$(basename $f)
        extension="${filename##*.}"
        leftside="${filename%.*}"
        echo ${leftside}.png
        convert -density ${width} $f -resize ${width} -antialias -depth ${depth} -flatten ${leftside}.png
    done
}

alias apdftops="acroread -toPostScript "
alias screenshot='import -window root ~/Desktop/`date +%Y%m%d%H%M`.png'


#-----------------------------------------------------------------------------
# working with text
#-----------------------------------------------------------------------------

# http://daringfireball.net/projects/markdown/
md2html()
{
    for f in "$@"
    do
        filename=$(basename "$f")
        extension="${filename##*.}"
        filename="${f%.*}"
        echo ${filename}.html
        pandoc ${f} -o ${filename}.html --ascii
    done
}

make_latex()
{
    for f in "$@"
    do
        name=`echo $f | sed 's/\(.*\)\..*/\1/'`
        latex $name.tex
        dvips -o $name.ps $name.dvi
        ps2pdf -sPAPERSIZE=a4 $name.ps $name.pdf
        rm -f $name.aux $name.dvi $name.log $name.ps
    done
}


#-----------------------------------------------------------------------------
# working with the command line
#-----------------------------------------------------------------------------
run()
{
    timestamp=`date +%Y-%m-%d.%Hh%M`
    log=""
    if [ "$#" -eq 1 ]; then
        log=$1.$timestamp.log
    else
        log=$1_$2.$timestamp.log
    fi
    echo "user: ${USER}" >> $log
    echo "host: ${HOSTNAME}" >> $log
    echo "date: $(date)" >> $log
    echo "cmd:  $*" >> $log
    echo "________________________________________________________________________________" >> $log
    echo -e "cmd: $LIGHTCYAN$*$NC"
    $* >> $log 2>&1 &
    echo "Running job in the background with log: $log"
}

runt()
{
    run $*
    log=`\ls -tr1 *.log | tail -n 1`
    sleep 1
    echo "Currently tailing log file: $log"
    echo "________________________________________________________________________________"
    tail -f $log
}

for_do()
{
    cmd="$1"
    shift 1
    for x in $*
    do
        echo "-----------------------------------------------------------";
        echo "$cmd $x";
        $cmd $x;
    done
}

run_in()
{
    cwd=`pwd`
    cmd="$1"
    shift 1
    for d in $*
    do
        if [ -d "$d" ]; then
            echo "--------------------- $d ---------------------";
            echo "$cmd";
            cd "$d";
            $cmd;  
            cd $cwd;
        fi
    done
}


#-----------------------------------------------------------------------------
# process info
#-----------------------------------------------------------------------------
alias psi="ps h -eo pcpu,pmem,pid,comm,user,cputime | sort -nr | head"
alias psm="ps h -eo pmem,pcpu,pid,comm,user,cputime | sort -nr | head"
alias pstree="ps -e -o pid,args --forest"

psgrep()
{
    if [ -n $1 ] ; then
        echo "Grepping for processes matching $1..."
        ps aux | grep $1 | grep -v grep
    else
        echo "!! Need name to grep for"
    fi
}

ncpu()
{
    cat /proc/cpuinfo | grep processor | wc | awk '{split($0,a," "); print a[1]}'
}
alias cpu_count='python -c "import multiprocessing as mp; print mp.cpu_count()"'

myps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
pp() { myps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

# Kill by process name.
killps()
{
    local pid pname sig="-TERM"   # Default signal.
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: killps [-SIGNAL] pattern"
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(myps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} ) ; do
        pname=$(myps | awk '$1~var { print $5 }' var=$pid )
        if ask "Kill process $pid <$pname> with signal $sig?"
            then kill $sig $pid
        fi
    done
}

kill-my()
{
    for a in ${@}
    do
        killall -KILL -v -w -u $USER $a
    done
}


#-----------------------------------------------------------------------------
# network info
#-----------------------------------------------------------------------------
net_info()
{
    echo "--------------- Network Information ---------------"
    /sbin/ifconfig | awk /'inet addr/ {print $2}'
    /sbin/ifconfig | awk /'Bcast/ {print $3}'
    /sbin/ifconfig | awk /'inet addr/ {print $4}'
    /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
    myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
    echo "${myip}"
    echo "---------------------------------------------------"
}
alias neti="net_info"

get_ip_addr()
{
    /sbin/ifconfig | grep -w inet |grep -v 127.0.0.1| awk '{print $2}' | cut -d ":" -f 2
}

get_hw_addr()
{
    /sbin/ifconfig | grep HWaddr | awk '{ print $5 }'
}

alias ports='netstat -tulanp'

# get current host related info
sys_info()
{
    echo -e "\n${LIGHTCYAN}system arch:${NC} " ; uname -a
    echo -e "\n${LIGHTCYAN}uptime stats:${NC} " ; uptime
    echo -e "\n${LIGHTCYAN}storage stats:${NC} " ; \df -h | grep -v varrun | grep -v varlock | grep -v udev | grep -v devshm
    echo -e "\n${LIGHTCYAN}memory stats:${NC} " ; free -m
#    echo -e "\n${LIGHTCYAN}local IP address:${NC}" ; my_ip
#    echo -e "\n${LIGHTCYAN}ISP address:${NC}" ; wget www.whatismyip.com/automation/n09230945.asp -O - -q
    echo ""
}
alias sysi="sys_info"


#-----------------------------------------------------------------------------
# misc utilities
#-----------------------------------------------------------------------------
xtitle()
{
    case $TERM in
        *term | rxvt)
            echo -n -e "\033]0;$*\007" ;;
        *)  ;;
    esac
}

clock() 
{ 
    while true;do clear;echo "===========";date +"%r";echo "===========";sleep 1;done 
}

define()
{
    lynx -dump "http://www.google.com/search?hl=en&q=define%3A+${1}&btnG=Google+Search" | grep -m 3 -w "*"  | sed 's/;/ -/g' | cut -d- -f1 > /tmp/templookup.txt
    if [[ -s  /tmp/templookup.txt ]] ; then
        until ! read response
        do
            echo "${response}"
        done < /tmp/templookup.txt
    else
        echo "Sorry $USER, I can't find the term \"${1} \""             
    fi  
    \rm -f /tmp/templookup.txt
}
alias def="define"

wiki()
{
    lynx -dump "http://en.wikipedia.org/wiki/${*}" | less
}

#Translate a Word  - USAGE: translate house spanish  # See dictionary.com for available languages (there are many).
#translate()
#{
#    TRANSLATED=`lynx -dump "http://dictionary.reference.com/browse/${1}" | grep -i -m 1 -w "${2}:" | sed 's/^[ \t]*//;s/[ \t]*$//'`
#    if [[ ${#TRANSLATED} != 0 ]] ;then
#        echo "\"${1}\" in ${TRANSLATED}"
#    else
#        echo "Sorry, I can not translate \"${1}\" to ${2}"
#    fi
#}

# Weather by us zip code - Can be called two ways # weather 50315 # weather "Des Moines"
weather()
{
    declare -a WEATHERARRAY
    WEATHERARRAY=( `lynx -dump "http://www.google.com/search?hl=en&lr=&client=firefox-a&rls=org.mozilla%3Aen-US%3Aofficial&q=weather+${1}&btnG=Search" | grep -A 5 -m 1 "Weather for"`)
    echo ${WEATHERARRAY[@]}
}

# Stock prices - can be called two ways. # stock novl  (this shows stock pricing)  #stock "novell"  (this way shows stock symbol for novell)
stock()
{
    stockname=`lynx -dump http://finance.yahoo.com/q?s=${1} | grep -i ":${1})" | sed -e 's/Delayed.*$//'`
    stockadvise="${stockname} - delayed quote."
    declare -a STOCKINFO
    STOCKINFO=(` lynx -dump http://finance.yahoo.com/q?s=${1} | egrep -i "Last Trade:|Change:|52wk Range:"`)
    stockdata=`echo ${STOCKINFO[@]}`
    if [[ ${#stockname} != 0 ]] ;then
        echo "${stockadvise}"
        echo "${stockdata}"
    else
        stockname2=${1}
        lookupsymbol=`lynx -dump -nolist http://finance.yahoo.com/lookup?s="${1}" | grep -A 1 -m 1 "Portfolio" | grep -v "Portfolio" | sed 's/\(.*\)Add/\1 /'`
        if [[ ${#lookupsymbol} != 0 ]] ;then
            echo "${lookupsymbol}"
        else
            echo "Sorry $USER, I can not find ${1}."
        fi
    fi
}

alarm()
{
    sleeptime="8h"
    songpath="/data/music_library/M83/Hurry\ Up\,\ We\'re\ Dreaming/09\ This\ Bright\ Flash.mp3"
    if [ -n "$1" ] ; then
        sleeptime="$1"
    fi
    if [ -n "$2" ] ; then
        songpath="$2"
    fi
    sleep ${sleeptime} && audacious ${songpath}
}

# EOF
