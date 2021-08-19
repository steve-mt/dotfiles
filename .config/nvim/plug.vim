if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

  Plug 'preservim/nerdtree'

if has("nvim")
  Plug 'nvim-telescope/telescope.nvim'
endif

call plug#end()
