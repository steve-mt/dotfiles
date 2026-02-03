return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<leader>lg",
			function()
				vim.env.NO_COLOR = nil
				vim.cmd("LazyGit")
			end,
			desc = "LazyGit",
		},
	},
}
