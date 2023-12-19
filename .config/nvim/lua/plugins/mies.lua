return {
	{
		"jaredgorski/Mies.vim",
		config = function()
			vim.cmd.colorscheme("mies")
			vim.o.background = "light"
			vim.o.termguicolors = true

			-- Set the SignColumn highlight group to white
			vim.cmd("highlight SignColumn guibg=white ctermbg=white")
		end,
	},
}
