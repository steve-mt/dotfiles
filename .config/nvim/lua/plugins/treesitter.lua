return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
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
					"jsonnet",
					"javascript",
					"terraform",
				},

				highlight = {
					enable = true,
					custom_captures = {},
				},

				indent = {
					enable = true,
				},
			})
		end,
	},
}
