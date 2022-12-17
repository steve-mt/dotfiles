local builtin = require('telescope.builtin')

vim.keymap.set('n', 'gr', builtin.lsp_references, {})
vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
vim.keymap.set('n', 'gi', builtin.lsp_implementations, {})
vim.keymap.set('n', '<C-t>', builtin.lsp_document_symbols, {})

vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, {})
vim.keymap.set('n', 'ge', vim.lsp.buf.rename, {})
vim.keymap.set('n', '<C-n>', vim.diagnostic.goto_next, {})
vim.keymap.set('n', '<C-N>', vim.diagnostic.goto_prev, {})
