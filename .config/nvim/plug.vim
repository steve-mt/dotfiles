if has("nvim")
    let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

    Plug 'preservim/nerdtree'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'hashivim/vim-terraform'
    Plug 'tpope/vim-commentary'
    Plug 'dense-analysis/ale'
    Plug 'google/vim-jsonnet'

if has("nvim")
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    Plug 'overcache/NeoSolarized'
    Plug 'hoob3rt/lualine.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    " Plug 'glepnir/lspsaga.nvim'
    " Temporary fix issue with large screens https://github.com/glepnir/lspsaga.nvim/pull/207
    Plug 'jasonrhansen/lspsaga.nvim', {'branch': 'finder-preview-fixes'}
endif

call plug#end()
