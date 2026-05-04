return {
	{
		-- nvim-treesitter is archived but still needed for parser installation.
		-- Use the rewritten main branch on Nvim 0.12+.
		-- Highlighting, folding, and incremental selection use native APIs
		-- (configured in core/options.lua).
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter")
			local parsers = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"markdown",
				"markdown_inline",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"python",
				"c",
				"vimdoc",
				"regex",
				"go",
				"htmldjango",
			}

			treesitter.setup({})
			treesitter.install(parsers)
		end,
	},
	{ -- Lazy-load autotag only for markup-ish filetypes
		"windwp/nvim-ts-autotag",
		ft = { "html", "javascript", "typescript", "tsx", "jsx", "vue" },
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
}
