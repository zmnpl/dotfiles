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
# vim pathogen
echo "########## pathogen"
mkdir ~/dotfiles/vim/bundle
mkdir ~/dotfiles/vim/autoload
# download pathogen to temp file ~, activate o
rm -v "~/dotfiles/vim/autoload/pathogen.vim"
wget -O ~/dotfiles/vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
# vim plug
curl -fLo ~/dotfiles/vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# vim plugins
echo "########## neocomplete"
git clone https://github.com/Shougo/neocomplete.vim.git ~/dotfiles/vim/bundle/neocomplete.vim
echo "########## nerdtree"
git clone https://github.com/scrooloose/nerdtree.git ~/dotfiles/vim/bundle/nerdtree
echo "########## tagbar"
git clone https://github.com/majutsushi/tagbar.git ~/dotfiles/vim/bundle/tagbar
echo "########## vim-airline"
git clone https://github.com/bling/vim-airline.git ~/dotfiles/vim/bundle/vim-airline
echo "########## vim-better-whitespace"
git clone https://github.com/ntpeters/vim-better-whitespace.git ~/dotfiles/vim/bundle/vim-better-whitespace
echo "########## vim go"
git clone https://github.com/fatih/vim-go.git ~/dotfiles/vim/bundle/vim-go
echo "########## update all vim plugins"
for i in ~/dotfiles/vim/bundle/*; do git -C $i pull; done

# terminator
echo "########## terminator"
rm -rfv ~/.config/terminator
ln -sf ~/dotfiles/terminator ~/.config/terminator

# tilix
echo "########## tilix"
rm -rfv ~/.config/tilix
ln -sf ~/dotfiles/tilix ~/.config/tilix

# feh
echo "########## feh"
rm -rfv ~/.config/feh
ln -sf ~/dotfiles/feh ~/.config/feh

# i3
echo "########## i3"
rm -rfv ~/.config/i3
mkdir ~/.config/i3
if [ "$HOST" = Mordor-Mobil ]; then
    ln -sf ~/dotfiles/i3/i3blocks_laptop.conf ~/.config/i3/i3blocks.conf
else
    ln -sf ~/dotfiles/i3/i3blocks.conf ~/.config/i3/i3blocks.conf
fi
ln -sf ~/dotfiles/i3/config.base ~/.config/i3/config.base
#ln -sf ~/dotfiles/i3/config ~/.config/i3/config
j4-make-config

# Xresources
echo "########## Xresources"
rm -rfv ~/.Xresources
ln -sf ~/dotfiles/Xresources ~/.Xresources

# sorin zprezto
echo "########## zprezto"
if [ -e ~/.zprezto ]
then
    cd ~/.zprezto
    git submodule foreach --recursive git pull origin master
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
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
