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


nmap <leader>/ <Plug>NERDCommenterToggle
vmap <leader>/ <Plug>NERDCommenterToggle<CR>gv

nmap <leader>i :lua vim.lsp.buf.definition()<CR>
nmap <leader>r :lua vim.lsp.buf.rename()<CR>
nmap <leader>p :lua vim.lsp.buf.hover()<CR>
nmap <leader>o :lua vim.lsp.buf.references()<CR>
nmap <leader>u :lua vim.lsp.buf.code_action({apply=true, context={only={'quickfix'}}})<CR><CR>

nmap <leader>N :lua vim.diagnostic.goto_prev()<CR>
nmap <leader>n :lua vim.diagnostic.goto_next()<CR>

"autocmd FileType python map <buffer> <F10> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType python map <buffer> <F10> :w<CR>:!python %:t<CR>
"autocmd FileType cpp map <buffer> <F10> :w<CR>:!g++ -g %:t -o %:t:r.out<CR>:!./%:t:r.out<CR>
autocmd FileType cpp map <buffer> <F10> :w<CR>:!g++ %:t -o %:t:r.out<CR>:!./%:t:r.out<CR>
autocmd FileType sh map <buffer> <F10> :w<CR>:!bash %:t<CR>
autocmd FileType javascript map <buffer> <F10> :w<CR>:!node %:t<CR>
autocmd FileType typescript map <buffer> <F10> :w<CR>:!ts-node %:t<CR>
autocmd FileType * map <buffer> <F12> :w<CR>:!git add *<CR>:!git commit<CR>:!git push<CR>

autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()

nmap <leader>fm :lua vim.lsp.buf.formatting_sync()<CR>

"nmap <C-h> :ColorizerToggle<CR> 

" gitsigns
nmap <leader>gs :Gitsigns stage_hunk<CR>
nmap <leader>gr :Gitsigns reset_hunk<CR>
nmap <leader>gS :Gitsigns stage_buffer<CR>
nmap <leader>gu :Gitsigns undo_stage_hunk<CR>
nmap <leader>gR :Gitsigns reset_buffer<CR>
nmap <leader>gp :Gitsigns preview_hunk<CR>
nmap <leader>gb :Gitsigns toggle_current_line_blame<CR>
nmap <leader>gd :Gitsigns diffthis<CR>

" debugger
nmap <F8> :lua require'dap'.toggle_breakpoint()<CR>
nmap <leader><F8> :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nmap <F5> :lua require'dap'.continue()<CR>
nmap <F6> :lua require'dap'.step_over()<CR>
nmap <F7> :lua require'dap'.step_into()<CR>
nmap <leader><F5> :lua require'dap'.repl.open()<CR>

" term
nmap <leader>t :exec '10sp \| terminal'<CR>
nmap <leader>s :Cheat<CR>

" postman
nmap <leader>m :e ~/Documents/devops/rest/test.rest<CR>
nmap <leader>a :call VrcQuery()<CR>
"leader remaining prefixes : b c v x y z A B C D E F G H I J K L M O P R S T U V X Y Z
