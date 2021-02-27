" General settings here
set backspace=indent,eol,start
set nocompatible
set spell spelllang=en_us
set clipboard=unnamed
set autoindent
set smartindent
set tabstop=4
set textwidth=72
set showmatch " identify open and close braces/quotes/etc
set hlsearch " highlight searched term
set incsearch " do incremental searches as you type
set laststatus=2 " display vim status bar

" Show empty whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Set comment strings for file types
autocmd FileType toml setlocal commentstring=#\ %s
autocmd FileType sh setlocal commentstring=#\ %s
autocmd FileType ruby setlocal commentstring=#\ %s
autocmd FileType yaml setlocal commentstring=#\ %s
autocmd FileType make setlocal commentstring=#\ %s

" Set indentation per file type
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab " 2 spaces for yaml
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab " 2 spaces for json
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab " 2 spaces for ruby
autocmd FileType erb setlocal ts=2 sts=2 sw=2 expandtab " 2 spaces for erb
autocmd FileType sh setlocal ts=4 sts=4 sw=4 expandtab " 4 spaces for bash
autocmd FileType markdown setlocal ts=4 sts=4 sw=4 expandtab " 4 spaces for markdown
autocmd FileType toml setlocal ts=2 sts=2 sw=2 expandtab " 2 spaces for toml
autocmd FileType mustache setlocal ts=2 sts=2 sw=2 expandtab " 2 spaces for mustache
autocmd FileType conf setlocal ts=4 sts=4 sw=4 expandtab " 4 spaces for powershell

" Set up nerdtree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1 " Show hidden files
let NERDTreeIgnore = ['\.swp$'] " Ignore swap files

" Color scheme
syntax enable
set background=dark
colorscheme solarized
hi Normal ctermbg=none
highlight NonText ctermbg=none

" Remove unwanted spaces
" https://vim.fandom.com/wiki/Remove_unwanted_spaces on save
autocmd BufWritePre * %s/\s\+$//e

" Run jq on a JSON file to be formatted automatically.
autocmd FileType json autocmd BufWritePre <buffer> %!jq

" Run terraform fmt on save
let g:terraform_fmt_on_save=1

" Show tabs and spaces
set list
set listchars=tab:>-

" Set up FZF
set rtp+=/usr/local/opt/fzf

"Mappings
" <ctrl-p>  to search files
nnoremap <silent> <C-p> :FZF -m<cr>

"""""""""""""""""""""""""""""""""""""""
" ack.vim
"""""""""""""""""""""""""""""""""""""""

" Use ripgrep for searching ⚡️
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
" --hidden -> Search inside of hidden files as well
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case --hidden'

" Auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" Maps <leader>/ so we're ready to type the search keyword
nnoremap <C-F> :Ack!<Space>
" }}}

" Navigate quickfix list with ease
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
