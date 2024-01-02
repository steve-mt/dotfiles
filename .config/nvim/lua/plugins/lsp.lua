return {
	{
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				"folke/neodev.nvim",
			},
			config = function()
				require("neodev").setup()
				require("mason").setup()

				-- Key bindings
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "gr", builtin.lsp_references, {})
				vim.keymap.set("n", "gd", builtin.lsp_definitions, {})
				vim.keymap.set("n", "gi", builtin.lsp_implementations, {})
				vim.keymap.set("n", "<C-t>", builtin.lsp_document_symbols, {})

				vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
				vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, {})
				vim.keymap.set("n", "ge", vim.lsp.buf.rename, {})
				vim.keymap.set("n", "<C-n>", vim.diagnostic.goto_next, {})
				vim.keymap.set("n", "<C-N>", vim.diagnostic.goto_prev, {})

				-- Server configurations
				local servers = {
					gopls = {
						gopls = {
							gofumpt = true,
							staticcheck = true,
							env = {
								GOFLAGS = "-tags=linux",
							},
						},
					},
					rust_analyzer = {
						["rust-analyzer"] = {
							check = {
								command = "clippy",
							},
						},
					},

					jsonnet_ls = {},

					lua_ls = {
						Lua = {
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
						},
					},

					tsserver = {},
				}

				-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

				-- mason configuration
				local mason_lspconfig = require("mason-lspconfig")

				mason_lspconfig.setup_handlers({
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
							settings = servers[server_name],
						})
					end,
				})
			end,
		},
	},
}
