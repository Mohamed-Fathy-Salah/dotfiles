-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- lua/config/keymaps.lua

local del = vim.keymap.del
del({ "n" }, "s")
del({ "n" }, "<Space>uC")
del({ "n" }, "<Space>un")
del({ "n" }, "<Space>up")
del({ "n" }, "gc")
del({ "n" }, "gcc")
del({ "n" }, "<C-W><C-D>")
del({ "n" }, "<C-W><Space>")
del({ "n" }, "<C-W>d")
del({ "n" }, "<Space>ql")
del({ "n" }, "<Space>qd")
del({ "n" }, "<Space>qs")
del({ "n" }, "<Space>cS")
del({ "n" }, "<Space>cs")
del({ "n" }, "<Space>cm")
del({ "n" }, "<Space>cF")
del({ "n" }, "<Space>cl")
del({ "n" }, "<Space>xx")
del({ "n" }, "<Space>xt")
del({ "n" }, "<Space>xL")
del({ "n" }, "<Space>xT")
del({ "n" }, "<Space>xX")
del({ "n" }, "<Space>xQ")
del({ "x", "o" }, "il")
del({ "x", "o" }, "in")
del({ "x", "o" }, "al")
del({ "x", "o" }, "an")
del({ "x", "s" }, "<Space>cF")
del({ "x" }, "a")

local map = vim.keymap.set

map({ "i" }, "jk", "<esc>", { desc = "Escape", noremap = false })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

map({ "n" }, "<leader>]", "]m")
map({ "n" }, "<leader>[", "[m")

map({ "n" }, "<s-l>", ":bnext<cr>")
map({ "n" }, "<s-h>", ":bprevious<cr>")

map({ "v" }, "<", "<gv")
map({ "v" }, ">", ">gv")

map({ "n" }, "<Leader>fg", ":Telescope live_grep<CR>")

map({ "v" }, "<C-c>", '"+y')
map({ "v" }, "<C-x>", '"+d')
map({ "i" }, "<C-v>", '"<Esc>"+p')

map({ "n" }, "<leader>h", ":wincmd h<CR>")
map({ "n" }, "<leader>j", ":wincmd j<CR>")
map({ "n" }, "<leader>k", ":wincmd k<CR>")
map({ "n" }, "<leader>l", ":wincmd l<CR>")

map({ "n" }, "<leader>w", ":w!<CR>")
map({ "n" }, "<leader>W", ":w !sudo tee % <CR>")
map({ "n" }, "<leader>q", ":q<CR>")
map({ "n" }, "<leader>d", ":bd<CR>")
map({ "n" }, "<leader>Q", ":q!<CR>")
map({ "n" }, "<Leader>=", ":wincmd =<CR>")

map({ "n" }, "<leader>/", "<Plug>NERDCommenterToggle")
map({ "v" }, "<leader>/", "<Plug>NERDCommenterToggle<CR>gv")

map({ "n" }, "<leader>u", ":lua vim.lsp.buf.code_action({apply=true, context={only={'quickfix'}}})<CR>")
map({ "n" }, "<leader>i", ":lua vim.lsp.buf.definition()<CR>")
map({ "n" }, "<leader>r", ":lua vim.lsp.buf.rename()<CR>")
map({ "n" }, "<leader>p", ":lua vim.lsp.buf.hover()<CR>")
map({ "n" }, "<leader>o", ":lua vim.lsp.buf.references()<CR>")

map({ "n" }, "<leader>N", ":lua vim.diagnostic.goto_prev()<CR>")
map({ "n" }, "<leader>n", ":lua vim.diagnostic.goto_next()<CR>")

map({ "n" }, "<leader>fm", ":set modifiable<CR>:lua vim.lsp.buf.format()<CR>")

