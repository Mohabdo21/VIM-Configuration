return {
	"danymat/neogen",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("neogen").setup({
			enabled = true, -- Enable the plugin
			snippet_engine = "nvim", -- Use Neovim's built-in snippet engine (0.10+)
			languages = {
				python = {
					template = {
						annotation_convention = "google_docstrings", -- Choose your preferred docstring style
					},
				},
				lua = {
					template = {
						annotation_convention = "emmylua", -- EmmyLua style for Lua
					},
				},
				javascript = {
					template = {
						annotation_convention = "jsdoc", -- JSDoc style for JavaScript
					},
				},
				typescript = {
					template = {
						annotation_convention = "tsdoc", -- TSDoc style for TypeScript
					},
				},
				go = {
					template = {
						annotation_convention = "godoc", -- GoDoc style for Go
					},
				},
				c = {
					template = {
						annotation_convention = "doxygen", -- Doxygen style for C
					},
				},
				cpp = {
					template = {
						annotation_convention = "doxygen", -- Doxygen style for C++
					},
				},
				rust = {
					template = {
						annotation_convention = "rustdoc", -- RustDoc style for Rust
					},
				},
				java = {
					template = {
						annotation_convention = "javadoc", -- JavaDoc style for Java
					},
				},
				php = {
					template = {
						annotation_convention = "phpdoc", -- PHPDoc style for PHP
					},
				},
				ruby = {
					template = {
						annotation_convention = "yard", -- YARD style for Ruby
					},
				},
			},
		})

		-- Set Neogen keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set(
			"n",
			"<leader>nf",
			":lua require('neogen').generate()<CR>",
			{ noremap = true, silent = true, desc = "Generate function documentation" }
		)
		keymap.set(
			"n",
			"<leader>nc",
			":lua require('neogen').generate({ type = 'class' })<CR>",
			{ noremap = true, silent = true, desc = "Generate class documentation" }
		)
		keymap.set(
			"n",
			"<leader>nt",
			":lua require('neogen').generate({ type = 'type' })<CR>",
			{ noremap = true, silent = true, desc = "Generate type documentation" }
		)
		keymap.set(
			"n",
			"<leader>nn",
			":lua require('neogen').generate({ type = 'file' })<CR>",
			{ noremap = true, silent = true, desc = "Generate file documentation" }
		)
	end,
}
