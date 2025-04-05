return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<C-p>", builtin.find_files, {})
		vim.keymap.set("n", "<C-F>", builtin.live_grep, {})
		vim.keymap.set("n", "<C-s>", builtin.buffers, {})

		local telescope = require("telescope")

		telescope.setup({
			pickers = {
				find_files = {
					find_command = { "fd", "--hidden" },
				},
				live_grep = {
					additional_args = { "--hidden" },
				},
			},
		})
	end,
}
