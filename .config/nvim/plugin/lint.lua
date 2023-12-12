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

-- Fix tflint parser: https://github.com/mfussenegger/nvim-lint/pull/487
local tflint_severity_to_diagnostic_severity = {
	warning = vim.diagnostic.severity.WARN,
	["error"] = vim.diagnostic.severity.ERROR,
	notice = vim.diagnostic.severity.INFO,
}
lint.linters.tflint.parser = function(output, bufnr)
	local decoded = vim.json.decode(output) or {}
	local issues = decoded["issues"] or {}
	local diagnostics = {}
	local buf_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":.")

	for _, issue in ipairs(issues) do
		if issue.range.filename == "" or issue.range.filename == buf_path then
			table.insert(diagnostics, {
				lnum = assert(tonumber(issue.range.start.line)),
				end_lnum = assert(tonumber(issue.range["end"].line)),
				col = assert(tonumber(issue.range.start.column)),
				end_col = assert(tonumber(issue.range["end"].column)),
				severity = tflint_severity_to_diagnostic_severity[issue.rule.severity],
				source = "tflint",
				message = string.format("%s (%s)\nReference: %s", issue.message, issue.rule.name, issue.rule.link),
			})
		end
	end
	return diagnostics
end
