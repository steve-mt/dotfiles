return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"saghen/blink.cmp",
		"nvim-telescope/telescope.nvim",
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
				settings = {
					gopls = {
						gofumpt = true,
						staticcheck = true,
						buildFlags = { "-tags=integration" }, -- Common tags
					},
				},
			},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
					},
				},
			},

			jsonnet_ls = {},

			lua_ls = {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			},

			ts_ls = {},

			bashls = {
				settings = {
					bashIde = {
						shfmt = {
							path = "", -- Use none ls instead since we have more control on settings.
						},
					},
				},
			},

			terraformls = {},
		}

		-- Set up blink
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

		for server_name, server in pairs(servers) do
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			vim.lsp.config(server_name, server)
			vim.lsp.enable(server_name)
		end
	end,
}
