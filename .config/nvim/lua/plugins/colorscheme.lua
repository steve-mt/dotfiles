return {
	"jackplus-xyz/binary.nvim",
	priority = 1000,
	opts = {
		style = "light",
		colors = {
			fg = "#080808",
			bg = "#ffffff",
		},
		-- These groups will have reversed colors (bg becomes fg, fg becomes bg)
		-- for better visibility on important UI elements
		reversed_group = {
			-- Editor UI
			Cursor = true,
			IncSearch = true,
			MatchParen = true,
			PmenuSel = true,
			Search = true,
			Visual = true,
			-- LSP
			LspReferenceText = true,
			LspReferenceRead = true,
			LspReferenceWrite = true,
			-- Telescope
			TelescopeSelection = true,
		},
	},
	config = function(_, opts)
		require("binary").setup(opts)
		vim.cmd("colorscheme binary")
	end,
}
