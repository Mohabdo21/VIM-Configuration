return {
	"danymat/neogen",
	cmd = "Neogen",
	keys = {
		{
			"<leader>nf",
			function()
				require("neogen").generate()
			end,
			desc = "Generate function documentation",
		},
		{
			"<leader>nc",
			function()
				require("neogen").generate({ type = "class" })
			end,
			desc = "Generate class documentation",
		},
		{
			"<leader>nt",
			function()
				require("neogen").generate({ type = "type" })
			end,
			desc = "Generate type documentation",
		},
		{
			"<leader>nn",
			function()
				require("neogen").generate({ type = "file" })
			end,
			desc = "Generate file documentation",
		},
	},
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
	end,
}
