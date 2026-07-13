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
    -- kept loading so bufferline/lualine still have icons after nvim-tree is disabled
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons", "nvim-neotest/nvim-nio" },
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
                vim.keymap.set("n", "y", function()
                    vim.ui.select(
                        { "Filename", "Basename", "Relative Path", "Absolute Path" },
                        { prompt = "Copy what?" },
                        function(choice)
                            if choice == "Filename" then
                                api.fs.copy.filename()
                            elseif choice == "Basename" then
                                api.fs.copy.basename()
                            elseif choice == "Relative Path" then
                                api.fs.copy.relative_path()
                            elseif choice == "Absolute Path" then
                                api.fs.copy.absolute_path()
                            end
                        end
                    )
                end, opts("Copy Path"))
                vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
                vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
                vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
                vim.keymap.set("n", "<leader>h", api.tree.toggle_help, opts("Help"))
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
        enabled = false,
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-live-grep-args.nvim" },
        config = function()
            local lga_actions = require("telescope-live-grep-args.actions")
            local action_state = require("telescope.actions.state")
            local actions = require("telescope.actions")

            -- close current picker, open the other, carry the prompt text over
            local function to_find_files(prompt_bufnr)
                local text = action_state.get_current_line()
                actions.close(prompt_bufnr)
                require("telescope.builtin").find_files({ default_text = text })
            end
            local function to_live_grep(prompt_bufnr)
                local text = action_state.get_current_line()
                actions.close(prompt_bufnr)
                require("telescope").extensions.live_grep_args.live_grep_args({ default_text = text })
            end

            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = {
                            ["<C-h>"] = "which_key",
                            ["<S-Tab>"] = to_live_grep,
                        },
                        n = {
                            ["<S-Tab>"] = to_live_grep,
                        },
                    }
                },
                extensions = {
                    live_grep_args = {
                        auto_quoting = true,
                        mappings = {
                            i = {
                                -- quote current prompt so you can append rg flags
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                -- prefill a glob filter: type the file pattern after --glob=
                                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob **/" }),
                                ["<S-Tab>"] = to_find_files,
                            },
                            n = {
                                ["<S-Tab>"] = to_find_files,
                            },
                        },
                    },
                },
            }
            require('telescope').load_extension('live_grep_args')
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require('lualine').setup {
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
                    lualine_x = { 'diagnostics' },
                    lualine_y = { 'filetype', 'progress' },
                    lualine_z = {
                        { 'location', left_padding = 2 },
                    },
                },
            }
        end,
    },
    {
        "saghen/blink.cmp",
        version = "*",
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = {
            keymap = {
                preset = "super-tab",
                ["<CR>"] = { "accept", "fallback" },
                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            },
            completion = {
                list = { selection = { preselect = false, auto_insert = true } },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            cmdline = {
                keymap = {
                    preset = "cmdline",
                    -- move selection, insert into cmdline, keep menu open
                    ["<Tab>"] = { "show", "select_next", "fallback" },
                    ["<S-Tab>"] = { "show", "select_prev", "fallback" },
                    ["<CR>"] = { "accept", "fallback" },
                },
                completion = {
                    menu = { auto_show = true },
                    list = { selection = { preselect = false, auto_insert = true } },
                },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
        config = function(_, opts)
            require("blink.cmp").setup(opts)

            local signs = { Error = "", Warn = "", Hint = "", Info = "" }
            -- nvim 0.10+ reads sign icons from vim.diagnostic.config, not sign_define
            local S = vim.diagnostic.severity
            vim.diagnostic.config({
                signs = {
                    text = {
                        [S.ERROR] = signs.Error,
                        [S.WARN]  = signs.Warn,
                        [S.HINT]  = signs.Hint,
                        [S.INFO]  = signs.Info,
                    },
                    numhl = {
                        [S.ERROR] = "DiagnosticSignError",
                        [S.WARN]  = "DiagnosticSignWarn",
                        [S.HINT]  = "DiagnosticSignHint",
                        [S.INFO]  = "DiagnosticSignInfo",
                    },
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            require("mason").setup()

            -- global defaults applied to every server (nvim 0.11+ native config)
            vim.lsp.config("*", { capabilities = capabilities })

            vim.lsp.config("ts_ls", {
                capabilities = capabilities,
                filetypes = {
                    "javascript", "javascriptreact", "typescript",
                    "typescriptreact", "typescript.tsx", "vue",
                },
                root_markers = { "tsconfig.json", "package.json", ".git" },
            })

            vim.lsp.config("pyright", {
                capabilities = capabilities,
                settings = { python = { venvPath = ".", venv = "venv" } },
            })

            vim.lsp.config("gopls", {
                capabilities = capabilities,
                root_markers = { "go.work", "go.mod" },
            })

            vim.lsp.config("ruby_lsp", {
                capabilities = capabilities,
                cmd = {
                    "/home/mofasa/.rbenv/versions/3.3.5/bin/ruby",
                    "/home/mofasa/.rbenv/versions/3.3.5/bin/ruby-lsp",
                },
                cmd_env = {
                    GEM_HOME = "/home/mofasa/.rbenv/versions/3.3.5/lib/ruby/gems/3.3.0",
                    GEM_PATH = "/home/mofasa/.rbenv/versions/3.3.5/lib/ruby/gems/3.3.0",
                    PATH = "/home/mofasa/.rbenv/versions/3.3.5/bin:/usr/bin:/bin",
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = { "html", "cssls", "gopls", "ts_ls" },
                -- v2 auto-enables installed servers via vim.lsp.enable,
                -- merging the vim.lsp.config overrides above
            })
        end,
    },
    {
        "seblyng/roslyn.nvim",
        ft = { "cs" },
        dependencies = { "saghen/blink.cmp" },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            local roslyn_dll = vim.fn.expand("$HOME/.local/share/roslyn-ls/Microsoft.CodeAnalysis.LanguageServer.dll")
            vim.lsp.config("roslyn", {
                capabilities = capabilities,
                cmd = {
                    "dotnet",
                    roslyn_dll,
                    "--logLevel=Information",
                    "--extensionLogDirectory=" .. vim.fn.stdpath("log") .. "/roslyn",
                    "--stdio",
                },
            })
            require("roslyn").setup({})
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require('nvim-autopairs').setup { map_cr = true }
        end,
    },
    {
        "akinsho/bufferline.nvim",
        config = function()
            require("bufferline").setup {}
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup {}
        end,
    },
    {
        "preservim/nerdcommenter",
    },
    {
        "RRethy/vim-illuminate",
        enabled = false,
        config = function()
            require("illuminate").configure {
                under_cursor = true,                                  -- Underline the word under the cursor
            }
            vim.cmd([[highlight IlluminatedWordText gui=underline]])  -- Set underline color
            vim.cmd([[highlight IlluminatedWordRead gui=underline]])  -- Set underline color for read
            vim.cmd([[highlight IlluminatedWordWrite gui=underline]]) -- Set underline color for write
        end,
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
            "theHamsta/nvim-dap-virtual-text",
            "jay-babu/mason-nvim-dap.nvim", -- optional helper
        },
        config = function()
            require("mason").setup()
            require("mason-nvim-dap").setup({
                ensure_installed = { "delve", "netcoredbg", "codelldb" },
                automatic_installation = true,
                handlers = {}, -- let mason-nvim-dap wire default adapters/configs
            })
            require("nvim-dap-virtual-text").setup()

            -- dap reads these signs via sign_define directly
            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", numhl = "" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticSignWarn", numhl = "" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "*", texthl = "DiagnosticSignHint", numhl = "" })
            vim.fn.sign_define("DapLogPoint", { text = "󰽷", texthl = "DiagnosticSignInfo", numhl = "" })
            vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticSignInfo", linehl = "debugPC", numhl = "" })

            local dap = require("dap")

            -- Adapters below are handled by mason-nvim-dap default handlers.
            -- Uncomment only if a default misbehaves and you need to override.
            -- dap.adapters.coreclr = {
            --     type = "executable",
            --     command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
            --     args = { "--interpreter=vscode" },
            -- }

            -- codelldb is a server-type adapter, not cppdbg
            -- dap.adapters.codelldb = {
            --     type = "server",
            --     port = "${port}",
            --     executable = {
            --         command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
            --         args = { "--port", "${port}" },
            --     },
            -- }

            dap.configurations.cpp = {
                {
                    name = "Launch (codelldb)",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = true, -- pause immediately so UI stays open
                },
            }
            dap.configurations.c = dap.configurations.cpp

            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated["dapui_config"] = dapui.close
            dap.listeners.before.event_exited["dapui_config"] = dapui.close

            vim.keymap.set("n", "<F5>", dap.continue)
            vim.keymap.set("n", "<F6>", function()
                dap.set_exception_breakpoints({ "all" })
                dap.continue()
            end)
        end,
    },
    {
        'Wansmer/symbol-usage.nvim',
        event = 'LspAttach',
        config = function()
            require('symbol-usage').setup()
        end
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
        ft = { "markdown" },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_browser = "chromium"
        end,
    },
    {
        "carlos-algms/agentic.nvim",
        enabled = true,
        dependencies = { "hakonharnes/img-clip.nvim" },

        opts = {
            -- Available by default: "claude-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "auggie-acp" | "mistral-vibe-acp"
            provider = "claude-agent-acp", -- setting the name here is all you need to get started
        },

        -- these are just suggested keymaps; customize as desired
        keys = {
            {
                "<F2>",
                function() require("agentic").toggle() end,
                mode = { "n", "i" },
                desc = "Toggle Agentic Chat"
            },
            {
                "<F2>",
                function() require("agentic").add_selection() end,
                mode = { "v" },
                desc = "Add file or selection to Agentic to Context"
            },
            {
                "<leader><F2>",
                function() require("agentic").new_session() end,
                mode = { "n" },
                desc = "New Agentic Session"
            },
            {
                "<F14>",
                function() require("agentic").restore_session() end,
                desc = "Agentic Restore session",
                silent = true,
                mode = { "n", "v", "i" },
            },
            {
                "<c-c>",
                function() require("agentic").stop_generation() end,
                desc = "stop Agentic Agent",
                ft = { "AgenticInput", "AgenticFiles", "AgenticCode", "AgenticChat" },
                mode = { "n", "i" },
            },
            {
                "gf",
                function()
                    -- nvim's <cfile> strips :line suffix, <cWORD> has the raw text
                    local cfile = vim.fn.expand("<cfile>")
                    if cfile == "" then return end
                    local line = vim.fn.expand("<cWORD>"):match(":(%d+)")
                    local cur = vim.api.nvim_get_current_win()
                    local target
                    for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                        if w ~= cur and not vim.wo[w].winfixbuf then
                            target = w
                            break
                        end
                    end
                    if not target then
                        vim.cmd("vsplit")
                        target = vim.api.nvim_get_current_win()
                    end
                    vim.api.nvim_set_current_win(target)
                    vim.cmd("drop " .. vim.fn.fnameescape(cfile))
                    if line then
                        vim.cmd(":" .. line)
                        vim.cmd("normal! zz")
                    end
                end,
                desc = "Open file:line in other window",
                ft = { "AgenticInput", "AgenticFiles", "AgenticCode", "AgenticChat" },
                mode = { "n" },
            }
        },

        config = function(_, opts)
            require("agentic").setup(opts)
        end,
    },
    {
        "coder/claudecode.nvim",
        enabled = false,
        dependencies = { "folke/snacks.nvim" },

        opts = {},

        keys = {
            {
                "<F2>",
                "<cmd>ClaudeCode<cr>",
                mode = { "n", "i" },
                desc = "Toggle Claude Code"
            },
            {
                "<F2>",
                "<cmd>ClaudeCodeSend<cr>",
                mode = { "v" },
                desc = "Send selection to Claude Code"
            },
            {
                "<leader><F2>",
                "<cmd>ClaudeCode<cr>",
                mode = { "n" },
                desc = "New Claude Code Session"
            },
            {
                "<F14>",
                "<cmd>ClaudeCode --resume<cr>",
                desc = "Claude Code Resume session",
                silent = true,
                mode = { "n", "v", "i" },
            },
            {
                "<c-c>",
                "<cmd>ClaudeCodeStop<cr>",
                desc = "Stop Claude Code",
                ft = { "claudecode_terminal", "snacks_terminal" },
                mode = { "n", "i" },
            },
            {
                "<S-Tab>",
                function() vim.api.nvim_feedkeys("\27[Z", "t", false) end,
                desc = "Claude Code switch mode",
                ft = { "claudecode_terminal", "snacks_terminal" },
                mode = { "t" },
            },
            {
                "gf",
                function()
                    -- nvim's <cfile> strips :line suffix, <cWORD> has the raw text
                    local cfile = vim.fn.expand("<cfile>")
                    if cfile == "" then return end
                    local line = vim.fn.expand("<cWORD>"):match(":(%d+)")
                    local cur = vim.api.nvim_get_current_win()
                    local target
                    for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                        if w ~= cur and not vim.wo[w].winfixbuf then
                            target = w
                            break
                        end
                    end
                    if not target then
                        vim.cmd("vsplit")
                        target = vim.api.nvim_get_current_win()
                    end
                    vim.api.nvim_set_current_win(target)
                    vim.cmd("drop " .. vim.fn.fnameescape(cfile))
                    if line then
                        vim.cmd(":" .. line)
                        vim.cmd("normal! zz")
                    end
                end,
                desc = "Open file:line in other window",
                mode = { "n" },
            }
        },

        config = function(_, opts)
            require("claudecode").setup(opts)
            vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
                pattern = "*",
                callback = function()
                    local ft = vim.bo.filetype
                    if ft == "claudecode_terminal" or ft == "snacks_terminal" then
                        vim.cmd("startinsert")
                    end
                end,
            })
        end,
    },
    {
        "folke/which-key.nvim",
        enabled = false,
        event = "VeryLazy",
        opts = {}
    },
    {
        "folke/trouble.nvim",
        opts = {
            auto_jump = false
        }, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        enabled = true,
        keys = {
            {
                "<leader>tt",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>tq",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
            {
                "<leader>te",
                "<cmd>Trouble diagnostics filter.severity=vim.diagnostic.severity.ERROR<cr>",
                desc = "Show Error Diagnostics (Trouble)",
            },
            {
                "<leader>tw",
                "<cmd>Trouble diagnostics filter.severity=vim.diagnostic.severity.WARN<cr>",
                desc = "Show Warning Diagnostics (Trouble)",
            },
            {
                "<leader>ti",
                "<cmd>Trouble diagnostics filter.severity=vim.diagnostic.severity.INFO<cr>",
                desc = "Show Info Diagnostics (Trouble)",
            },
            {
                "<leader>th",
                "<cmd>Trouble diagnostics filter.severity=vim.diagnostic.severity.HINT<cr>",
                desc = "Show Hint Diagnostics (Trouble)",
            },
        },
    },
    { 'stevearc/conform.nvim',       opts = {}, },
    {
        'mfussenegger/nvim-lint',
        dependencies = {
            'mason-org/mason.nvim',
            'rshkarin/mason-nvim-lint',
        },
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local lint = require('lint')
            lint.linters_by_ft = {
                go = { 'golangcilint' },
                ruby = { 'rubocop' },
            }
            -- auto-installs the above via Mason, then registers them
            require('mason-nvim-lint').setup()

            vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            file_types = { "markdown", "Avante", "AgenticChat" }
        },
        ft = { "markdown", "Avante", "AgenticChat" }
    },
    {
        "3rd/image.nvim",
        enabled = true,
        opts = {
            backend = "sixel",
            max_width_window_percentage = 100,
            max_height_window_percentage = 100,
            hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif", "*.bmp", "*.ico", "*.svg" },
        },
        init = function()
            -- Clear image.nvim cache on BufEnter to force re-render changed images
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif", "*.bmp", "*.ico", "*.svg" },
                callback = function()
                    local ok, image = pcall(require, "image")
                    if ok then
                        image.clear()
                    end
                end,
            })
        end,
    },
    {
        "folke/snacks.nvim",
        opts = {
            bigfile = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            words = { enabled = true, debounce = 100 },
            explorer = { enabled = true, replace_netrw = true },
            picker = {
                enabled = false,
                ui_select = true,
                sources = {
                    explorer = {
                        hidden = true,      -- show dotfiles
                        ignored = true,     -- show git-ignored (nvim-tree git.ignore = false)
                        follow_file = true, -- update_focused_file
                        auto_close = false,
                        diagnostics = true,
                        git_status = true,
                        win = {
                            list = {
                                wo = { number = true, relativenumber = true },
                                keys = {
                                    ["l"] = "confirm",         -- open
                                    ["h"] = "explorer_close",  -- close dir
                                    ["v"] = "edit_vsplit",     -- open in vertical split
                                    ["-"] = "explorer_up",     -- root -> parent
                                    ["a"] = "explorer_add",    -- create file/dir
                                    ["c"] = "explorer_copy",   -- mark for copy
                                    ["d"] = "explorer_del",    -- delete
                                    ["e"] = "explorer_rename", -- rename (no basename-only variant)
                                    ["r"] = "explorer_rename", -- rename
                                    ["p"] = "explorer_paste",  -- paste
                                    ["x"] = "explorer_move",   -- move (cut+paste equivalent)
                                    ["S"] = "picker_grep",     -- grep in tree dir
                                    ["y"] = "yank_path_menu",  -- copy path (menu)
                                    ["<leader>h"] = "toggle_help",
                                },
                            },
                        },
                        actions = {
                            -- replicate nvim-tree's "y" copy-path chooser
                            yank_path_menu = function(picker)
                                local item = picker:current()
                                if not item or not item.file then return end
                                local path = vim.fn.fnamemodify(item.file, ":p")
                                vim.ui.select(
                                    { "Filename", "Basename", "Relative Path", "Absolute Path" },
                                    { prompt = "Copy what?" },
                                    function(choice)
                                        local val
                                        if choice == "Filename" then
                                            val = vim.fn.fnamemodify(path, ":t")
                                        elseif choice == "Basename" then
                                            val = vim.fn.fnamemodify(path, ":t:r")
                                        elseif choice == "Relative Path" then
                                            val = vim.fn.fnamemodify(path, ":.")
                                        elseif choice == "Absolute Path" then
                                            val = path
                                        end
                                        if val then
                                            vim.fn.setreg("+", val)
                                            vim.notify("Copied: " .. val, vim.log.levels.INFO)
                                        end
                                    end
                                )
                            end,
                        },
                    },
                },
                win = {
                    input = {
                        keys = {
                            -- toggle between files <-> grep, carrying the typed text over
                            ["<S-Tab>"] = { "toggle_files_grep", mode = { "i", "n" } },
                            -- grep only: filter results by rg glob / by directory
                            ["<C-g>"] = { "grep_set_glob", mode = { "i", "n" } },
                            ["<C-d>"] = { "grep_set_dirs", mode = { "i", "n" } },
                            -- scroll the preview window
                            ["J"] = { "preview_scroll_down", mode = { "n" } },
                            ["K"] = { "preview_scroll_up", mode = { "n" } },
                        },
                    },
                },
                actions = {
                    toggle_files_grep = function(picker)
                        local flt = picker.input.filter
                        local text = (flt.search ~= "" and flt.search) or flt.pattern or ""
                        local src = picker.opts.source
                        picker:close()
                        if src == "grep" then
                            Snacks.picker.files({ pattern = text })
                        else
                            Snacks.picker.grep({ search = text })
                        end
                    end,
                    -- re-open grep, keeping the current search, scoped to an rg --glob
                    grep_set_glob = function(picker)
                        if picker.opts.source ~= "grep" then return end
                        local search = picker.input.filter.search or ""
                        vim.ui.input({ prompt = "rg glob (e.g. *.go, !*_test.go): " }, function(g)
                            if not g or g == "" then return end
                            picker:close()
                            Snacks.picker.grep({ search = search, glob = vim.split(g, "%s+") })
                        end)
                    end,
                    -- re-open grep, keeping the current search, scoped to dir(s)
                    grep_set_dirs = function(picker)
                        if picker.opts.source ~= "grep" then return end
                        local search = picker.input.filter.search or ""
                        vim.ui.input({ prompt = "dirs (space-separated): ", completion = "dir" }, function(d)
                            if not d or d == "" then return end
                            picker:close()
                            Snacks.picker.grep({ search = search, dirs = vim.split(d, "%s+") })
                        end)
                    end,
                },
            },
            lazygit = {
                enabled = true,
                win = {
                    wo = {
                        winhighlight = "NormalFloat:Normal,FloatBorder:Normal",
                    },
                },
            },
            notifier = {
                enabled = true,
                --timeout = 3000,
                --style = "fade",
                --top_down = false,
                width = { max = 80 },
            },
        },
        config = function(_, opts)
            require("snacks").setup(opts)
            for _, g in ipairs({ "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }) do
                vim.api.nvim_set_hl(0, g, { underline = true })
            end
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({
                "go", "python", "c_sharp", "cpp", "rust",
                "javascript", "typescript", "bash", "json", "yaml",
            })
        end,
    },
})
