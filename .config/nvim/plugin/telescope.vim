nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files({hidden = true})<cr>
nnoremap <C-F> <cmd>Telescope live_grep<cr>

nnoremap <C-t> <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
