return {
	"mfussenegger/nvim-lint",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },

	-- Configure the plugin
	config = function()
		-- Import the 'lint' module
		local lint = require("lint")

		-- Set up the 'lint' module
		lint.linters_by_ft = {
			-- Specify the linters for each file type
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			python = { "pylint" },
			go = { "golangcilint" },
			puppet = { "puppet-lint" },
			bash = { "shellcheck" },
			markdown = { "markdownlint" },
			yaml = { "yamllint" },
			sql = { "sqlfluff" },
		}

		-- Customize the pylint linter
		lint.linters.pylint.cmd = "python"
		table.insert(lint.linters.pylint.args, 1, "pylint")
		table.insert(lint.linters.pylint.args, 1, "-m")

		-- Helper: only run linters whose command is available
		local function try_lint_available()
			local ft_linters = lint.linters_by_ft[vim.bo.filetype] or {}
			local available = vim.tbl_filter(function(name)
				local linter = lint.linters[name]
				if not linter then
					return false
				end
				local cmd = type(linter.cmd) == "function" and linter.cmd() or linter.cmd
				return cmd and vim.fn.executable(cmd) == 1
			end, ft_linters)
			if #available > 0 then
				lint.try_lint(available)
			end
		end

		-- Create an autogroup for linting
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		-- Set up an autocmd to lint the buffer on certain events
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				local curpos = vim.api.nvim_win_get_cursor(0)
				try_lint_available()
				if vim.bo.modifiable then
					vim.cmd([[keeppatterns %s/\s\+$//e]])
				end
				vim.api.nvim_win_set_cursor(0, curpos)
			end,
		})

		-- Set a keybinding for linting the current buffer
		vim.keymap.set("n", "<leader>l", function()
			try_lint_available()
		end, { desc = "Trigger linting for current file" })
	end,
}
