-- Using mini.icons from the full mini.nvim suite instead of standalone
return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.icons").setup({
			extension = {
				gql = { glyph = "", hl = "MiniIconsPurple" },
			},
		})

		-- Mock nvim-web-devicons for compatibility with other plugins
		require("mini.icons").mock_nvim_web_devicons()
	end,
}
