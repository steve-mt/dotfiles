require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "rust",
    "go",
    "gomod",
    "gowork",
    "make",
    "yaml",
    "dockerfile",
    "hcl",
    "json",
    "lua",
    "toml",
    "ruby",
    "vim",
  },

  highlight = {
    enable = true,
    custom_captures = {
    },
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  indent = {
    enable = true
  }
}
