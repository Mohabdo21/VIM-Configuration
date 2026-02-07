local severity = vim.diagnostic.severity
local icons = {
	[severity.ERROR] = " ",
	[severity.WARN] = " ",
	[severity.INFO] = " ",
	[severity.HINT] = "󰠠 "
}

vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = function(diag)
			local hl = {
				[severity.ERROR] = "DiagnosticError",
				[severity.WARN] = "DiagnosticWarn",
				[severity.INFO] = "DiagnosticInfo",
				[severity.HINT] = "DiagnosticHint"
			}
			return icons[diag.severity] or "", hl[diag.severity] or "DiagnosticInfo"
		end,
	},
	signs = {
		text = icons,
		hl = {
			[severity.ERROR] = "DiagnosticSignError",
			[severity.WARN] = "DiagnosticSignWarn",
			[severity.INFO] = "DiagnosticSignInfo",
			[severity.HINT] = "DiagnosticSignHint"
		},
		numhl = {
			[severity.ERROR] = "DiagnosticSignError",
			[severity.WARN] = "DiagnosticSignWarn",
			[severity.INFO] = "DiagnosticSignInfo",
			[severity.HINT] = "DiagnosticSignHint"
		}
	},
})
