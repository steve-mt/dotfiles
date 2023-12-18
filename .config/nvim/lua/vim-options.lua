-- Basic functionality
vim.o.clipboard = "unnamedplus"
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.completeopt = "menuone,noselect"

-- Mappings
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>n", vim.cmd.Ex)
