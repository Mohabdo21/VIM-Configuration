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
			javascript = { "eslint" },
			typescript = { "eslint" },
			javascriptreact = { "eslint" },
			typescriptreact = { "eslint" },
			svelte = { "eslint_d" },
			python = { "pylint" },
			puppet = { "puppet-lint" },
			bash = { "shellcheck" },
			markdown = { "markdownlint" },
			yaml = { "yamllint" },
		}

		-- Create an autogroup for linting
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		-- Set up an autocmd to lint the buffer on certain events
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				-- Try to lint the buffer
				lint.try_lint()
			end,
		})

		-- Set a keybinding for linting the current buffer
		vim.keymap.set("n", "<leader>l", function()
			-- Try to lint the current buffer
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
