return {
	{
		-- nvim-treesitter is archived but still needed for parser installation.
		-- Nvim 0.12 has no built-in parser installer yet (neovim/neovim#39007).
		-- Highlighting, folding, and incremental selection use native APIs
		-- (configured in core/options.lua).
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({})

			-- Install parsers (no-op if already installed)
			require("nvim-treesitter").install({
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
			})
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
