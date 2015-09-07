" syntax higlighting always on
syntax on
set t_Co=256
set background=dark
colorscheme pride
"color pride
" color onedark
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
" set expandtab

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

" neocomplete plugin
let g:neocomplete#enable_at_startup = 1

" nerd tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree ~/| endif
map <F4> :NERDTreeToggle<CR>

" tagbar plugin
nmap <F8> :TagbarToggle<CR>

" vim-go settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" vim startup size
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window (for an alternative on Windows, see simalt below).
  " set lines=999 columns=999
else
  " This is console Vim.
  if exists("+lines")
    " set lines=60
  endif
  if exists("+columns")
    " set columns=180
  endif
endif

" set font
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Source\ Code\ Pro\ Light\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif
