nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>k <cmd>lua vim.lsp.buf.signature_help()<CR>

nnoremap <silent> gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <silent> gd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap <silent> gi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gs <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> ge <cmd>lua vim.lsp.buf.rename()<CR>

nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
