return {
	"rmagatti/auto-session",
	config = function()
		-- Set the sessionoptions to include 'localoptions' as recommended
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

		require("auto-session").setup({
			auto_restore_last_session = false, -- Updated config name
			suppressed_dirs = { "~/", "~/Desktop", "~/Downloads", "~/Train_my_self" }, -- Updated config name
			session_lens = {
				buftypes_to_ignore = {},
				load_on_setup = false, -- Ensures session-lens does not load automatically
				theme_conf = { border = true },
				previewer = false,
			},
		})

		-- Keybinding to manually load the session lens and search for sessions
		vim.keymap.set("n", "<leader>ls", function()
			require("auto-session.session-lens").search_session()
		end, { noremap = true })
	end,
}
