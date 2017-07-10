#!/usr/bin/sh

# backup folder
mkdir -v ~/dotfiles/backup

# vim
echo "########## vim"
ln -sf ~/dotfiles/vim ~/.vim
ln -sf ~/dotfiles/vimrc ~/.vimrc

# neovim
echo "########## nvim"
ln -sf ~/dotfiles/vim ~/.config/nvim
ln -sf ~/dotfiles/vimrc ~/.config/nvim/init.vim

# vim pathogen
echo "########## pathogen"
mkdir ~/dotfiles/vim/bundle
mkdir ~/dotfiles/vim/autoload

# download pathogen to temp file ~, activate o
rm -v "~/dotfiles/vim/autoload/pathogen.vim"
wget -O ~/dotfiles/vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

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
cd ~/dotfiles/vim/bundle
for i in `ls`; do
  cd "$i"
  git pull
  cd ..
done

# terminator
echo "########## terminator"
if [ -L ~/.config/terminator ]
then
    rm ~/.config/terminator
elif [ -e ~/.config/terminator ]
then
	echo "backup existing terminator config"
	mv ~/.config/terminator ~/dotfiles/backup
fi
ln -sf ~/dotfiles/terminator ~/.config/terminator

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
