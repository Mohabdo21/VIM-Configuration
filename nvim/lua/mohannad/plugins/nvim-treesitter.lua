return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- Load only when entering a buffer with a filetype that benefits from treesitter
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {},
		config = function()
			local treesitter = require("nvim-treesitter.configs")
			treesitter.setup({
				modules = {},
				sync_install = false, -- Disable sync-install to speed up startup
				ignore_install = {},
				highlight = { enable = true }, -- Enable syntax highlighting
				indent = { enable = false }, -- Disable Treesitter-based indentation (optional)
				-- NOTE: autotag module enable here is deprecated upstream; using dedicated plugin setup instead
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
	-- Defer textobjects until explicitly needed; keep separate spec for clearer control
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		ft = { "lua", "javascript", "typescript", "markdown", "go", "python" },
		config = function()
			-- Only configure its submodules; assume base treesitter already set up
			local ok = pcall(require, "nvim-treesitter.configs")
			if not ok then
				return
			end
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = { enable = true, lookahead = true },
					move = { enable = true, set_jumps = true },
					swap = { enable = true },
				},
			})
		end,
	},
	{ -- Lazy-load autotag only for markup-ish filetypes
		"windwp/nvim-ts-autotag",
		ft = { "html", "javascript", "typescript", "tsx", "jsx", "vue" },
		config = function()
			pcall(require, "nvim-treesitter.configs") -- ensure base loaded
			require("nvim-ts-autotag").setup({})
		end,
	},
	{ -- Context commentstring when commenting (triggered by plugins like Comment.nvim)
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("ts_context_commentstring").setup({})
		end,
	},
}
