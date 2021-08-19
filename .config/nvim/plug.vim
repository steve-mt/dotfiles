if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

  Plug 'preservim/nerdtree'
  Plug 'christoomey/vim-tmux-navigator'

if has("nvim")
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'overcache/NeoSolarized'
endif

call plug#end()
