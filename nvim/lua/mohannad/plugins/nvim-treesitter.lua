return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- The new nvim-treesitter does NOT support lazy-loading
		lazy = false,
		build = ":TSUpdate",
		config = function()
			-- Minimal setup (install_dir defaults to stdpath('data')/site)
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

			-- Auto-install parsers when opening a file if a parser is available but not yet installed,
			-- and enable treesitter highlighting for any filetype with an installed parser
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local ft = args.match
					local lang = vim.treesitter.language.get_lang(ft) or ft
					local parsers = require("nvim-treesitter.parsers")

					-- Auto-install if a parser definition exists but isn't installed yet
					if parsers[lang] and parsers[lang].install_info then
						local installed = pcall(vim.treesitter.language.inspect, lang)
						if not installed then
							require("nvim-treesitter").install({ lang })
							-- Poll until the async install finishes, then enable highlighting
							local buf = args.buf
							local attempts = 0
							local timer = vim.uv.new_timer()
							if timer then
								timer:start(1000, 2000, vim.schedule_wrap(function()
									attempts = attempts + 1
									local ok = pcall(vim.treesitter.language.inspect, lang)
									if ok or attempts >= 30 then
										timer:stop()
										timer:close()
										if ok and vim.api.nvim_buf_is_valid(buf) then
											pcall(vim.treesitter.start, buf)
										end
									end
								end))
							end
							return
						end
					end

					-- Enable highlighting for any filetype with an available parser
					pcall(vim.treesitter.start)
				end,
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
	{ -- Context commentstring when commenting (triggered by plugins like Comment.nvim)
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("ts_context_commentstring").setup({})
		end,
	},
}
