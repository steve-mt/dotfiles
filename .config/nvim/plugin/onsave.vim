" Run json files through jq
autocmd FileType json autocmd BufWritePre <buffer> %!jq
" Remove unwanted spaces https://vim.fandom.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * %s/\s\+$//e
