syntax on
" set t_Co=256
set termguicolors
"colorscheme vice
colorscheme dracula
set number
set encoding=utf-8
set autoindent

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

" highlight selection
set hlsearch

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

if has('nvim')
	call plug#begin('~/.local/share/nvim/plugged')

	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'zchee/deoplete-go', { 'do': 'make'}

	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
	Plug 'https://github.com/ntpeters/vim-better-whitespace'
	Plug 'https://github.com/majutsushi/tagbar'

	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'https://github.com/tpope/vim-fugitive'

	Plug 'vim-syntastic/syntastic'

	" Plug 'https://github.com/scrooloose/nerdtree.git'
else
	call plug#begin('~/.vim/plugged')

	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
	Plug 'zchee/deoplete-go', { 'do': 'make'}

	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
	Plug 'https://github.com/ntpeters/vim-better-whitespace'
	Plug 'vim-airline/vim-airline'
	Plug 'https://github.com/majutsushi/tagbar'

	Plug 'vim-syntastic/syntastic'

	Plug 'https://github.com/tpope/vim-fugitive'

	" Plug 'https://github.com/scrooloose/nerdtree.git'
endif

call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable deoplete
let g:deoplete#enable_at_startup = 1

" activate airline status bar plugin
set laststatus=2

" nerd tree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree ~/| endif
"map <F4> :NERDTreeToggle<CR>

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
let g:go_auto_sameids = 1
" automatically show identifier info
autocmd FileType go nmap <Leader>i <Plug>(go-info)
let g:go_auto_type_info = 1
set updatetime=100

" highlight same variable
let g:go_auto_sameids = 1
" auto import with go fmt
let g:go_fmt_command = "goimports"
" show types
let g:go_auto_type_info = 1

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'dracula'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" maybe need later
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set background=dark

" next command replaces tabstop with approriate number of spaces
"set expandtab

" show tabs with special character
"set list
"set listchars=tab:>-,trail:~,extends:>,precedes:<

