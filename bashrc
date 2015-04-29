# variables

# golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export EDITOR=vim

# own scripts path
export PATH=$PATH:~/CloudStation/Linux/scripts

#set prompt
#PS1='`pwd` >'

PS1='[\[\033[1;36m\]\u\[\033[0m\]@\h \W]\$ '

#alias xflock4='light-locker-command -l'
alias xflock4='sxlock'
alias whatsinaur='pacman -Qqm'
alias fotosnap='sudo rsnapshot -v daily'
alias fucking-reboot='sudo shutdown -r now'
alias fuckoff='sudo shutdown -h now'

#pacman aliases
alias kick='sudo pacman -Rns'

#/home/simon/CloudStation/Linux_Setup/scripts/bash_pacman.sh
screenfetch
