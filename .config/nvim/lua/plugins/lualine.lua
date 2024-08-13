return {
	{
		"hoob3rt/lualine.nvim",
		config = function()
			local theme = require("lualine.themes.onelight")
			theme.normal.a.bg = "#f0f0f0"
			theme.normal.a.fg = "#494b53"
			theme.normal.b.bg = "#f0f0f0"
			theme.command.a.bg = "#f0f0f0"
			theme.command.a.fg = "#494b53"
			theme.visual.a.bg = "#f0f0f0"
			theme.visual.a.fg = "#494b53"
			theme.replace.a.bg = "#f0f0f0"
			theme.replace.a.fg = "#494b53"
			theme.insert.a.bg = "#f0f0f0"
			theme.insert.a.fg = "#494b53"

			require("lualine").setup({
				options = {
					icons_enabled = false,
					theme = theme,
					component_separators = { "", "" },
					section_separators = { "", "" },
					disabled_filetypes = {},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						{
							"filename",
							path = 1,
						},
					},
					lualine_c = {},
					lualine_x = { "filetype" },
					lualine_y = {},
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {
						{
							"filename",
							path = 1,
						},
					},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				extensions = {},
			})
		end,
	},
}
