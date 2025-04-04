return {
	{
		"saghen/blink.cmp",
		dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },

		version = "*",

		opts = {
			snippets = { preset = "luasnip" },

			completion = { documentation = { auto_show = false } },

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
