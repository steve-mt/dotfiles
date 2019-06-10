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

" Set indentation per file type
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

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
