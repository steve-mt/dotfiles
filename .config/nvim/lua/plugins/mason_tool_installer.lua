return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			local mason_tool_installer = require("mason-tool-installer")

			mason_tool_installer.setup({
				ensure_installed = {
					-- LSP
					"gopls",
					"rust_analyzer",
					"jsonnet_ls",
					"lua_ls",
					"typescript-language-server",
					"bashls",
					"terraformls",

					-- Formatters
					"stylua",
					"jq",
					"gofumpt",
					"rubocop", -- System installed ruby fails to install this.
					"yamlfix",
					"shfmt",
					"prettier",
					"nixpkgs-fmt",
					"buf",

					-- Linters
					"tflint",
					"yamllint",
					"shellcheck",
					"markdownlint",
					"vale",
					"trivy",
					"codespell",
					"golangci-lint",
				},
			})
		end,
	},
}
