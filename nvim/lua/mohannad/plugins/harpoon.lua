return {
	"ThePrimeagen/harpoon",
	keys = {
		{
			"<leader>hm",
			function()
				require("harpoon.mark").add_file()
			end,
			desc = "Mark file with harpoon",
		},
		{
			"<leader>hn",
			function()
				require("harpoon.ui").nav_next()
			end,
			desc = "Go to next harpoon mark",
		},
		{
			"<leader>hP",
			function()
				require("harpoon.ui").nav_prev()
			end,
			desc = "Go to previous harpoon mark",
		},
		{
			"<leader>he",
			function()
				require("harpoon.mark").rm_file()
			end,
			desc = "Remove current file from harpoon marks",
		},
		{ "<leader>hq", "<cmd>Telescope harpoon marks<cr>", desc = "Open harpoon marks in telescope" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("harpoon").setup({})
	end,
}
