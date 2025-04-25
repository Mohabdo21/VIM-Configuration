return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	build = ":Copilot auth",
	opts = {
		suggestion = {
			enabled = true,
			auto_trigger = true,
			debounce = 75,
			keymap = {
				accept = "<M-l>",
				accept_word = "<M-w>", -- new
				accept_line = "<M-e>", -- new
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},
		},
		panel = {
			enabled = false,
			auto_refresh = false,
		},
		filetypes = {
			["*"] = function()
				return vim.fn.line("$") < 1000 -- disable for large files
			end,
			gitcommit = false,
			gitrebase = false,
			hgcommit = false,
			svn = false,
			cvs = false,
			[".env"] = false,
			markdown = false, -- new
		},
		server_opts_overrides = {
			settings = {
				advanced = {
					inlineSuggestCount = 3,
					listCount = 10, -- new
					topN = 3, -- new
				},
			},
		},
	},
	config = function(_, opts)
		require("copilot").setup(opts)

		-- Keymaps
		vim.keymap.set("n", "<leader>ct", "<cmd>Copilot toggle<CR>", { desc = "Toggle Copilot" })
		vim.keymap.set("n", "<leader>cs", "<cmd>Copilot status<CR>", { desc = "Copilot Status" })

		-- CMP integration
		local ok, cmp = pcall(require, "cmp")
		if ok then
			cmp.event:on("menu_opened", function()
				vim.b.copilot_suggestion_hidden = true
			end)
			cmp.event:on("menu_closed", function()
				vim.b.copilot_suggestion_hidden = false
			end)
		end
	end,
}
