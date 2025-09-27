return {
	"stevearc/dressing.nvim",
	lazy = true, -- do not load on VeryLazy anymore
	init = function()
		-- Lazy-load only when one of the UI functions is actually used
		local function lazy_load()
			if not package.loaded["dressing"] then
				require("lazy").load({ plugins = { "dressing.nvim" } })
			end
		end
		local orig_select = vim.ui.select
		local orig_input = vim.ui.input
		vim.ui.select = function(items, opts, on_choice)
			lazy_load()
			vim.ui.select = orig_select -- restore original (wrapped by dressing)
			return vim.ui.select(items, opts, on_choice)
		end
		vim.ui.input = function(opts, on_confirm)
			lazy_load()
			vim.ui.input = orig_input
			return vim.ui.input(opts, on_confirm)
		end
	end,
	config = function()
		require("dressing").setup({
			input = {
				-- Default prompt string
				default_prompt = "Input:",
				-- Can be 'left', 'right', or 'center'
				prompt_align = "center",
				-- When true, <Esc> will close the modal
				insert_only = true,
				-- These are passed to nvim_open_win
				anchor = "NW",
				border = "rounded",
				relative = "cursor",
				prefer_width = 40,
				width = nil,
				max_width = { 140, 0.9 },
				min_width = { 20, 0.2 },
				win_options = {
					-- Window transparency (0-100)
					winblend = 20,
					-- Change default highlight groups (see :help winhl)
					winhighlight = "",
				},
				mappings = {
					n = {
						["<Esc>"] = "Close",
						["<CR>"] = "Confirm",
					},
					i = {
						["<C-c>"] = "Close",
						["<CR>"] = "Confirm",
						["<Up>"] = "HistoryPrev",
						["<Down>"] = "HistoryNext",
					},
				},
				override = function(conf)
					-- This is the config that will be passed to nvim_open_win.
					-- Change values here to customize the window layout.
					return conf
				end,
			},
			select = {
				-- Defer telescope; if telescope not loaded fallback to builtin, telescope will augment later
				backend = { "builtin", "telescope" },
				-- do not require telescope here to avoid pulling it early
				builtin = {
					-- These are passed to nvim_open_win
					anchor = "NW",
					border = "rounded",
					relative = "editor",
					width = nil,
					max_width = { 140, 0.8 },
					min_width = { 40, 0.4 },
					win_options = {
						-- Window transparency (0-100)
						winblend = 10,
						-- Change default highlight groups (see :help winhl)
						winhighlight = "",
					},
					mappings = {
						["<Esc>"] = "Close",
						["<CR>"] = "Confirm",
						["<Up>"] = "Prev",
						["<Down>"] = "Next",
					},
				},
			},
		})
	end,
}
