return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_no_tab_map = true
		vim.api.nvim_set_keymap("i", "<M-l>", 'copilot#Accept("<CR>")', {
			expr = true,
			silent = true,
			noremap = true,
			replace_keycodes = false,
		})
	end,
}
