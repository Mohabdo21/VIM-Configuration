return {
	"neoclide/coc.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.g.coc_global_extensions = {
			"coc-json",
			"coc-tsserver",
			"coc-eslint",
			"coc-prettier",
			"coc-clangd",
			"coc-ltex",
			"coc-pyright",
		}

		vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "gy", "<Plug>(coc-type-definition)", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "gi", "<Plug>(coc-implementation)", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "gr", "<Plug>(coc-references)", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>c", "<Esc>", { noremap = true, silent = true })
	end,
}
