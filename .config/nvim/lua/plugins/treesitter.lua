return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"go",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"ruby",
				"rust",
				"yaml",
				"json",
				"typescript",
				"javascript",
				"hcl",
			},
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
