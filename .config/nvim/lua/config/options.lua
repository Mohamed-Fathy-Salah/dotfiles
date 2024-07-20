-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.vsnip_snippet_dir = vim.fn.expand("~/.config/nvim/snippets")

vim.g.dbs = {
  { name = "broker dev", url = "postgres://postgres:qwerty@localhost:5432/broker" },
}
