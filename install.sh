#!/usr/bin/sh

# backup folder
mkdir -v ~/dotfiles/backup

# vim
echo "########## vim"
ln -sf ~/dotfiles/vim ~/.vim
ln -sf ~/dotfiles/vimrc ~/.vimrc

# neovim
~/dotfiles/vim ~/.config/nvim
~/dotfiles/vimrc ~/.config/nvim/init.vim

# vim pathogen
echo "########## vim"
mkdir ~/dotfiles/vim/bundle
mkdir ~/dotfiles/vim/autoload

# download pathogen to temp file ~
wget -O ~/dotfiles/vim/autoload/pathogen.vim~ https://tpo.pe/pathogen.vim
# delete olt pathogen
if [ -e "~/dotfiles/vim/autoload/pathogen.vim" ]
then
  rm -v "~/dotfiles/vim/autoload/pathogen.vim"
fi
# activate just downloaded pathogen version
mv -v ~/dotfiles/vim/autoload/pathogen.vim~ ~/dotfiles/vim/autoload/pathogen.vim

# vim plugins
echo "########## neocomplete"
if [ -e ~/dotfiles/vim/bundle/neocomplete.vim ]
then
    cd ~/dotfiles/vim/bundle/neocomplete.vim
    git pull
else
    git clone https://github.com/Shougo/neocomplete.vim.git ~/dotfiles/vim/bundle/neocomplete.vim
fi

echo "########## nerdtree"
if [ -e ~/dotfiles/vim/bundle/nerdtree ]
then
    cd ~/dotfiles/vim/bundle/nerdtree
    git pull
else
    git clone https://github.com/scrooloose/nerdtree.git ~/dotfiles/vim/bundle/nerdtree
fi

echo "########## tagbar"
if [ -e ~/dotfiles/vim/bundle/tagbar ]
then
    cd ~/dotfiles/vim/bundle/tagbar
    git pull
else
    git clone https://github.com/majutsushi/tagbar.git ~/dotfiles/vim/bundle/tagbar
fi

echo "########## vim-airline"
if [ -e ~/dotfiles/vim/bundle/vim-airline ]
then
    cd ~/dotfiles/vim/bundle/vim-airline
    git pull
else
    git clone https://github.com/bling/vim-airline.git ~/dotfiles/vim/bundle/vim-airline
fi

echo "########## vim-better-whitespace"
if [ -e ~/dotfiles/vim/bundle/vim-better-whitespace ]
then
    cd ~/dotfiles/vim/bundle/vim-better-whitespace
    git pull
else
    git clone https://github.com/ntpeters/vim-better-whitespace.git ~/dotfiles/vim/bundle/vim-better-whitespace
fi

echo "########## vim go"
if [ -e ~/dotfiles/vim/bundle/vim-go ]
then
    cd ~/dotfiles/vim/bundle/vim-go
    git pull
else
    git clone https://github.com/fatih/vim-go.git ~/dotfiles/vim/bundle/vim-go
fi

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
for rcfile in ~/dotfiles/zprezto/runcoms/^README.md; do
  ln -sf "$rcfile" "~/dotfiles/zprezto/runcoms/.${rcfile:t}"
done