#!/bin/bash
# initialize all submodules
#git submodule update --init --recursive
# upgrading submodules to the latest published version
#git submodule update --init --remote

# download new pathogen version
curl -LSso vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# just clone all plugins / tools 
cd vim/bundle/
git clone https://github.com/Shougo/neocomplete.vim.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/majutsushi/tagbar.git
git clone https://github.com/bling/vim-airline.git
git clone https://github.com/ntpeters/vim-better-whitespace.git
git clone https://github.com/fatih/vim-go.git
cd ..
cd ..
git clone https://github.com/zmnpl/prezto.git zprezto

# run dotfile installation
sh install_dotfiles.sh
