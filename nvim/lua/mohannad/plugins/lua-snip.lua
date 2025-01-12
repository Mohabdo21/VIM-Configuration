return {
	"L3MON4D3/LuaSnip",
	version = "v2.*", -- Follow latest release
	build = "make install_jsregexp", -- Install jsregexp (optional)
	dependencies = {
		"rafamadriz/friendly-snippets", -- Useful snippets
		"benfowler/telescope-luasnip.nvim", -- Telescope integration
	},
	config = function(_, opts)
		local luasnip = require("luasnip")
		local cmp = require("cmp")

		-- Load snippets from vscode, snipmate, and lua
		vim.tbl_map(function(type)
			require("luasnip.loaders.from_" .. type).lazy_load()
		end, { "vscode", "snipmate", "lua" })

		-- Extend filetypes with standardized comment snippets
		local filetypes = {
			"typescript",
			"javascript",
			"lua",
			"python",
			"rust",
			"cs",
			"java",
			"c",
			"cpp",
			"php",
			"kotlin",
			"ruby",
			"sh",
			"sql",
		}
		for _, ft in ipairs(filetypes) do
			luasnip.filetype_extend(ft, { ft .. "doc" })
		end

		-- Lazy-load snippets for specific filetypes
		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function()
				local filetype = vim.bo.filetype
				require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/" .. filetype } })
			end,
		})

		-- Integrate with nvim-cmp
		cmp.setup({
			mapping = {
				["<CR>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						if luasnip.expandable() then
							luasnip.expand()
						else
							cmp.confirm({ select = true })
						end
					else
						fallback()
					end
				end),
				["<Tab>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			},
		})

		-- Enable Telescope for snippet search
		require("telescope").load_extension("luasnip")
		vim.keymap.set("n", "<leader>ss", "<cmd>Telescope luasnip<cr>", { desc = "Search Snippets" })
	end,
}
