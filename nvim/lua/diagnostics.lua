vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	-- This is the new way to configure diagnostic signs:
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ", -- Error icon
			[vim.diagnostic.severity.WARN] = " ", -- Warn icon
			[vim.diagnostic.severity.INFO] = " ", -- Info icon
			[vim.diagnostic.severity.HINT] = "󰠠 ", -- Hint icon
		},
		hl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
		},
		-- The default highlight groups usually match 'DiagnosticSign' .. type
		-- unless you want to override them.

		-- Optional: Set false to disable signs completely, true to use defaults, or the table as above
		-- enabled = true, -- This is equivalent to providing the 'text' table
	},
})
