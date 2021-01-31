
" Set to ward off unexpected things that you distro might have made as well
" As sanely reset options when re-sourcing .vimrc
"set nocompatible
set encoding=UTF-8

filetype indent plugin on

"set clipboard+=unnamedplus " Copy/paste between vim and other programs
set clipboard+=unnamedplus

" Enable syntax highlighting
syntax off

" Map space to leader key
let mapleader=" "

" Leader + w to save the leader + q to close 
noremap <Leader>w :w<cr>
noremap <Leader>q :q<cr>
noremap <C-h> :tabprevious<CR>
noremap <C-l> :tabnext<CR>
"
" Map jk to be escape key
inoremap jk <esc>

" To use 256 bit colors
set t_Co=256

"set backspace=indent,eol,start
 
" => Text, tab and indent related
set smarttab
set shiftwidth=4 softtabstop=4
set tabstop=4
set hidden
set nobackup
set nowritebackup
set noswapfile

set cmdheight=2
set updatetime=300
set shortmess+=c

set nohlsearch
set signcolumn=yes

" set cursorline
set number
set noshowmode

" Set relative line number
" set relativenumber
set rnu

" Navigate through tabs using Alt/option + h/l
" nnoremap <c-j> <c-w>

" Toggle NERDTree
map <C-i> :NERDTreeToggle<CR> " C-i to toggle NERDtree

" Open NERDTree autoamtically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_id=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Call vim-plug 
call plug#begin('~/.vim/plugger')
	"NERD tree pluggins
	Plug 'scrooloose/nerdtree'
	" The Basics
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'itchyny/lightline.vim' " Lightline status bar
	Plug 'frazrepo/vim-rainbow' " Highlight brackets
	" Tim Pope plugins
	Plug 'tpope/vim-fugitive' " Git extension
	Plug 'tpope/vim-surround' " Surrond brackets
	
	" Vim indentation
	Plug 'michaeljsmith/vim-indent-object'
	" Theme
	Plug 'morhetz/gruvbox'
  
	" Language specific plugins
	Plug 'vim-python/python-syntax'
	Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
	" Intelsense and fuzzy finding
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'jiangmiao/auto-pairs'

	" Nerd tree plugins
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'ryanoasis/vim-devicons'

	" Vue pluggins
	Plug 'leafOfTree/vim-vue'

	Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

let g:airline_theme='luna'
let g:lightline = {
	\'colorscheme': 'wombat',
	\'active': {
	\	'left': [['mode', 'paste'],
	\						['gitbranch', 'readonly', 'filename', 'modified']]
	\},
	\'component_function': {
	\	'gitbranch': 'FugitiveHead'
	\}
	\}
    
let g:rainbow_active = 1 " Enable vim-rainbow
let g:python_highlight_all = 1 " Enable python syntax highlight

" Set theme
colorscheme gruvbox
set background=dark

" Allows to move text up and down with Capital J or K in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
	
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col -1] =~# '\s'
endfunction

"autocmd FileType go :call GoYCM()
"autocmd FileType py :call GoCoc()

" NerdTree configuration
let NERDTreeDirArrrows = 1
let NERDTreeShowHidden = 1

"Fugitive setings

nmap <leader>gs :G<CR>

" FZF toggle
map <leader>t :FZF<CR>
let g:fzf_preview_window = ''

" Import plugin settings

source $HOME/.config/nvim/plug-config/coc.vim

let g:vim_vue_plugin_load_full_syntax = 1
let g:vim_vue_plugin_use_scss = 1

let g:python3_host_prog = "~/PythonEnv/bin/python3.8"

autocmd FileType python let b:coc_root_patterns = ['.git', '.env']
