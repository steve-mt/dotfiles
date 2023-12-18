local file_types = {
	yaml = {
		tabstop = 2,
		softtabstop = 2,
		shiftwidth = 2,
		expandtab = true,
	},
	lua = {
		tabstop = 2,
		softtabstop = 2,
		shiftwidth = 2,
		expandtab = true,
	},
	helm = {
		tabstop = 2,
		softtabstop = 2,
		shiftwidth = 2,
		expandtab = true,
	},
	jsonnet = {
		tabstop = 2,
		softtabstop = 2,
		shiftwidth = 2,
		expandtab = true,
	},
	tf = {
		tabstop = 2,
		softtabstop = 2,
		shiftwidth = 2,
		expandtab = true,
	},
	json = {
		tabstop = 2,
		softtabstop = 2,
		shiftwidth = 2,
		expandtab = true,
	},
	ruby = {
		tabstop = 2,
		softtabstop = 2,
		shiftwidth = 2,
		expandtab = true,
	},
	erb = {
		tabstop = 2,
		softtabstop = 2,
		shiftwidth = 2,
		expandtab = true,
	},
	sh = {
		tabstop = 2,
		softtabstop = 2,
		shiftwidth = 2,
		expandtab = true,
	},
	markdown = {
		tabstop = 4,
		softtabstop = 4,
		shiftwidth = 4,
		expandtab = true,
	},
	toml = {
		tabstop = 2,
		softtabstop = 2,
		shiftwidth = 2,
		expandtab = true,
	},
	mustache = {
		tabstop = 2,
		softtabstop = 2,
		shiftwidth = 2,
		expandtab = true,
	},
	conf = {
		tabstop = 4,
		softtabstop = 4,
		shiftwidth = 4,
		expandtab = true,
	},
}

for file_type, config in pairs(file_types) do
	vim.api.nvim_create_autocmd("FileType", {
		pattern = file_type,
		callback = function()
			vim.bo.tabstop = config.tabstop
			vim.bo.softtabstop = config.softtabstop
			vim.bo.shiftwidth = config.shiftwidth
			vim.bo.expandtab = config.expandtab
		end,
	})
end
