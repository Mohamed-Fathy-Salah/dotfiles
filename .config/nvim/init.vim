call plug#begin('/home/mofasa/.local/share/nvim/plugged')
    Plug 'doums/darcula'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
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
    Plug 'dstein64/vim-startuptime'
call plug#end()

source /home/mofasa/.config/nvim/keymaps.vim
source /home/mofasa/.config/nvim/sets.vim
source /home/mofasa/.config/nvim/config.lua
