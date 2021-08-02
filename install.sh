#!/usr/bin/zsh

echo "Are you sure? This will overwrite existing dotfiles... y/n"
REPLY=''
vared REPLY
#read -p "Are you sure? This will overwrite existing dotfiles... y/n" -n 1 -r
#echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

# fish
echo "########## fish"
rm -rfv ~/.config/fish
ln -sf ~/dotfiles/fish ~/.config/fish

# vim
echo "########## vim"
rm -rfv ~/.vim
ln -sf ~/dotfiles/vim ~/.vim
ln -sf ~/dotfiles/vimrc ~/.vimrc
# neovim
echo "########## nvim"
rm -rfv ~/.config/nvim
ln -sf ~/dotfiles/vim ~/.config/nvim
ln -sf ~/dotfiles/vimrc ~/.config/nvim/init.vim

# feh
echo "########## feh"
rm -rfv ~/.config/feh
ln -sf ~/dotfiles/feh ~/.config/feh

# dunst
echo "########## dunst"
rm -rf ~/.config/dunst
ln -sf ~/dotfiles/dunst ~/.config/dunst
killall dunst
dunst &

# i3
echo "########## i3"
# create fresh config dir
rm -rfv ~/.config/i3
mkdir ~/.config/i3
# link basic config
ln -sf ~/dotfiles/i3/config.base ~/.config/i3/config.base
# i3blocks is host specific
if [ "$HOST" = Mordor-Mobil ]; then
    ln -sf ~/dotfiles/i3/i3blocks_laptop.conf ~/.config/i3/i3blocks.conf
else
    ln -sf ~/dotfiles/i3/i3blocks_pc.conf ~/.config/i3/i3blocks.conf
fi
#ln -sf ~/dotfiles/i3/themes ~/..config/i3/themes
#ln -sf ~/dotfiles/i3/config ~/.config/i3/config
j4-make-config

# Xresources
#echo "########## Xresources"
#rm -rfv ~/.Xresources
#ln -sf ~/dotfiles/Xresources ~/.Xresources

# Xprofile
echo "########## Xprofile"
rm -rfv ~/.xprofile
ln -sf ~/dotfiles/xprofile ~/.xprofile

# sorin zprezto
echo "########## zprezto"
if [ -e ~/.zprezto ]
then
    cd ~/.zprezto
	git branch --set-upstream-to=origin/master
	git pull
	git submodule update --init --recursive
   # git submodule foreach --recursive git pull origin master
else
    git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
fi

# my zsh rc files in addition to prezto
#setopt EXTENDED_GLOB
#for rcfile in ~/dotfiles/zprezto/runcoms/^README.md; do
#  echo $rcfile
#  ln -sf "$rcfile" "~/dotfiles/zprezto/runcoms/.${rcfile:t}"
#done
setopt EXTENDED_GLOB
for rcfile in ~/dotfiles/zprezto/runcoms/^README.md(.N); do
  echo $rcfile
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
