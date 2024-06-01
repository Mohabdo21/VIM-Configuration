return {
	"folke/noice.nvim",
	event = "VeryLazy",

	opts = {

		views = {
			cmdline_popup = {
				position = {
					row = 20,
					col = "50%",
				},
				size = {
					width = 60,
					height = "auto",
				},
			},
			popupmenu = {
				relative = "editor",
				position = {
					row = 23,
					col = "50%",
				},
				size = {
					width = 60,
					height = 10,
				},
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				win_options = {
					winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
				},
			},
		},
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
					},
				},
				view = "mini",
			},
			{
				-- Filter for notifications containing the specific message
				filter = { event = "notify", find = "No information available" },
				opts = { skip = true },
			},
			{
				filter = {
					event = "lsp",
					kind = "progress",
					cond = function(message)
						local client = vim.tbl_get(message.opts, "progress", "client")
						return client == "lua_ls"
					end,
				},
				opts = { skip = true },
			},
		},
		presets = {
			-- Enable border for LSP documentation windows
			lsp_doc_border = true,
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = true,
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		-- Notification manager for Neovim
		{
			"rcarriga/nvim-notify",
			config = function()
				require("notify").setup({
					-- Set custom timeout for notifications (in milliseconds)
					timeout = 800, -- Adjust this value as needed
				})
			end,
		},
	},
}
