require("lazy").setup({
    opts = {
        rocks = {
            enabled = false,
            hererocks = false
        },
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme gruvbox]])
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons", "miversen33/nvim-nio" },
        config = function()
            local status_ok, nvim_tree = pcall(require, "nvim-tree")

            local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")

            local function on_attach(bufnr)
                local api = require("nvim-tree.api")

                local function opts(desc)
                    return {
                        desc = "nvim-tree: " .. desc,
                        buffer = bufnr,
                        noremap = true,
                        silent = true,
                        nowait = true,
                    }
                end

                vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
                vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
                vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
                vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
                vim.keymap.set("n", "a", api.fs.create, opts("Create File Or Directory"))
                vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
                vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
                vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
                vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
                vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
                vim.keymap.set("n", "y", api.fs.copy.basename, opts("Copy Basename"))
                vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
                vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
                vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
                vim.keymap.set("n", "gh", api.tree.toggle_help, opts("Help"))
            end

            nvim_tree.setup({
                disable_netrw = true,
                hijack_netrw = true,
                hijack_cursor = false,
                update_cwd = true,
                diagnostics = {
                    enable = true,
                },
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                },
                git = {
                    enable = true,
                    ignore = false,
                    timeout = 500,
                },
                on_attach = on_attach,
                view = {
                    number = true,
                    relativenumber = true,
                },
                renderer = {
                    indent_markers = {
                        enable = true,
                        icons = {
                            item = "├",
                        },
                    },
                    icons = {
                        show = {
                            folder_arrow = false,
                        },
                        padding = "",
                        glyphs = {
                            default = " ",
                            symlink = " ",
                            modified = "● ",
                            folder = {
                                default = " ",
                                open = " ",
                                empty = " ",
                                empty_open = " ",
                                symlink = " ",
                                symlink_open = " ",
                            },
                        },
                    },
                },
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "ahmedkhalf/project.nvim" },
        config = function()
            require('telescope').load_extension('projects')
            require('telescope').setup{
                defaults = {
                    mappings = {
                        i = {
                            ["<C-h>"] = "which_key"
                        }
                    }
                }
            }
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
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
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/vim-vsnip",
            {
                "MattiasMTS/cmp-dbee",
                dependencies = {
                    {"kndndrj/nvim-dbee"}
                },
                ft = "sql", -- optional but good to have
                opts = {}, -- needed
            },
        },
        config = function()
            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local feedkey = function(key, mode)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
            end

            local cmp = require('cmp')
            cmp.setup {
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = {
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif vim.fn["vsnip#available"](1) == 1 then
                            feedkey("<Plug>(vsnip-expand-or-jump)", "")
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                            feedkey("<Plug>(vsnip-jump-prev)", "")
                        end
                    end, { "i", "s" }),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' },
                    { name = 'cmp-dbee' },
                }, {
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'cmdline' },
                })
            }

            cmp.setup.cmdline(':', {
                sources = cmp.config.sources({
                    { name = 'cmdline' },
                    { name = 'path' },
                })
            })

            cmp.setup.cmdline('/', {
                sources = {
                    { name = 'buffer' }
                }
            })

            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/vim-vsnip",
            --"jose-elias-alvarez/null-ls.nvim"
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

            lspconfig.omnisharp.setup { 
                capabilities = capabilities,
                cmd = {"dotnet", "/usr/lib/omnisharp-roslyn/OmniSharp.dll" },
                filetypes = {"cs", "csproj", "sln"},
                autostart = true,
            }

            lspconfig.html.setup { capabilities = capabilities }
            lspconfig.cssls.setup { capabilities = capabilities }

            --local null_ls = require("null-ls")
            --null_ls.setup({
                --sources = {
                    --null_ls.builtins.diagnostics.eslint,
                    --null_ls.builtins.code_actions.eslint,
                    --null_ls.builtins.formatting.prettier,
                --},
            --})

            --lspconfig.clangd.setup { capabilities = capabilities }
            --lspconfig.pyright.setup{ capabilities = capabilities }
            --lspconfig.rust_analyzer.setup{ capabilities = capabilities }

            lspconfig.ts_ls.setup{
                capabilities = capabilities,
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "javascript.jsx",
                    "typescript",
                    "typescriptreact",
                    "typescript.tsx",
                    "vue",
                },
                root_dir = require('lspconfig.util').root_pattern('tsconfig.json', 'jsconfig.json', 'package.json', '.git'),
                single_file_support = true,
            }
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require('nvim-autopairs').setup { map_cr = true }
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = {"typescript", "javascript", "lua", "cpp", "c", "java", "python", "c_sharp", "sql"},
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
                },
            }
        end,
    },
    {
        "akinsho/bufferline.nvim",
        config = function()
            require("bufferline").setup{}
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup{}
        end,
    },
    {
        "preservim/nerdcommenter",
    },
    {
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure{
                under_cursor = true, -- Underline the word under the cursor
            }
            vim.cmd([[highlight IlluminatedWordText gui=underline]]) -- Set underline color
            vim.cmd([[highlight IlluminatedWordRead gui=underline]]) -- Set underline color for read
            vim.cmd([[highlight IlluminatedWordWrite gui=underline]]) -- Set underline color for write
        end,
    },
    {
        "github/copilot.vim",
        enabled = false,
        config = function()
            vim.g.copilot_no_tab_map = true
            vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept()', { expr = true, silent = true })
        end,
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            dap.adapters.coreclr = {
                type = "executable",
                command = "/usr/bin/netcoredbg",
                args = { "--interpreter=vscode" },
            }

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "Launch",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/bin/Debug/net9.0/", "file")
                    end,
                    env = {
                        ASPNETCORE_ENVIRONMENT = "Development",
                    },
                },
            }
        end,
    },
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {}
        end,
    },
    {
        "kndndrj/nvim-dbee",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        build = function()
            require("dbee").install()
        end,
        config = function()
            require("dbee").setup()
        end,
    },
    {
        'VidocqH/lsp-lens.nvim',
        event = 'BufReadPre',
        config = function()
            require('lsp-lens').setup({})
        end
    }
})
