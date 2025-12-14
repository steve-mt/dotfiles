return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	config = function()
		local mason_tool_installer = require("mason-tool-installer")

		mason_tool_installer.setup({
			ensure_installed = {
				-- LSP
				"gopls",
				"rust-analyzer",
				"jsonnet_ls",
				"lua-language-server",
				"typescript-language-server",
				"bash-language-server",
				"terraform-ls",

				-- Formatters
				"stylua",
				"jq",
				"gofumpt",
				"goimports",
				"rubocop", -- System installed ruby fails to install this.
				"yamlfix",
				"shfmt",
				"prettier",
				"nixpkgs-fmt",
				"buf",
				"hclfmt",

				-- Linters
				"tflint",
				"yamllint",
				"shellcheck",
				"markdownlint",
				"vale",
				"trivy",
				"codespell",
				"golangci-lint",
				"staticcheck",
			},
		})
	end,
}
