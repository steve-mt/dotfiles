runtime ./plug.vim

" General
set clipboard=unnamed " send yank to clipboard

" Color
set termguicolors
colorscheme NeoSolarized
set background=dark

" Keybindings
nnoremap <C-n> :NERDTreeToggle<CR>

" Run on save
autocmd FileType json autocmd BufWritePre <buffer> %!jq " run JSON files through jq

" NERDTree
let NERDTreeShowHidden=1
let NERDTreeIgnor = ['\.swap$']

