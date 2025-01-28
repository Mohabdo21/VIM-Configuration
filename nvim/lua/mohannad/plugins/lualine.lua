return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		-- local colors = {
		-- 	blue = "#65D1FF",
		-- 	green = "#3EFFDC",
		-- 	violet = "#FF61EF",
		-- 	yellow = "#FFDA7B",
		-- 	red = "#FF4A4A",
		-- 	fg = "#c3ccdc",
		-- 	bg = "#112638",
		-- 	inactive_bg = "#2c3043",
		-- }

		local colors = {
			blue = "#79b8ff", -- Soft Blue
			green = "#28a745", -- GitHub Green
			violet = "#b392f0", -- Light Violet
			yellow = "#ffd33d", -- GitHub Yellow
			red = "#d73a49", -- GitHub Red
			fg = "#d1d5da", -- Light Gray for text
			bg = "#2d333b", -- Darker Background
			inactive_bg = "#22272e", -- Dark Background for inactive sections
		}

		local my_lualine_theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
				b = { bg = colors.inactive_bg, fg = colors.semilightgray },
				c = { bg = colors.inactive_bg, fg = colors.semilightgray },
			},
		}

		-- configure lualine with modified theme
		-- lualine.setup({
		--   options = {
		--     theme = my_lualine_theme,
		--   },
		--   sections = {
		--     lualine_x = {
		--       {
		--         lazy_status.updates,
		--         cond = lazy_status.has_updates,
		--         color = { fg = "#ff9e64" },
		--       },
		--       { "encoding" },
		--       { "fileformat" },
		--       { "filetype" },
		--     },
		--   },
		-- })
		local function clock()
			return "🕒 " .. os.date("%H:%M")
		end

		lualine.setup({
			options = {
				theme = my_lualine_theme,
				-- section_separators = { "", "" },
				-- component_separators = { "", "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = {
					"filename",
					{
						"diagnostics",
						sources = { "nvim_lsp" },
						symbols = { error = " ", warn = " ", hint = "󰌶 ", info = " " },
					},
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = { clock },
				lualine_z = {},
			},
			tabline = {},
			extensions = { "fugitive" },
		})
		vim.cmd([[
			augroup ClockUpdate
			autocmd!
			autocmd CursorHold,CursorHoldI * lua vim.cmd('redrawstatus!')
			augroup END
		]])

		vim.o.updatetime = 1000
	end,
}
