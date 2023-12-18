return {
	{
		"jaredgorski/Mies.vim",
		config = function()
			vim.cmd.colorscheme("mies")
			vim.o.background = "light"
			vim.o.termguicolors = true
		end,
	},
}
