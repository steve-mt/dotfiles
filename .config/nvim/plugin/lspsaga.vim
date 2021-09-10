nnoremap <silent> gr :Lspsaga lsp_finder<CR>
nnoremap <silent> <leader>k <cmd>lua :Lspsaga signature_help<CR>
nnoremap <silent> <leader>r :Lspsaga rename<CR>
nnoremap <silent> <leader>gd :Lspsaga preview_definition<CR>

" Hover Doc
nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent> <C-J> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-K> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

" Code action
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
