-- Initialize plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Basic functionality
vim.o.clipboard = 'unnamedplus'
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.completeopt = "menuone,noselect"

-- Mappings
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>n", vim.cmd.Ex)

-- Plugins
require("lazy").setup({
  -- Basic functionality
  "christoomey/vim-tmux-navigator",
  "tpope/vim-commentary",
  "dense-analysis/ale",
  "tpope/vim-fugitive",
  "tpope/vim-surround",
  {
    "nvim-telescope/telescope.nvim", tag = '0.1.1',
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  -- Visual
  "hoob3rt/lualine.nvim",
  "Iron-E/nvim-soluarized",

  -- Langugage Specific tools
  "hashivim/vim-terraform",
  "google/vim-jsonnet",
  "towolf/vim-helm",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
    },
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },
})
