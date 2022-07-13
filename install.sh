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

# kitty
echo "########## kitty"
rm -fv ~/.config/kitty/kitty.conf
mkdir ~/.config/kitty
ln -sf ~/dotfiles/kitty.conf ~/.config/kitty/kitty.conf
git clone https://github.com/dexpota/kitty-themes.git ~/.config/kitty/kitty-themes
cd ~/.config/kitty/themes
git pull
cd ~/dotfiles


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
	# update personal fork
    cd ~/.zprezto
	git branch --set-upstream-to=origin/master
	git pull
	git submodule sync --recursive
	git submodule update --init --recursive

	# upstream
	git remote add upstream https://github.com/sorin-ionescu/prezto.git
	git pull upstream master
	cd
else
	git clone --recursive https://github.com/zmnpl/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

setopt EXTENDED_GLOB
#for rcfile in ~/dotfiles/zprezto/runcoms/^README.md(.N); do
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
