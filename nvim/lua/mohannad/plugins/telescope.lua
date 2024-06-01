return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Common utilities
		"ThePrimeagen/harpoon", -- Harpoon for file navigation
		"joshmedeski/telescope-smart-goto.nvim", -- Smart goto extension
		"nvim-telescope/telescope-live-grep-args.nvim", -- Live grep with arguments
		"debugloop/telescope-undo.nvim", -- Undo history extension
		"nvim-telescope/telescope-fzf-native.nvim", -- FZF sorter
		"nvim-telescope/telescope-ui-select.nvim", -- UI select extension
		"aaronhallaert/advanced-git-search.nvim", -- Advanced git search
		"nvim-telescope/telescope-media-files.nvim", -- Media files preview
		"MunifTanjim/nui.nvim", -- UI component library
		"rcarriga/nvim-notify", -- Notifications
		"folke/noice.nvim", -- Noice plugin
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local telescopeConfig = require("telescope.config")
		local builtin = require("telescope.builtin")

		-- Key mappings for Telescope
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
		vim.keymap.set(
			"n",
			"<leader>fg",
			require("telescope").extensions.live_grep_args.live_grep_args,
			{ desc = "Live Grep" }
		)
		vim.keymap.set("n", "<leader>fc", function()
			builtin.live_grep({ glob_pattern = "!{spec,test}" })
		end, { desc = "Live Grep Code" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
		vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find Symbols" })
		vim.keymap.set("n", "<leader>fi", "<cmd>AdvancedGitSearch<CR>", { desc = "Advanced Git Search" })
		vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find Old Files" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word under Cursor" })
		vim.keymap.set("n", "<leader>tc", builtin.git_commits, { desc = "Search Git Commits" })
		vim.keymap.set("n", "<leader>tb", builtin.git_bcommits, { desc = "Search Git Commits for Buffer" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
				layout_config = { width = 0.7 },
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- Clone the default Telescope configuration
		local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

		-- Customize vimgrep arguments
		table.insert(vimgrep_arguments, "--hidden")
		table.insert(vimgrep_arguments, "--glob")
		table.insert(vimgrep_arguments, "!**/.git/*")

		-- Function to handle multi-selection
		local select_one_or_multi = function(prompt_bufnr)
			local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
			local multi = picker:get_multi_selection()
			if not vim.tbl_isempty(multi) then
				actions.close(prompt_bufnr)
				for _, j in pairs(multi) do
					if j.path ~= nil then
						vim.cmd(string.format("%s %s", "edit", j.path))
					end
				end
			else
				actions.select_default(prompt_bufnr)
			end
		end

		-- Telescope setup
		telescope.setup({
			defaults = {
				vimgrep_arguments = vimgrep_arguments,
				path_display = { "truncate" },
				mappings = {
					n = {
						["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
					i = {
						["<C-j>"] = actions.cycle_history_next,
						["<C-k>"] = actions.cycle_history_prev,
						["<CR>"] = select_one_or_multi,
						["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-S-d>"] = actions.delete_buffer,
						["<C-s>"] = actions.cycle_previewers_next,
						["<C-a>"] = actions.cycle_previewers_prev,
					},
				},
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
			},
			extensions = {
				undo = {
					use_delta = true,
					side_by_side = false,
					diff_context_lines = vim.o.scrolloff,
					entry_format = "state #$ID, $STAT, $TIME",
					mappings = {
						i = {
							["<C-cr>"] = require("telescope-undo.actions").yank_additions,
							["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
							["<cr>"] = require("telescope-undo.actions").restore,
						},
					},
				},
			},
		})

		-- Load Telescope extensions
		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
		telescope.load_extension("undo")
		telescope.load_extension("advanced_git_search")
		telescope.load_extension("live_grep_args")
		telescope.load_extension("noice")
	end,
}
