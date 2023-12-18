return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "fb", ":Git blame<CR>", {})
		end,
	},
}