map({ "n" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
map({ "n" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
map({ "n" }, "<leader>gS", ":Gitsigns stage_buffer<CR>")
map({ "n" }, "<leader>gu", ":Gitsigns undo_stage_hunk<CR>")
map({ "n" }, "<leader>gR", ":Gitsigns reset_buffer<CR>")
map({ "n" }, "<leader>gp", ":Gitsigns preview_hunk<CR>")
map({ "n" }, "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>")
map({ "n" }, "<leader>gd", ":Gitsigns diffthis<CR>")
map({ "n" }, "<leader>gn", ":Gitsigns next_hunk<CR>")
map({ "n" }, "<leader>gN", ":Gitsigns prev_hunk<CR>")

map({ "n" }, "<s-l>", ":bnext<cr>")
map({ "n" }, "<s-h>", ":bprevious<cr>")

map({ "n" }, "<leader>A", " :e ~/Documents/devops/rest/test.rest<CR>")
map({ "n" }, "<leader>a", " :call VrcQuery()<CR>")

map({ "n" }, "<leader>v", ":vs<CR>:bnext<CR>")

map("n", "<leader><CR>", function()
  local termname = "term"
  local buf_exists = vim.fn.bufexists(termname)
  local pane = vim.fn.bufwinnr(termname)

  if pane > 0 then
    vim.api.nvim_command(pane .. "wincmd c")
  elseif buf_exists > 0 then
    vim.api.nvim_command("20sp")
    vim.api.nvim_command("buffer " .. termname)
  else
    vim.api.nvim_command("20sp")
    vim.api.nvim_command("terminal")
    vim.api.nvim_command("file " .. termname)
  end
end, { noremap = true, silent = true })

map({ "t" }, "<leader>h", "<C-\\><C-N><C-w>h")
map({ "t" }, "<leader>j", "<C-\\><C-N><C-w>j")
map({ "t" }, "<leader>k", "<C-\\><C-N><C-w>k")
map({ "t" }, "<leader>l", "<C-\\><C-N><C-w>l")

map({ "n" }, "<leader>c", ":. !bc<CR>")
map({ "n" }, "<leader>x", ":. !bash<CR>")
map({ "v" }, "<leader>c", "yO<Esc>p:. !bc<CR>0Dgvpkdd")

map({ "n" }, "<leader><F4>", ":set foldmethod=indent<CR>")
map({ "i" }, "<F4>", "<C-O>za")
map({ "n" }, "<F4>", "za")
map({ "o" }, "<F4>", "<C-C>za")
map({ "v" }, "<F4>", "zf")
map({ "n" }, "<leader><F3>", "zM")
map({ "n" }, "<F3>", "zR")

--[[
" debugger
"nmap <F8> :lua require'dap'.toggle_breakpoint()<CR>
"nmap <leader><F8> :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
"nmap <F5> :lua require'dap'.continue()<CR>
"nmap <F6> :lua require'dap'.step_over()<CR>
"nmap <F7> :lua require'dap'.step_into()<CR>
"nmap <leader><F5> :lua require'dap'.repl.open()<CR>

" harpoon
nmap <leader>m :lua require("harpoon.mark").add_file()<CR>
nmap <leader>t :lua require("harpoon.ui").toggle_quick_menu()<CR>
nmap <leader>1 :lua require("harpoon.ui").nav_file(1)<CR>
nmap <leader>2 :lua require("harpoon.ui").nav_file(2)<CR>
nmap <leader>3 :lua require("harpoon.ui").nav_file(3)<CR>
nmap <leader>4 :lua require("harpoon.ui").nav_file(4)<CR>

nnoremap <leader>s :call SwitchCodeTest()<CR>
function! SwitchCodeTest()
    if expand('%:e:e:r') == 'test'
        :exe 'e ' . expand('%:p:h:h') . '/' . expand('%:t:r:r') . '.' . expand('%:e')
    else
        :exe 'e ' . expand('%:p:h') . '/__test__/' . expand('%:t:r') . '.test.' . expand('%:e')
    endif
endfunction


"vnoremap <leader>s :lua require"surround".surround()<CR>
"vnoremap <leader>a :lua surround()<CR>

"vsnip
" Expand or jump
imap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

"fake
nnoremap <leader>fr :%s/dummy/\=fake#

"leader remaining prefixes : a b y z A B C D E F G H I J K L M O P R S U V X Y Z

*/
--]]
