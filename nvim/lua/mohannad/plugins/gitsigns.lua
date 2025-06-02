return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },

	config = function()
		require("gitsigns").setup({
			-- Custom signs
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},

			-- Keybindings
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				-- Navigation
				vim.keymap.set("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "Next Hunk" })

				vim.keymap.set("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "Previous Hunk" })

				-- Actions
				vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage Hunk" })
				vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Reset Hunk" })
				vim.keymap.set("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { buffer = bufnr, desc = "Stage Hunk" })
				vim.keymap.set("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { buffer = bufnr, desc = "Reset Hunk" })
				vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "Stage Buffer" })
				vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo Stage Hunk" })
				vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "Reset Buffer" })
				vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview Hunk" })
				vim.keymap.set("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, { buffer = bufnr, desc = "Blame Line" })
				vim.keymap.set(
					"n",
					"<leader>tb",
					gs.toggle_current_line_blame,
					{ buffer = bufnr, desc = "Toggle Blame" }
				)
				vim.keymap.set("n", "<leader>hd", gs.diffthis, { buffer = bufnr, desc = "Diff This" })
				vim.keymap.set("n", "<leader>hD", function()
					gs.diffthis("~")
				end, { buffer = bufnr, desc = "Diff This (~)" })
				vim.keymap.set("n", "<leader>td", gs.toggle_deleted, { buffer = bufnr, desc = "Toggle Deleted" })
			end,

			-- Line highlighting
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 2000,
				ignore_whitespace = false,
			},

			-- Diff preview
			-- preview_config = {
			-- 	border = "rounded",
			-- 	style = "minimal",
			-- 	relative = "cursor",
			-- 	row = 0,
			-- 	col = 1,
			-- },

			-- Word diff
			-- word_diff = true,

			-- Status line integration
			-- signcolumn = true,
			-- numhl = true,
			-- linehl = false,
		})
	end,
}
