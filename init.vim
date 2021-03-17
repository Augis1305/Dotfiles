" My Vimrc

set encoding=UTF-8

filetype indent plugin on

"set clipboard+=unnamedplus " Copy/paste between vim and other programs
set clipboard+=unnamedplus

" Enable syntax highlighting
syntax enable

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
set noswapfile
set smartindent
set termguicolors

set cmdheight=2
set updatetime=50
set shortmess+=c

set nohlsearch
set signcolumn=yes
set colorcolumn=100

set expandtab

" set cursorline
set number
set noshowmode

set guicursor=

" Set relative line number
" set relativenumber
set rnu

set scrolloff=10

" Navigate through tabs using Alt/option + h/l
" nnoremap <c-j> <c-w>

" Toggle NERDTree
map <C-i> :NERDTreeToggle<CR> " C-i to toggle NERDtree

" Open NERDTree autoamtically when vim starts up if no files were specified
"autocmd StdinReadPre * let s:std_id=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Call vim-plug
call plug#begin('~/.vim/plugger')
	"NERD tree pluggins
	Plug 'scrooloose/nerdtree'

	" The Basics
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'itchyny/lightline.vim' " Lightline status bar
	" Plug 'frazrepo/vim-rainbow' " Highlight brackets
    Plug 'p00f/nvim-ts-rainbow'

    " Tim Pope plugins
	Plug 'tpope/vim-fugitive' " Git extension
	Plug 'tpope/vim-surround' " Surrond brackets
    Plug 'tpope/vim-commentary' " Easy comment

	" Vim indentation
	Plug 'michaeljsmith/vim-indent-object'

	" Theme
	Plug 'morhetz/gruvbox'
	Plug 'dracula/vim', {'as':'dracula'}
	Plug 'ghifarit53/tokyonight-vim'

	" Language specific plugins
	Plug 'vim-python/python-syntax'

	" Telescope
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-fzy-native.nvim'

	" Auto pairs
	Plug 'jiangmiao/auto-pairs'

	" Nerd tree plugins
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'ryanoasis/vim-devicons'

    " lsp
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    Plug 'tjdevries/nlua.nvim'
    Plug 'tjdevries/lsp_extensions.nvim'

    "Neovim Tree sitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Required rust plugin
    Plug 'rust-lang/rust.vim'

    " Saaaaaaaga
    Plug 'glepnir/lspsaga.nvim'

    Plug 'phaazon/hop.nvim'

call plug#end()

" let g:airline_theme='luna'
" let g:lightline = {
" 	\'colorscheme': 'wombat',
" 	\'active': {
" 	\	'left': [['mode', 'paste'],
" 	\						['gitbranch', 'readonly', 'filename', 'modified']]
" 	\},
" 	\'component_function': {
" 	\	'gitbranch': 'FugitiveHead'
" 	\}
" 	\}

let g:rainbow_active = 1 " Enable vim-rainbow
let g:python_highlight_all = 1 " Enable python syntax highlight

" Set theme
colorscheme tokyonight
set background=dark

" Allows to move text up and down with Capital J or K in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col -1] =~# '\s'
endfunction

" NerdTree configuration
let NERDTreeDirArrrows = 1
let NERDTreeShowHidden = 1

"Fugitive setings
nmap <leader>gs :G<CR>

" Use <TAB> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Avoid showing message extra message when using completion
set shortmess+=c

" let g:python3_host_prog = "~/PythonEnv/bin/python3.8"

lua require("lsp")
lua require("plugins")

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup remote_space
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

augroup set_spell_check
    autocmd!
    autocmd BufWrite *.md setlocal spell spelllang=en_gb
augroup END
