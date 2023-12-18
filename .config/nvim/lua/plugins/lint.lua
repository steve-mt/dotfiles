return {
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				markdown = { "vale", "markdownlint" },
				terraform = { "tflint", "trivy" },
				sh = { "shellcheck" },
				yaml = { "yamllint" },
			}

			-- Enable for debugging
			-- local lint_progress = function()
			-- 	local linters = lint.get_running()
			-- 	if #linters == 0 then
			-- 		return
			-- 	end

			-- 	print("Run Linters:", table.concat(linters, ","))
			-- end

			-- Run lint on events `:help events`
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
				callback = function()
					require("lint").try_lint()
					-- Enable for debugging
					-- lint_progress()
				end,
			})

			-- Customize linters
			lint.linters.markdownlint.args = {
				"--disable",
				"MD013",
				"MD033",
				"--",
			}
		end,
	},
}
