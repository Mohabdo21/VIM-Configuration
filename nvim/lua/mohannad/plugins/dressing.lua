return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
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
				-- Priority list of preferred vim.select implementations
				backend = { "telescope", "builtin" },
				telescope = require("telescope.themes").get_dropdown({
					-- even more opts
				}),
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
