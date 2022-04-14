syntax on

set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
set nocompatible
set autoindent
set smartindent
set noerrorbells 
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set wrap
set noswapfile
set nobackup
set undodir=~/.cache/vim/undo
set undofile
set incsearch
set hlsearch
set relativenumber
set nu
set nohlsearch
set hidden
set clipboard=unnamed
set pastetoggle=<F3>
set background=dark
set splitbelow splitright

call plug#begin('~/.vim/plugged')
"Plug 'morhetz/gruvbox'"
Plug 'gruvbox-community/gruvbox'
Plug 'chrisbra/Colorizer'
call plug#end()

"autocmd filetype cpp nnoremap <F4> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>""
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>

colorscheme gruvbox
imap jk <Esc>
imap JK <Esc>
vmap <C-c> "+y
vmap <C-x> "+d
imap <C-v> <Esc>"+p

let mapleader = " "

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>pv :Ex <CR>
nnoremap <leader>q :q <CR>
nnoremap <leader>Q :q! <CR>
nnoremap <leader>w :w <CR>
nnoremap <leader>W :w !sudo tee % <CR>
nnoremap <leader>s :wq <CR>
nnoremap <Leader>+ :exe "vertical resize +5"<CR>
nnoremap <Leader>- :exe "vertical resize -5"<CR>
nnoremap <Leader>= :wincmd =<CR>
nnoremap <Leader>c :call popup_clear()<CR>
"nnoremap <leader>n :noh <CR>"

let g:netrw_preview=1
let g:netrw_alto=0
let g:netrw_winsize=20
let g:netrw_banner = 0


" let t:is_transparent = 1"
" hi Normal guibg=NONE ctermbg=NONE"
" function! Toggle_transparent()"
"     if t:is_transparent == 0"
"         hi Normal guibg=NONE ctermbg=NONE"
"         let t:is_transparent = 1"
"     else "
"         set background=dark"
"         let t:is_transparent = 0"
"     endif"
" endfunction"
" nnoremap <leader>t :call Toggle_transparent()<CR>"

" map <leader>t :YcmCompleter GetType<cr>
" python
" let g:ycm_python_binary_path = '/usr/bin/python3'
" " Preview window
" let g:ycm_add_preview_to_completeopt = 1
" let g:ycm_autoclose_preview_window_after_completion = 1

" let g:ycm_filepath_completion_use_working_dir = 1
" let g:ycm_confirm_extra_conf = 0

" Maximum hight diagnostic window
" let g:ycm_max_diagnostics_to_display = 5

" Set no limit for autocomplete menu
" let g:ycm_max_num_candidates = 0
 
" let g:ycm_auto_trigger = 1
" let g:ycm_min_num_of_chars_for_completion = 5
" clangd options
" let g:ycm_use_clangd = 1
" let g:ycm_clangd_uses_ycmd_caching = 0
" let g:ycm_clangd_binary_path = exepath("clangd")

" To declaration
" nnoremap <leader>d :YcmCompleter GoToDeclaration<cr>
"nnoremap <leader>i :YcmCompleter GoToImprecise<cr>"
" To include
" nnoremap<leader>i :YcmCompleter GoToInclude<cr>"
" To defenition
" nnoremap<leader>i :YcmCompleter GoToDefinition<cr>
" nnoremap<leader>r :YcmCompleter GoToReferences<cr>
