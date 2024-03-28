return {
	{
		"nvimtools/none-ls.nvim",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					-- Formatters
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.rustfmt.with({
						extra_args = { "--edition=2021" },
					}),
					null_ls.builtins.formatting.jq,
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.formatting.rubocop,
					null_ls.builtins.formatting.yamlfix,
					null_ls.builtins.formatting.terraform_fmt,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.markdownlint,
					null_ls.builtins.formatting.nixpkgs_fmt,
					null_ls.builtins.formatting.codespell,

					-- Linters
					null_ls.builtins.diagnostics.trivy,
					null_ls.builtins.diagnostics.terraform_validate,
					null_ls.builtins.diagnostics.yamllint,
					null_ls.builtins.diagnostics.markdownlint.with({
						extra_args = { "--disable", "MD013", "MD033" },
					}),
					null_ls.builtins.diagnostics.codespell,
					null_ls.builtins.diagnostics.vale,
				},
				on_attach = function(client, bufnr) -- fmt on save https://github.com/nvimtools/none-ls.nvim/wiki/Formatting-on-save
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end,
			})
		end,
	},
}
