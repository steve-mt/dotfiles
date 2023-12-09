local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		["*"] = { "trim_whitespace", "trim_newlines" },
		rust = { "rustfmt" },
		lua = { "stylua" },
		json = { "jq" },
		go = { "gofumpt" },
		ruby = { "rubocop" },
		yaml = { "yamlfix" },
		sh = { "shfmt" },
		terraform = { "terraform_fmt" },
	},
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 500,
	},
	formatters = {
		rustfmt = {
			args = { "--emit=stdout", "--edition=2021" },
		},
	},
})
