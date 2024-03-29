syntax on

set shell=/usr/bin/zsh

set number
set encoding=utf-8
set autoindent

" leader key
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" brackets
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     (
inoremap ()     ()

" split navigation
nnoremap <C-Down> <C-W><C-J>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-Up> <C-W><C-K>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-Right> <C-W><C-L>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-Left> <C-W><C-H>
nnoremap <C-H> <C-W><C-H>

" folding
"set foldmethod=syntax
"nnoremap <Tab> zA
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview
"g:go_fmt_experimental = 1

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

	" colors
	Plug 'reedes/vim-colors-pencil'
	Plug 'arzg/vim-colors-xcode'
	Plug 'cormacrelf/vim-colors-github'
	" colors adjusting to terminal
	Plug 'jeffkreeftmeijer/vim-dim'
	Plug 'noahfrederick/vim-noctu'

	" completion
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

	" go
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
	Plug 'https://github.com/majutsushi/tagbar'

	" whitespaces
	Plug 'https://github.com/ntpeters/vim-better-whitespace'

	" python
	Plug 'dense-analysis/ale'
	Plug 'deoplete-plugins/deoplete-jedi'

	" echodoc
	Plug 'Shougo/echodoc'

	" airline
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	" git
	"Plug 'tpope/vim-fugitive'
	"Plug 'junegunn/gv.vim'

	" syntax checker
	Plug 'vim-syntastic/syntastic'

	" fzf
	"Plug '/usr/bin/fzf'
	"Plug '/usr/share/vim/vimfiles/plugin/fzf/fzf.vim'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
else
	call plug#begin('~/.vim/plugged')

	Plug 'reedes/vim-colors-pencil'
	Plug 'cormacrelf/vim-colors-github'
	Plug 'reedes/vim-colors-pencil'

	" completion
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'

	" go
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
	Plug 'https://github.com/majutsushi/tagbar'

	" whitespaces
	Plug 'https://github.com/ntpeters/vim-better-whitespace'

	" python
	Plug 'dense-analysis/ale'
	Plug 'deoplete-plugins/deoplete-jedi'

	" orgmode
	"Plug 'jceb/vim-orgmode'

	" airline
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	" syntax cecker
	Plug 'vim-syntastic/syntastic'

	"fzf
	Plug '/usr/bin/fzf'
	Plug '/usr/share/vim/vimfiles/plugin/fzf/fzf.vim'
endif

call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" fzf
let g:fzf_command_prefix = 'Fzf'
nnoremap <silent> <leader>o :FzfFiles<CR>
nnoremap <silent> <leader>b :FzfBuffers<CR>

" ALE
"let b:ale_fixers = ['autopep8', 'yapf']
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\	'python': ['yapf', 'autopep8']
\}
let g:ale_linters = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\	'python': ['flake8', 'pylint']
\}
let g:ale_fix_on_save = 1

" enable deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

" activate airline status bar plugin
set laststatus=2

" tagbar plugin
nmap <F8> :TagbarToggle<CR>

" echodoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'

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
let g:go_addtags_transform = "snakecase"
" automatically show identifier info
autocmd FileType go nmap <Leader>i <Plug>(go-info)
set updatetime=100
" highlight same variable
let g:go_auto_sameids = 1
" auto import with go fmt
let g:go_fmt_command = "goimports"
" show types
let g:go_auto_type_info = 1

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#ale#enabled = 1

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" color settings
" set t_Co=256
set termguicolors
set background=dark
"colorscheme pencil
"colorscheme xcodedark
colorscheme xcodedark
"let g:airline_theme = 'pencil'
"let g:airline_theme = 'xcodedark'
let g:airline_theme = 'github'
let g:github_colors_soft = 1

" toggle
function ToggleColors()
	if (g:colors_name == "xcodedark")
		colorscheme xcodelight
		let g:airline_theme = 'xcodelight'
	else
		colorscheme xcodedark
		let g:airline_theme = 'xcodedark'
	endif
endfunction

nnoremap <F9> :call ToggleColors()<CR>
"call github_colors#togglebg_map('<f9>')
