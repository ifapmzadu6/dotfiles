"== BASIC ==============================================
" basic
set nocompatible
set title
filetype plugin indent on
" cursor
set whichwrap=b,s,h,l,<,>,[,]
set backspace=indent,eol,start
set cursorline
set cursorcolumn
" info
set number
set ruler
set nowrap
" syntax
syntax on
set syn=auto
" grep
set ignorecase
set wrapscan
set incsearch
set hlsearch
set showmatch
" tab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" scroll
set scrolloff=8
set sidescrolloff=16
set sidescroll=1
" indent
set smartindent
set breakindent
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" file
set autoread
set noswapfile
set hidden
" font
set ambiwidth=double
set clipboard=unnamed
" color
set t_Co=256
set background=dark
colorscheme hybrid
" status bar
set laststatus=2
" window focus
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" open last buffer
augroup vimrcEx
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" | endif
augroup END
" beep
set visualbell t_vb=
set noerrorbells
" yank
nnoremap Y y$
set clipboard=unnamed,autoselect


"== PLUGIN ==============================================

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" vim-fugitive
autocmd QuickFixCmdPost *grep* cwindow
" lightline.vim
let g:lightline = {'colorscheme': 'jellybeans'}
" vim-gitgutter
set updatetime=500


