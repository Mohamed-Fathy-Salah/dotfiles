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
nnoremap <leader>s :bw <CR>
nnoremap <Leader>+ :exe "vertical resize +5"<CR>
nnoremap <Leader>- :exe "vertical resize -5"<CR>
nnoremap <Leader>= :wincmd =<CR>
" nnoremap <Leader>c :call popup_clear()<CR>
"nnoremap <leader>n :noh <CR>"


nmap <leader>/ <Plug>NERDCommenterToggle
vmap <leader>/ <Plug>NERDCommenterToggle<CR>gv

nmap <leader>i :lua vim.lsp.buf.definition()<CR>
nmap <leader>r :lua vim.lsp.buf.rename()<CR>
nmap <leader>p :lua vim.lsp.buf.hover()<CR>
nmap <leader>o :lua vim.lsp.buf.references()<CR>

nmap <leader>N :lua vim.diagnostic.goto_prev()<CR>
nmap <leader>n :lua vim.diagnostic.goto_next()<CR>

autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType python map <buffer> <F7> :w<CR>:exec '!python2' shellescape(@%, 1)<CR>
