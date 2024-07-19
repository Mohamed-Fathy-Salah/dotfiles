local M = {}
local M.config = {}

function surround()
  local buf = vim.api.nvim_get_current_buf()
  local start_line, start_col = unpack(vim.api.nvim_buf_get_mark(0, "<"))
  local end_line, end_col = unpack(vim.api.nvim_buf_get_mark(0, ">"))

  vim.api.nvim_buf_append(buf, start_line, {"try {"})
  vim.api.nvim_buf_append(buf, end_line, {"} catch() {}"})
end

return M
