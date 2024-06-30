return {
	--{
	--	"bluz71/vim-nightfly-guicolors",
	--	priority = 1000, -- make sure to load this before all the other start plugins
	--	config = function()
	--		-- load the colorscheme here
	--		vim.cmd([[colorscheme nightfly]])
	--	end,
	--},

	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("kanagawa").setup({
	-- 			compile = false, -- enable compiling the colorscheme
	-- 			undercurl = true, -- enable undercurls
	-- 			commentStyle = { italic = true },
	-- 			functionStyle = {},
	-- 			keywordStyle = { italic = true },
	-- 			statementStyle = { bold = true },
	-- 			typeStyle = {},
	-- 			transparent = false, -- do not set background color
	-- 			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	-- 			terminalColors = true, -- define vim.g.terminal_color_{0,17}
	-- 			colors = { -- add/modify theme and palette colors
	-- 				palette = {},
	-- 				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
	-- 			},
	-- 			overrides = function(colors) -- add/modify highlights
	-- 				return {}
	-- 			end,
	-- 			theme = "wave", -- Load "wave" theme when 'background' option is not set
	-- 			background = { -- map the value of 'background' option to a theme
	-- 				dark = "wave", -- try "dragon" !
	-- 				light = "lotus",
	-- 			},
	-- 		})
	-- 		vim.cmd([[colorscheme kanagawa]])
	-- 	end,
	-- },
	--
	{
		"projekt0n/github-nvim-theme",
		priority = 1000,
		config = function()
			require("github-theme").setup({
				options = {
					styles = {
						comments = "italic",
						keywords = "bold",
						types = "italic,bold",
					},
					darken = {
						floats = true,
						sidebars = { "true" },
					},
					hide_nc_statusline = false,
				},
			})
			vim.cmd([[colorscheme github_dark_default]])
		end,
	},
	-- {
	-- 	"lunacookies/vim-colors-xcode",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd("colorscheme xcodedark") -- or "xcodelight"
	-- 	end,
	-- },
	--{
	--	"folke/tokyonight.nvim",
	--	priority = 1000, -- make sure to load this before all the other start plugins
	--	config = function()
	--		local bg = "#011628"
	--		local bg_dark = "#011423"
	--		local bg_highlight = "#143652"
	--		local bg_search = "#0A64AC"
	--		local bg_visual = "#275378"
	--		local fg = "#CBE0F0"
	--		local fg_dark = "#B4D0E9"
	--		local fg_gutter = "#627E97"
	--		local border = "#547998"
	--
	--		require("tokyonight").setup({
	--			style = "night",
	--			on_colors = function(colors)
	--				colors.bg = bg
	--				colors.bg_dark = bg_dark
	--				colors.bg_float = bg_dark
	--				colors.bg_highlight = bg_highlight
	--				colors.bg_popup = bg_dark
	--				colors.bg_search = bg_search
	--				colors.bg_sidebar = bg_dark
	--				colors.bg_statusline = bg_dark
	--				colors.bg_visual = bg_visual
	--				colors.border = border
	--				colors.fg = fg
	--				colors.fg_dark = fg_dark
	--				colors.fg_float = fg
	--				colors.fg_gutter = fg_gutter
	--				colors.fg_sidebar = fg_dark
	--			end,
	--		})
	--		-- load the colorscheme here
	--		vim.cmd([[colorscheme tokyonight]])
	--	end,
	--},
}
