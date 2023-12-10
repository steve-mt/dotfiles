local mason_tool_installer = require("mason-tool-installer")

mason_tool_installer.setup({
	ensure_installed = {
		-- LSP
		"gopls",
		"rust_analyzer",
		"jsonnet_ls",
		"lua_ls",

		-- Formatters
		"stylua",
		"jq",
		"gofumpt",
		"rubocop", -- System installed ruby fails to install this.
		"yamlfix",
		"shfmt",

		-- Linters
		"tflint",
		"tfsec",
		"yamllint",
		"shellcheck",
		"markdownlint",
		"vale",
		"trivy",
	},
})
