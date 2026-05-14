return {
	"polarmutex/git-worktree.nvim",
	version = "^2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{
			"<leader>gw",
			function()
				require("telescope").extensions.git_worktree.git_worktree()
			end,
			desc = "Git worktrees (switch/delete)",
		},
		{
			"<leader>gW",
			function()
				require("telescope").extensions.git_worktree.create_git_worktree()
			end,
			desc = "Git worktree (create)",
		},
	},
	config = function()
		local hooks = require("git-worktree.hooks")

		-- After switching, drop unmodified buffers that live outside the new tree.
		hooks.register(hooks.type.SWITCH, function(path, _prev_path)
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				local name = vim.api.nvim_buf_get_name(buf)
				if
					name ~= ""
					and not vim.startswith(name, path)
					and vim.api.nvim_buf_is_loaded(buf)
					and vim.bo[buf].buflisted
					and vim.bo[buf].buftype == ""
					and not vim.bo[buf].modified
				then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end
		end)

		require("telescope").load_extension("git_worktree")
	end,
}
