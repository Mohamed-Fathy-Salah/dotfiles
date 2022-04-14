return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use {
        'gruvbox-community/gruvbox',
        config = "vim.cmd('colorscheme gruvbox')"
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        -- event = "BufWinEnter",
        config = "require('treesitter-config')"
    }
    use {
        'hoob3rt/lualine.nvim',
        require = {'kyazdani42/nvim-web-devicons', opt = true},
        -- event = "BufWinEnter",
        config = "require('lualine-config')"
    }
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        require = {'kyazdani42/nvim-web-devicons'},
        -- event = "BufWinEnter",
        config = "require('bufferline-config')"
    }
    use {
        'kyazdani42/nvim-tree.lua',
        require = {'kyazdani42/nvim-web-devicons'},
        -- cmd = "NvimTreeToggle",
        config = "require('nvim-tree-config')"
    }
    use 'p00f/nvim-ts-rainbow'
    use {
        'windwp/nvim-autopairs',
        config = "require('nvim-autopairs-config')",
        -- after = "nvim-cmp"
    }
    use {
        'nvim-telescope/telescope.nvim',
        require = {'nvim-lua/plenary.nvim',},
        -- cmd = "Telescope",
        config = "require('telescope-config')"
    }
    use {
        'neovim/nvim-lspconfig',
        config = "require('lsp')"
    }
    use {
        'hrsh7th/cmp-nvim-lsp',
        -- after = "nvim-cmp"
    }
    use {
        'hrsh7th/cmp-buffer',
        -- after = "nvim-cmp"
    }
    use {
        'hrsh7th/cmp-path',
        -- after = "nvim-cmp"
    }
    use {
        'hrsh7th/cmp-cmdline',
        -- after = "nvim-cmp"
    }
    use {
        'hrsh7th/nvim-cmp',
        -- event = "InsertEnter"
    }
    use 'preservim/nerdcommenter'
end)

