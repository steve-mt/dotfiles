return {
	{
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				"saghen/blink.cmp",
			},
			config = function()
				require("mason").setup()

				-- Key bindings
				-- Override default bindings https://gpanders.com/blog/whats-new-in-neovim-0-11/#more-default-mappings
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "grr", builtin.lsp_references, {})
				vim.keymap.set("n", "gri", builtin.lsp_implementations, {})
				vim.keymap.set("n", "g0", builtin.lsp_document_symbols, {})
				vim.keymap.set("n", "grd", builtin.lsp_definitions, {})
				vim.keymap.set("n", "grn", vim.lsp.buf.rename, {})
				vim.keymap.set("n", "gn", function()
					vim.diagnostic.jump({
						count = 1,
					})
				end, {})
				vim.keymap.set("n", "gp", function()
					vim.diagnostic.jump({
						count = -1,
					})
				end, {})

				-- Server configurations
				local servers = {
					gopls = {
						gopls = {
							gofumpt = true,
							staticcheck = true,
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

					bashls = {
						bashIde = {
							shfmt = {
								path = "", -- Use none ls instead since we have more control on settings.
							},
						},
					},

					terraformls = {},
				}

				-- Set up blink
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

				-- Mason lsp configuration
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
