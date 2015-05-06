#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles

# found at: http://blog.smalleycreative.com/

# adjustments by
# smnpl - simon paul

############################

# linking of dotfiles
# Variables
dir=~/dotfiles # dotfiles directory
olddir=~/dotfiles/backup # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="
vim
zprezto
bashrc
vimrc"
##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

############################
# install prezto if not already
############################
# todo - find out, why loop is not working
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
# workaround for loop
#ln -s ~/.zprezto/runcoms/zlogin ~/.zlogin
#ln -s ~/.zprezto/runcoms/zlogout ~/.zlogout
#ln -s ~/.zprezto/runcoms/zpreztorc ~/.zpreztorc
#ln -s ~/.zprezto/runcoms/zprofile ~/.zprofile
#ln -s ~/.zprezto/runcoms/zshenv ~/.zshenv
#ln -s ~/.zprezto/runcoms/zshrc ~/.zshrc
