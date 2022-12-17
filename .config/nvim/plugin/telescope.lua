local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-F>', builtin.live_grep, {})
vim.keymap.set('n', '<C-t>', builtin.lsp_document_symbols, {})

local telescope = require('telescope')

telescope.setup({
  pickers = {
    find_files = {
      hidden = true,
    }
  }
})
