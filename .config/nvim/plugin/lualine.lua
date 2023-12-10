require("lualine").setup({
	options = {
		icons_enabled = false,
		theme = "onelight",
		component_separators = { "", "" },
		section_separators = { "", "" },
		disabled_filetypes = {},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { {
			"filename",
			path = 1,
		} },
		lualine_c = {},
		lualine_x = { "filetype" },
		lualine_y = {},
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = { {
			"filename",
			path = 1,
		} },
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	extensions = {},
})
