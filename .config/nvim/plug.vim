if has("nvim")
    let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'hashivim/vim-terraform'
    Plug 'tpope/vim-commentary'
    Plug 'dense-analysis/ale'
    Plug 'google/vim-jsonnet'
    Plug 'jjo/vim-cue'
    Plug 'tpope/vim-fugitive'

if has("nvim")
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    Plug 'Iron-E/nvim-soluarized'
    Plug 'hoob3rt/lualine.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'towolf/vim-helm'

    Plug 'neovim/nvim-lspconfig'

    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
endif

call plug#end()
