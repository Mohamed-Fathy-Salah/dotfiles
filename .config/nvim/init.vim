call plug#begin('/home/mofasa/.local/share/nvim/plugged')
    Plug 'doums/darcula'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-context'
    Plug 'hoob3rt/lualine.nvim',
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'p00f/nvim-ts-rainbow'
    Plug 'windwp/nvim-autopairs'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'preservim/nerdcommenter'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'norcalli/nvim-colorizer.lua',
    Plug 'lewis6991/gitsigns.nvim',
    Plug 'mfussenegger/nvim-dap',
    Plug 'theHamsta/nvim-dap-virtual-text',
    "Plug 'dstein64/vim-startuptime',
    "Plug 'RishabhRD/popfix',
    "Plug 'Mohamed-Fathy-Salah/nvim-cheat.sh',
    Plug 'dcampos/nvim-snippy',
    Plug 'folke/lua-dev.nvim',
    Plug 'jose-elias-alvarez/null-ls.nvim',
    Plug 'jose-elias-alvarez/nvim-lsp-ts-utils',
    "Plug 'diepm/vim-rest-console'
    Plug 'windwp/nvim-ts-autotag',
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } },
    Plug 'ThePrimeagen/harpoon',
    Plug 'RRethy/vim-illuminate',
    Plug 'MunifTanjim/nui.nvim'
    Plug 'jackMort/ChatGPT.nvim',
call plug#end()

source /home/mofasa/.config/nvim/keymaps.vim
source /home/mofasa/.config/nvim/sets.vim
source /home/mofasa/.config/nvim/config.lua
