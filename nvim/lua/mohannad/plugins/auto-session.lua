return {
	"rmagatti/auto-session",
	config = function()
		-- Set the sessionoptions to include 'localoptions' as recommended
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

		require("auto-session").setup({
			auto_restore_last_session = false,
			suppressed_dirs = { "~/", "~/Desktop", "~/Downloads", "~/Train_my_self" },
			bypass_save_filetypes = { "alpha", "NvimTree" },
			session_lens = {
				load_on_setup = false,
				previewer = false,
			},
			post_restore_cmds = {
				function()
					if package.loaded["nvim-tree.api"] then
						require("nvim-tree.api").tree.open()
					end
				end,
			},
		})

		-- Session keymaps
		vim.keymap.set("n", "<leader>as", "<cmd>AutoSession search<CR>", { desc = "Search sessions" })
		vim.keymap.set("n", "<leader>sn", "<cmd>AutoSession save<CR>", { desc = "Save session" })
		vim.keymap.set("n", "<leader>ds", "<cmd>AutoSession delete<CR>", { desc = "Delete session" })
		vim.keymap.set("n", "<leader>sr", "<cmd>AutoSession restore<CR>", { desc = "Restore session (cwd)" })
	end,
}
