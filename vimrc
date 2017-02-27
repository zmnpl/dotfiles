" syntax higlighting always on
syntax on
set t_Co=256
set background=dark
colorscheme shiny-white

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

" activate airline status bar plugin
set laststatus=2

if has('nvim')
	" completion for neovim
else
	" neocomplete plugin
	let g:neocomplete#enable_at_startup = 1
endif

" nerd tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree ~/| endif
map <F4> :NERDTreeToggle<CR>

" tagbar plugin
nmap <F8> :TagbarToggle<CR>

" vim-go settings
let g:go_highlight_functions = 0
let g:go_highlight_methods = 0
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

