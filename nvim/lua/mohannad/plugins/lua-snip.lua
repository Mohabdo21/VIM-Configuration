return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
	dependencies = { "rafamadriz/friendly-snippets", "benfowler/telescope-luasnip.nvim" },

	config = function(_, opts)
		if opts then
			require("luasnip").config.setup(opts)
		end
		vim.tbl_map(function(type)
			require("luasnip.loaders.from_" .. type).lazy_load()
		end, { "vscode", "snipmate", "lua" })
		-- friendly-snippets - enable standardized comments snippets
		require("luasnip").filetype_extend("typescript", { "tsdoc" })
		require("luasnip").filetype_extend("javascript", { "jsdoc" })
		require("luasnip").filetype_extend("lua", { "luadoc" })
		require("luasnip").filetype_extend("python", { "pydoc" })
		require("luasnip").filetype_extend("rust", { "rustdoc" })
		require("luasnip").filetype_extend("cs", { "csharpdoc" })
		require("luasnip").filetype_extend("java", { "javadoc" })
		require("luasnip").filetype_extend("c", { "cdoc" })
		require("luasnip").filetype_extend("cpp", { "cppdoc" })
		require("luasnip").filetype_extend("php", { "phpdoc" })
		require("luasnip").filetype_extend("kotlin", { "kdoc" })
		require("luasnip").filetype_extend("ruby", { "rdoc" })
		require("luasnip").filetype_extend("sh", { "shelldoc" })
		require("luasnip").filetype_extend("sql", { "sqldoc" })

		local luasnip = require("luasnip")
		local cmp = require("cmp")
		cmp.setup({

			-- ... Your other configuration ...

			mapping = {

				-- ... Your other mappings ...
				["<CR>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						if luasnip.expandable() then
							luasnip.expand()
						else
							cmp.confirm({
								select = true,
							})
						end
					else
						fallback()
					end
				end),

				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),

				-- ... Your other mappings ...
			},

			-- ... Your other configuration ...
		})
	end,
}
