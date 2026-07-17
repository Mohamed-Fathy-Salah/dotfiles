" split long line in multiple lines -> visual gq
let mapleader = " "
autocmd FileType python map <buffer> <F8> :w<CR>:terminal cd %:p:h && if [ -d venv ]; then source venv/bin/activate; fi && python %:t<CR>
autocmd FileType cpp map <buffer> <F8> :w<CR>:terminal cd %:p:h && g++ %:t -g -o %:t:r.out && ./%:t:r.out<CR>
autocmd FileType go map <buffer> <F8> :w<CR>:terminal cd %:p:h && go run .<CR>
autocmd FileType c map <buffer> <F8> :w<CR>:terminal cd %:p:h && gcc %:t -o %:t:r.out -lm && ./%:t:r.out<CR>
autocmd FileType sh map <buffer> <F8> :w<CR>:terminal cd %:p:h && bash %:t<CR>
autocmd FileType rust map <buffer> <F8> :w<CR>:terminal cargo run<CR>
autocmd FileType cs nnoremap <buffer> <F9> :w<CR>:terminal dotnet build -c Debug<CR>
autocmd FileType javascript,typescript map <buffer> <F9> :w<CR>:terminal npm run dev<CR>

augroup tex_autocompile
  autocmd!
  autocmd BufWritePre *.tex lua require("conform").format({ bufnr = 0 })
  autocmd BufWritePost *.tex call jobstart(['tectonic', expand('%:p')])
augroup END

command! OpenPDF silent !zathura %:r.pdf &

" Resize with arrows
nnoremap <a-up> :resize +2<cr>
nnoremap <a-down> :resize -2<cr>
nnoremap <a-left> :vertical resize -2<cr>
nnoremap <a-right> :vertical resize +2<cr>

" Navigate buffers
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

" Snacks picker
nnoremap <Leader>ff <cmd>lua Snacks.picker.files()<CR>
vnoremap <Leader>ff "zy<cmd>lua Snacks.picker.files({ pattern = vim.fn.getreg('z') })<CR>
nnoremap <Leader>fp <cmd>lua Snacks.picker.projects()<CR>
nnoremap <Leader>fg <cmd>lua Snacks.picker.grep()<CR>
vnoremap <Leader>fg "zy<cmd>lua Snacks.picker.grep({ search = vim.fn.getreg('z') })<CR>
nnoremap <Leader>fr <cmd>lua Snacks.picker.resume()<CR>
nnoremap <Leader>fb <cmd>lua Snacks.picker.buffers()<CR>
nnoremap <Leader>fh <cmd>lua Snacks.picker.help()<CR>

nnoremap <leader>e <cmd>NvimTreeToggle<CR>

vmap <C-c> "+y
vmap <C-x> "+d
imap <C-v> <Esc>"+p

" window Navigate
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

nnoremap <leader>q :confirm qall<CR>
nnoremap <leader>d <cmd>lua Snacks.bufdelete()<CR>
nnoremap <leader>D <cmd>lua Snacks.bufdelete.all()<CR>
nnoremap <leader>Q :q! <CR>
nnoremap <leader>w :w <CR>
nnoremap <leader>W :w !sudo tee % <CR>l<CR>
nnoremap <Leader>= :wincmd =<CR>

nmap <leader>/ <Plug>NERDCommenterToggle
vmap <leader>/ <Plug>NERDCommenterToggle<CR>gv

nmap <leader>i :lua vim.lsp.buf.definition()<CR>
nmap <leader>r :lua vim.lsp.buf.rename()<CR>
nmap <leader>p :lua vim.lsp.buf.hover()<CR>
nmap <leader>o :lua vim.lsp.buf.references()<CR>
nmap <leader>u :lua vim.lsp.buf.code_action({apply=true})<CR>

nmap <leader>N :lua vim.diagnostic.goto_prev()<CR>
nmap <leader>n :lua vim.diagnostic.goto_next()<CR>

nmap <leader>fm :set modifiable<CR>:lua vim.lsp.buf.format()<CR>

