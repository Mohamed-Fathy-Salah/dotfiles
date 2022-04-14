require'nvim-treesitter.configs'.setup {
  ensure_installed = {"javascript", "lua", "cpp", "c", "java", "python"},

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    extended_mode = false, 
    max_file_lines = nil, 
  }
}
