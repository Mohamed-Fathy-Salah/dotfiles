-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cs",
  callback = function()
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<F10>",
      ":w<CR>:!setsid st -e dotnet run<CR><CR>",
      { noremap = true, silent = true }
    )
  end,
})
