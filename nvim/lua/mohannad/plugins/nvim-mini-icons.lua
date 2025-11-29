-- Using mini.icons from the full mini.nvim suite instead of standalone
return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		-- Setup mini.icons from the suite
		require("mini.icons").setup()

		-- Mock nvim-web-devicons for compatibility with other plugins
		MiniIcons.mock_nvim_web_devicons()
	end,
}
