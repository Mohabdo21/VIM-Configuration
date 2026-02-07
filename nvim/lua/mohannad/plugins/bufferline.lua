return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	version = "*",

	keys = {
		{ "<leader>bl", "<Cmd>BufferLinePick<CR>",      desc = "Toggle Picker" },
		{ "<leader>bx", "<Cmd>BufferLinePickClose<CR>", desc = "Pick & Close Buffer" },
	},
	opts = {
		options = {
			separator_style = "thick",
			mode = "tabs",
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					highlight = "Directory",
					text_align = "center",
					separator = true,
				},
			},

			-- Additional options for better usability
			diagnostics = "nvim_lsp", -- Show LSP diagnostics in the bufferline
			diagnostics_indicator = function(count, level, _, _)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,
			show_buffer_close_icons = true, -- Show close icons for each buffer
			show_close_icon = false, -- Show close icon for the entire bufferline
			enforce_regular_tabs = false, -- Ensure tabs have a regular appearance
			always_show_bufferline = true, -- Always show the bufferline, even with one buffer
		},
	},
}