" gitsigns
nmap <leader>gs :Gitsigns stage_hunk<CR>
nmap <leader>gr :Gitsigns reset_hunk<CR>
nmap <leader>gS :Gitsigns stage_buffer<CR>
nmap <leader>gu :Gitsigns undo_stage_hunk<CR>
nmap <leader>gR :Gitsigns reset_buffer<CR>
nmap <leader>gp :Gitsigns preview_hunk<CR>
nmap <leader>gb :Gitsigns toggle_current_line_blame<CR>
nmap <leader>gd :Gitsigns diffthis<CR>
nmap ]c :Gitsigns next_hunk<CR>
nmap [c :Gitsigns prev_hunk<CR>
nnoremap <leader>gl :lua Snacks.lazygit()<CR>

" debugger
nnoremap <F10> :lua require('dap').step_over()<CR>
nnoremap <leader><F10> :lua require('dap').step_into()<CR>
nnoremap <F12> :lua require('dap').step_out()<CR>
nnoremap <Leader><F5> :lua require('dap').run_to_cursor()<CR>
nnoremap <Leader>b :lua require('dap').toggle_breakpoint()<CR>
nnoremap <Leader>B :lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <Leader>0 :lua require('dapui').eval()<CR>

nmap <leader>v :vs<CR>:bnext<CR>

tnoremap <leader>h <C-\><C-N><C-w>h
tnoremap <leader>j <C-\><C-N><C-w>j
tnoremap <leader>k <C-\><C-N><C-w>k
tnoremap <leader>l <C-\><C-N><C-w>l

" Toggle 'default' terminal
function! ChooseTerm(termname)
	let buf = bufexists(a:termname)
    let pane = bufwinnr(a:termname)
    if pane > 0
        :exe pane . "wincmd c"
    elseif buf > 0
        :exe "20sp"
		:exe "buffer " . a:termname
	else
        :exe "20sp"
        :terminal
		:exe "f " a:termname
	endif
endfunction
nnoremap <leader><CR> :call ChooseTerm("term")<CR>

" execute current line
nnoremap <leader>c :. !bc<CR>
nnoremap <leader>x :. !bash<CR>
vnoremap <leader>c yO<Esc>p:. !bc<CR>0Dgvpkdd

function! SwitchCodeTest()
    let l:fname = expand('%:t:r')
    let l:dir = expand('%:p:h')

    if l:dir =~# 'Controllers'
        " From Controller -> Test
        let l:root = substitute(l:dir, '\v/Controllers.*$', '', '')
        let l:testname = substitute(l:fname, 'Controller$', 'Tests', '')
        exe 'e ' . l:root . '.Tests/' . l:testname . '.cs'
    else
        " From Test -> Controller
        let l:root = substitute(l:dir, '\v(\.Tests).*$', '', '')
        let l:ctrlname = substitute(l:fname, 'Tests$', 'Controller', '')
        exe 'e ' . l:root . '/Controllers/' . l:ctrlname . '.cs'
    endif
endfunction
nnoremap <leader>s :call SwitchCodeTest()<CR>

nnoremap <F2> :CodeCompanionChat<CR>
nnoremap <leader><F2> :CodeCompanionActions<CR>
vnoremap <F2> :CodeCompanionChat<CR>

command! Bonly lua Snacks.bufdelete.other()
command! BWonly lua vim.cmd('wall'); Snacks.bufdelete.other({force=true})

vnoremap <leader>PS :s/\%#\w\+/\=tolower(substitute(submatch(0), '\C\(\l\)\([A-Z]\)', '\1_\l\2', 'g'))/<CR>

function! CopyGithubUrl()
  let l:dir = shellescape(expand('%:p:h'))
  let l:remote = substitute(system('git -C ' . l:dir . ' remote get-url origin'), '\n', '', 'g')
  let l:remote = substitute(l:remote, '\.git$', '', '')
  let l:remote = substitute(l:remote, 'git@github\.com:', 'https://github.com/', '')

  let l:sha = substitute(system('git -C ' . l:dir . ' rev-parse HEAD'), '\n', '', 'g')
  let l:root = substitute(system('git -C ' . l:dir . ' rev-parse --show-toplevel'), '\n', '', 'g')
  let l:fpath = substitute(expand('%:p'), '^' . l:root . '/', '', '')

  let l:l1 = line("'<")
  let l:l2 = line("'>")
  let l:lines = l:l1 == l:l2 ? '#L' . l:l1 : '#L' . l:l1 . '-L' . l:l2

  let l:url = l:remote . '/blob/' . l:sha . '/' . l:fpath . l:lines
  let @+ = l:url
  echo l:url
endfunction
vnoremap <leader>yg :<C-u>call CopyGithubUrl()<CR>

function! CopyFileLines()
  let l:fname = expand('%:t')
  let l:l1 = line("'<")
  let l:l2 = line("'>")
  let l:lines = l:l1 == l:l2 ? ':' . l:l1 : ':' . l:l1 . '-' . l:l2
  let l:out = l:fname . l:lines
  let @+ = l:out
  echo l:out
endfunction
vnoremap <leader>yy :<C-u>call CopyFileLines()<CR>
