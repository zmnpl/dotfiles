#!/bin/zsh
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
files=('vim' 'zprezto' 'bashrc' 'vimrc')
##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
echo "Moving any existing dotfiles from ~ to $olddir"
for file in $files; do
	mv -f ~/.$file $olddir
	echo "Creating symlink to $file in home directory."
	ln -s $dir/$file ~/.$file
done

############################
# install prezto if not already
############################
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/z*; do
	mv -f "${ZDOTDIR:-$HOME}/.${rcfile:t}" $olddir
	echo "Creating symling to $rcfile in home directory."
	ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
