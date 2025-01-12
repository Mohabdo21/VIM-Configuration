return {
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({
				render = "background", -- or "foreground" or "first_column"
				enable_named_colors = true, -- Enable named colors (e.g., "red", "blue")
				enable_tailwind = true, -- Enable Tailwind CSS color support
			})
		end,
	},
}
