"== BASIC ==============================================
" basic
set nocompatible
set title
filetype plugin indent on
" cursor
set whichwrap=b,s,h,l,<,>,[,]
set backspace=indent,eol,start
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
set encoding=UTF-8
set ambiwidth=double
set clipboard=unnamed
" color
set t_Co=256
set background=dark
colorscheme hybrid
" status bar
set laststatus=2
set noshowmode
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
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" vim-fugitive
autocmd QuickFixCmdPost *grep* cwindow
" vim-gitgutter
set updatetime=250
" lightline.vim
let g:lightline = {
    \ 'colorscheme': 'jellybeans',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'filename' ],
    \             [ 'fugitive'] ],
    \   'right': [ [ 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'inactive': {
    \   'left': [['filename']],
    \   'right': []
    \ },
    \ 'component_function': {
    \   'mode': 'LightLineMode',
    \   'fugitive': 'LightLineFugitive',
    \   'filename': 'LightLineFilename',
    \   'filetype': 'LightLineFiletype',
    \   'fileformat': 'LightLineFileformat',
    \   'fileencoding': 'LightLineFileencoding',
    \ },
    \ }
function! LightLineMode()
    return winwidth(0) > 70 ? (lightline#mode()) : ''
endfunction
function! LightLineFugitive()
    return winwidth(0) > 70 ? (exists("*fugitive#head") ? fugitive#head() : '') : ''
endfunction
function! LightLineFilename()
    return winwidth(0) > 70 ? (expand('%t') != '' ? expand('%t') : 'No File') : ''
endfunction
function! LightLineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? (&filetype) : '') : ''
endfunction
function! LightLineFileformat()
    return winwidth(0) > 70 ? (strlen(&fileformat) ? (&fileformat) : '') : ''
endfunction
function! LightLineFileencoding()
    return winwidth(0) > 70 ? (strlen(&fileencoding) ? (&fileencoding) : '') : ''
endfunction

