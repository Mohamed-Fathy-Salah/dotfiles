syntax enable

set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
set nocompatible
set autoindent
set smartindent
set noerrorbells
set expandtab tabstop=4 softtabstop=4
set shiftwidth=4
set wrap
set noswapfile
set nobackup
set undodir=~/.cache/nvim/undo
set undofile
set incsearch
set hlsearch
set number relativenumber cursorline
set nohlsearch
set hidden
set clipboard=unnamed
set pastetoggle=<F3>
set background=dark
set splitbelow splitright
set scrolloff=8 sidescrolloff=8
set completeopt=menu,menuone,noselect,noinsert
set mouse=a
set noshowmode
set termguicolors
set signcolumn=yes
colorscheme darcula

hi LineNr guifg=light
hi CursorLineNr guifg=gold

let g:python3_host_prog = expand("/usr/bin/python")
"let g:python3_host_prog = expand("/home/mofasa/miniconda3/bin/python")

