return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
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

			ts_ls = {},

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

		require("mason-lspconfig").setup({
			ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
			automatic_installation = false,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for ts_ls)
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
