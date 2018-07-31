" syntax higlighting always on
syntax on
set t_Co=256
"set background=dark
colorscheme vice

set number
set encoding=utf-8

" brackets
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     (
inoremap ()     ()

" tabs
filetype plugin indent on
set tabstop=4
set shiftwidth=4
" next command replaces tabstop with approriate number of spaces
"set expandtab

" show tabs with special character
"set list
"set listchars=tab:>-,trail:~,extends:>,precedes:<

set autoindent

" highlight selection
set hlsearch

" pathogen plugin manager
execute pathogen#infect()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" download vim plug
if empty(glob('~/dotfiles/vim/autoload/plug.vim'))
  silent !curl -fLo ~/dotfiles/vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" section for vim plug
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'zchee/deoplete-go', { 'do': 'make'}
else
	call plug#begin('~/.vim/plugged')

	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
	Plug 'zchee/deoplete-go', { 'do': 'make'}
endif

call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable deoplete
let g:deoplete#enable_at_startup = 1

" activate airline status bar plugin
set laststatus=2

if has('nvim')
	" completion for neovim
else
	" neocomplete plugin
	"let g:neocomplete#enable_at_startup = 1
endif

" nerd tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree ~/| endif
map <F4> :NERDTreeToggle<CR>

" tagbar plugin
nmap <F8> :TagbarToggle<CR>

" vim-go settings
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
" highlight same variable
let g:go_auto_sameids = 1
" auto import with go fmt
let g:go_fmt_command = "goimports"
" show types
let g:go_auto_type_info = 1

