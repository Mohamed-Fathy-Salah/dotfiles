require("bufferline").setup{}
--require("colorizer").setup{}
require("gitsigns").setup{}

--require("nvim-cheat").detectFileTypes = {'cpp', 'python', 'typescript', 'javascript'}

---- snippy
require('snippy').setup({
    mappings = {
        is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
        }
    },
})
---- dap
--local dap = require('dap')

--dap.adapters = {
    --python = {
        --type = 'executable',
        --command = 'python',
        --args = { '-m', 'debugpy.adapter'},
    --},
    --cppdbg = {
        --type = 'executable',
        --command = '/home/mofasa/.local/share/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
        --id = 'cppdbg',
    --}
--}

--dap.configurations = {
    --python = {
        --{
            ---- The first three options are required by nvim-dap
            --request = 'launch';
            --name = "Launch file";
            --type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`

            --program = "${file}"; -- This configuration will launch the current file if used.
            --pythonPath = '/usr/bin/python'
        --}
    --},

    --cpp = {
        --{
            --name = "g++ - Build and debug active file",
            --type = "cppdbg",
            --request = "launch",
            --program = "${fileDirname}/${fileBasenameNoExtension}.out",
            --stopAtEntry = false,
            --cwd = "${workspaceFolder}",
            --console = "externalTerminal",
            --MIMode = "gdb",
            --setupCommands = {
                --{
                    --description = "Enable pretty-printing for gdb",
                    --text = "-enable-pretty-printing",
                    --ignoreFailures = true
                --}
            --},
            --preLaunchTask = "C/C++: g++ build active file",
            --miDebuggerPath = "/usr/bin/gdb"
        --}
    --},
--}

---- dap-virtual-text
--require("nvim-dap-virtual-text").setup {
    --highlight_changed_variables = true,
    --highlight_new_as_changed = true,
    --show_stop_reason = true,
    --commented = false,
    --only_first_definition = true,
    --all_references = false,
    --filter_references_pattern = '<module',
    ---- experimental features:
    --virt_text_pos = 'eol',                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
    --all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    --virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
    --virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
--}

---- cmp
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local cmp = require'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
             require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    mapping = {
        --['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        --['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        --['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        --['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        --['<C-e>'] = cmp.mapping({
            --i = cmp.mapping.abort(),
            --c = cmp.mapping.close(),
        --}),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        --['<C-Space>'] = cmp.mapping.confirm {
            --behavior = cmp.ConfirmBehavior.Insert,
            --select = true,
        --},

        ['<Tab>'] = function(fallback)
            if not cmp.select_next_item() then
                if vim.bo.buftype ~= 'prompt' and has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end
        end,

        ['<S-Tab>'] = function(fallback)
            if not cmp.select_prev_item() then
                if vim.bo.buftype ~= 'prompt' and has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end
        end,
    },
    --snippet = {
        ---- We recommend using *actual* snippet engine.
        ---- It's a simple implementation so it might not work in some of the cases.
        --expand = function(args)
            --local line_num, col = unpack(vim.api.nvim_win_get_cursor(0))
            --local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, true)[1]
            --local indent = string.match(line_text, '^%s*')
            --local replace = vim.split(args.body, '\n', true)
            --local surround = string.match(line_text, '%S.*') or ''
            --local surround_end = surround:sub(col)

            --replace[1] = surround:sub(0, col - 1)..replace[1]
            --replace[#replace] = replace[#replace]..(#surround_end > 1 and ' ' or '')..surround_end
            --if indent ~= '' then
                --for i, line in ipairs(replace) do
                    --replace[i] = indent..line
                --end
            --end

            --vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, true, replace)
        --end,
    --},
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        --{ name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
        { name = 'path' }
    })
})

-- Set configuration for specific filetype.
--cmp.setup.filetype('gitcommit', {
    --sources = cmp.config.sources({
        --{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    --}, {
        --{ name = 'buffer' },
    --})
--})

 --Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'cmdline' },
        { name = 'path' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
    --sources = cmp.config.sources({
        --{ name = 'buffer' },
        --{ name = 'path' },
    --})
})


---- diagnostic_signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

---- lang servers
local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.clangd.setup {
    capabilities = capabilities
}

lspconfig.pyright.setup{
    capabilities = capabilities
}


local null_ls = require("null-ls")
local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end
local on_attach = function(client, bufnr)
    --vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    --vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
    --vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    --vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    --vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    --vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    --vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    --vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    --vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
    --vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
    --vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
    --vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
    --buf_map(bufnr, "n", "gd", ":LspDef<CR>")
    --buf_map(bufnr, "n", "gr", ":LspRename<CR>")
    --buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
    --buf_map(bufnr, "n", "K", ":LspHover<CR>")
    --buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
    --buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
    --buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")
    --buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
    --buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")
    --if client.resolved_capabilities.document_formatting then
        --vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    --end
end
lspconfig.tsserver.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider= false
        client.server_capabilities.documentRangeFormattingProvider = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({})
        ts_utils.setup_client(client)
        buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
        buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
        buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
        on_attach(client, bufnr)
    end,
})
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.formatting.prettier,
    },
    on_attach = on_attach,
})
require'lspconfig'.eslint.setup{
    capabilities = capabilities,
    settings = {
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = "separateLine"
        },
        showDocumentation = {
          enable = true
        }
      },
      codeActionOnSave = {
        enable = false,
        mode = "all"
      },
      format = true,
      nodePath = "",
      onIgnoredFiles = "off",
      packageManager = "npm",
      quiet = false,
      rulesCustomizations = {},
      run = "onType",
      useESLintClass = false,
      validate = "on",
      workingDirectory = {
        mode = "location"
      }
    }
}

local luadev = require("lua-dev").setup()

--require'lspconfig'.sumneko_lua.setup(luadev)

---- lualine
require('lualine').setup{
    options = {
        component_separators = '┃',
        section_separators = { left = '', right = '' },
        theme = 'gruvbox'
    },
    sections = {
        lualine_a = {
            { 'mode', right_padding = 2 },
        },
        lualine_b = { {
            'filename',
            path = 3
        }, 'branch' },
        lualine_c = { 'fileformat' },
        lualine_x = {'diagnostics'},
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
            { 'location', left_padding = 2 },
        },
    },
}

---- autopairs
require('nvim-autopairs').setup{ map_cr = true }

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
--cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"

---- nvim-tree
-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
    return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {
        "startify",
        "dashboard",
        "alpha",
    },
    -- auto_close = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    --update_to_buf_dir = {
        --enable = true,
        --auto_open = true,
    --},
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 500,
    },
    view = {
        width = 30,
        --height = 30,
        hide_root_folder = false,
        side = "left",
        --auto_resize = true,
        mappings = {
            custom_only = false,
            list = {
                { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
                { key = "h", cb = tree_cb "close_node" },
                { key = "v", cb = tree_cb "vsplit" },
            },
        },
        number = false,
        relativenumber = false,
    },
    renderer = {
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    deleted = "",
                    untracked = "U",
                    ignored = "◌",
                },
                folder = {
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                },
            }
        }
    },
    --show_icons = {
        --git = 1,
        --folders = 1,
        --files = 1,
        --folder_arrows = 1,
        --tree_width = 30,
    --},
}

---- telescope
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key"
      }
    }
  },
}
require('telescope').load_extension('harpoon');
---- treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"typescript", "javascript", "lua", "cpp", "c", "java", "python"},

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    extended_mode = false,
    max_file_lines = nil,
  },
  autotag = {
      enable = true,
  }
}
