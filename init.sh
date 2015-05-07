#!/bin/bash
############################################
# basic configuration
basedir=~/dotfiles
# vim plugins (git)
vimplugins="
https://github.com/Shougo/neocomplete.vim.git
https://github.com/scrooloose/nerdtree.git
https://github.com/majutsushi/tagbar.git
https://github.com/bling/vim-airline.git
https://github.com/ntpeters/vim-better-whitespace.git
https://github.com/fatih/vim-go.git
"
############################################

# vim
# download new pathogen version
echo "downloading pathogen"
cd $basedir
curl -LSso vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
# just clone all plugins / tools
echo "cloning vim plugins"
mkdir -p vim/bundle/
cd vim/bundle/
# do for every plugin
for p in $vimplugins; do
    if [ ! -d "$p" ]; then
      git clone $p
    fi
    # todo: check for existence first
   # git clone $p
done
cd $basedir
############################################

############################################
# prezto
echo "cloning personal prezto fork"
git clone --recursive https://github.com/zmnpl/prezto.git zprezto
############################################

############################################
# run dotfile installation
echo "run dotfile installation script"
./install_dotfiles.sh
############################################
