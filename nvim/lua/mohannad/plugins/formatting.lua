return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },

	-- Configure the plugin
	config = function()
		-- Import the 'conform' module
		local conform = require("conform")

		-- Set up the 'conform' module
		conform.setup({
			-- Specify the formatters for each file type
			formatters_by_ft = {
				javascript = { "prettier", "eslint_d" }, -- Added eslint_d for JavaScript
				typescript = { "prettier", "eslint_d" }, -- Added eslint_d for TypeScript
				javascriptreact = { "prettier", "eslint_d" }, -- Added eslint_d for JSX
				typescriptreact = { "prettier", "eslint_d" }, -- Added eslint_d for TSX
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" }, -- Added pylint for Python
				c = { "clang-format" },
				cpp = { "clang-format" }, -- Added C++ support
				bash = { "shfmt" },
				sql = { "sqlfmt" },
				go = { "gofmt" }, -- Added Go support
				rust = { "rustfmt" }, -- Added Rust support
				-- Add more formatters as needed
			},

			-- Configure the behavior when saving a file
			format_on_save = {
				lsp_fallback = true, -- Use the LSP as a fallback formatter
				async = false, -- Perform formatting synchronously
				timeout_ms = 1500, -- Timeout for formatting (in milliseconds)
			},

			-- Configure specific formatters
			formatter_configs = {
				["clang-format"] = {
					style = "file",
				},
				["prettier"] = {
					command = "prettier",
					args = { "--stdin-filepath", "$FILENAME", "--print-width", "80" },
				},
				["black"] = {
					command = "black",
					args = { "--quiet", "-", "--line-length", "80" },
				},
			},
		})

		-- Set a keybinding for formatting the current file or selected range
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
