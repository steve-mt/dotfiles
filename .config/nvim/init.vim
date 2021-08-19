runtime ./plug.vim

" General
set clipboard=unnamed " send yank to clipboard

" Color
set termguicolors
colorscheme NeoSolarized
set background=dark

" Keybindings
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-F> <cmd>Telescope live_grep<cr>

" Run on save
autocmd FileType json autocmd BufWritePre <buffer> %!jq " run JSON files through jq
autocmd BufWritePre * %s/\s\+$//e " Remove unwanted spaces https://vim.fandom.com/wiki/Remove_unwanted_spaces
let g:terraform_fmt_on_save=1

" Indentation
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType tf setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType erb setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sh setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType markdown setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType toml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType mustache setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType conf setlocal ts=4 sts=4 sw=4 expandtab

" NERDTree
let NERDTreeShowHidden=1
let NERDTreeIgnor = ['\.swap$']
