return {
  { "LazyVim/LazyVim", opts = { defaults = { autocmds = false, keymaps = false } } },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")

      opts.mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.fn["vsnip#available"](1) == 1 then
            feedkey("<Plug>(vsnip-expand-or-jump)", "")
          elseif has_words_before() then
            cmp.complete()
          else
            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkey("<Plug>(vsnip-jump-prev)", "")
          end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fg", false },
      { "<leader>/", false },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "c_sharp",
      },
    },
  },
  { "preservim/nerdcommenter" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = {
          on_attach = function(client, bufnr)
            local function buf_set_keymap(...)
              vim.api.nvim_buf_set_keymap(bufnr, ...)
            end
            local opts = { noremap = true, silent = true }
          end,
          cmd = { "omnisharp" },
          root_dir = require("lspconfig").util.root_pattern("*.sln", "*.csproj", ".git"),
        },
      },
    },
  },
}
