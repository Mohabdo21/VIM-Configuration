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
					vim.schedule(function()
						for _, buf in ipairs(vim.api.nvim_list_bufs()) do
							if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
								local ft = vim.bo[buf].filetype
								if ft and ft ~= "" then
									vim.api.nvim_buf_call(buf, function()
									vim.api.nvim_exec_autocmds("FileType", { pattern = ft })
								end)
								end
							end
						end

						if package.loaded["nvim-tree.api"] then
							require("nvim-tree.api").tree.open()
						end
					end)
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
