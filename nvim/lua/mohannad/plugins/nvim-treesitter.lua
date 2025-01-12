return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy", -- Lazy-load Treesitter
		build = ":TSUpdate",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" }, -- Lazy-load textobjects
			{ "windwp/nvim-ts-autotag", event = "VeryLazy" }, -- Lazy-load autotag
		},
		config = function()
			local treesitter = require("nvim-treesitter.configs")

			treesitter.setup({
				modules = {},
				sync_install = false, -- Disable sync-install to speed up startup
				ignore_install = {},
				highlight = { enable = true }, -- Enable syntax highlighting
				indent = { enable = false }, -- Disable Treesitter-based indentation (optional)
				autotag = { enable = true }, -- Enable autotagging
				ensure_installed = { -- Only include parsers you use regularly
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
				},
				auto_install = true, -- Disable auto-install to speed up startup
				incremental_selection = { -- Disable if not used
					enable = false,
				},
			})
		end,
	},
	{ -- Lazy-load ts_context_commentstring
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "VeryLazy",
		config = function()
			require("ts_context_commentstring").setup({})
		end,
	},
}
