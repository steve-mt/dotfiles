runtime ./plug.vim

" General
set clipboard=unnamed " send yank to clipboard
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Color
set termguicolors
colorscheme NeoSolarized
set background=dark

" Keybindings
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-F> <cmd>Telescope live_grep<cr>

" Run on save
" Run json files through jq
autocmd FileType json autocmd BufWritePre <buffer> %!jq
" Remove unwanted spaces https://vim.fandom.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * %s/\s\+$//e
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

"""""""""
" Plugins
""""""""""
" preservim/nerdtree
let NERDTreeShowHidden=1
let NERDTreeIgnor = ['\.swap$']

" tpope/vim-commentary
autocmd FileType toml setlocal commentstring=#\ %s
autocmd FileType sh setlocal commentstring=#\ %s
autocmd FileType ruby setlocal commentstring=#\ %s
autocmd FileType yaml setlocal commentstring=#\ %s
autocmd FileType make setlocal commentstring=#\ %s

" dense-analysis/ale
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'
