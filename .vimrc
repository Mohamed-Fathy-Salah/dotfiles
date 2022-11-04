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
" split long line in multiple lines -> visual gq
let mapleader = " "

" Resize with arrows
nnoremap <a-up> :resize +2<cr>
nnoremap <a-down> :resize -2<cr>
nnoremap <a-left> :vertical resize -2<cr>
nnoremap <a-right> :vertical resize +2<cr>

" Navigate buffers
"nnoremap <TAB> :bnext<cr>
"nnoremap <S-TAB> :bprevious<cr>
nnoremap <s-l> :bnext<cr>
nnoremap <s-h> :bprevious<cr>

" Fast-type jk to switch to normal mode
inoremap jk <esc>

" Stay in indent mode
vnoremap < <gv
vnoremap > >gv

" Move text up and down
nnoremap <a-j> :m .+1<cr>==
nnoremap <a-k> :m .-2<cr>==
inoremap <a-j> <Esc>:m .+1<cr>==gi
inoremap <a-k> <Esc>:m .-2<cr>==gi
vnoremap <a-j> :m '>+1<cr>gv=gv
vnoremap <a-k> :m '<-2<cr>gv=gv

" Preserve copied content on paste
" vnoremap p "_dP

" Telescope
" nnoremap <leader>f <cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>
" nnoremap <c-t> <cmd>Telescope live_grep<cr>
nnoremap <Leader>ff :Telescope find_files<CR>
nnoremap <Leader>fg :Telescope live_grep<CR>
nnoremap <Leader>fb :Telescope buffers<CR>
nnoremap <Leader>fh :Telescope help_tags<CR>

" Nvim Tree
nnoremap <leader>e :NvimTreeToggle<cr>

" ---------

vmap <C-c> "+y
vmap <C-x> "+d
imap <C-v> <Esc>"+p

" window Navigate
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>q :q <CR>
nnoremap <leader>d :bd <CR>
nnoremap <leader>Q :q! <CR>
nnoremap <leader>w :w <CR>
nnoremap <leader>W :w !sudo tee % <CR>
"nnoremap <leader>s :bw <CR>
"nnoremap <Leader>+ :vertical resize +5<CR>
"nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>= :wincmd =<CR>
" nnoremap <Leader>c :call popup_clear()<CR>
"nnoremap <leader>n :noh <CR>"


"nmap <leader>/ <Plug>NERDCommenterToggle
"vmap <leader>/ <Plug>NERDCommenterToggle<CR>gv

"nmap <leader>i :lua vim.lsp.buf.definition()<CR>
"nmap <leader>r :lua vim.lsp.buf.rename()<CR>
"nmap <leader>p :lua vim.lsp.buf.hover()<CR>
"nmap <leader>o :lua vim.lsp.buf.references()<CR>
"nmap <leader>u :lua vim.lsp.buf.code_action({apply=true, context={only={'quickfix'}}})<CR>

"nmap <leader>N :lua vim.diagnostic.goto_prev()<CR>
"nmap <leader>n :lua vim.diagnostic.goto_next()<CR>

"autocmd FileType python map <buffer> <F10> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType python map <buffer> <F10> :w<CR>:!python %:t<CR>
"autocmd FileType cpp map <buffer> <F10> :w<CR>:!g++ -g %:t -o %:t:r.out<CR>:!./%:t:r.out<CR>
autocmd FileType cpp map <buffer> <F10> :w<CR>:!g++ %:t -o %:t:r.out<CR>:!./%:t:r.out<CR>
autocmd FileType sh map <buffer> <F10> :w<CR>:!bash %:t<CR>
autocmd FileType javascript map <buffer> <F10> :w<CR>:!node %:t<CR>
autocmd FileType typescript map <buffer> <F10> :w<CR>:!ts-node %:t<CR>
"autocmd FileType * map <buffer> <F12> :w<CR>:!git add *<CR>:!git commit<CR>:!git push<CR>
autocmd FileType * map <buffer> <F12> :w<CR>:terminal npm run test:ci<CR>

"autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()

"nmap <leader>fm :lua vim.lsp.buf.formatting_sync()<CR>

"nmap <C-h> :ColorizerToggle<CR> 

" gitsigns
"nmap <leader>gs :Gitsigns stage_hunk<CR>
"nmap <leader>gr :Gitsigns reset_hunk<CR>
"nmap <leader>gS :Gitsigns stage_buffer<CR>
"nmap <leader>gu :Gitsigns undo_stage_hunk<CR>
"nmap <leader>gR :Gitsigns reset_buffer<CR>
"nmap <leader>gp :Gitsigns preview_hunk<CR>
"nmap <leader>gb :Gitsigns toggle_current_line_blame<CR>
"nmap <leader>gd :Gitsigns diffthis<CR>

" debugger
"nmap <F8> :lua require'dap'.toggle_breakpoint()<CR>
"nmap <leader><F8> :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
"nmap <F5> :lua require'dap'.continue()<CR>
"nmap <F6> :lua require'dap'.step_over()<CR>
"nmap <F7> :lua require'dap'.step_into()<CR>
"nmap <leader><F5> :lua require'dap'.repl.open()<CR>

" term
nmap <leader>s :Cheat<CR>

" postman
"nmap <leader>m :e ~/Documents/devops/rest/test.rest<CR>
"nmap <leader>a :call VrcQuery()<CR>

nmap <leader>v :vs<CR>:bnext<CR>

" harpoon
"nmap <leader>m :lua require("harpoon.mark").add_file()<CR>
"nmap <leader>t :lua require("harpoon.ui").toggle_quick_menu()<CR>
"nmap gj :lua require("harpoon.ui").nav_file(1)<CR>
"nmap gk :lua require("harpoon.ui").nav_file(2)<CR>
"nmap gl :lua require("harpoon.ui").nav_file(3)<CR>
"nmap gh :lua require("harpoon.ui").nav_file(4)<CR>
"nmap <leader>t :lua require("harpoon.term").gotoTerminal(1)<CR>

"leader remaining prefixes : a b c x y z A B C D E F G H I J K L M O P R S U V X Y Z
