return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-cmdline", -- command line completion
		"hrsh7th/cmp-nvim-lsp", -- source for LSP
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*", -- Follow latest release
			build = "make install_jsregexp", -- Install jsregexp (optional)
		}, -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- for autocompletion with snippets
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- VS Code-like pictograms
	},
	config = function()
		-- Import required plugins
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- Load VS Code style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		-- `/` cmdline setup
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- `:` cmdline setup
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})

		-- Main completion setup
		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noselect",
			},
			snippet = { -- Configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- Previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- Next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll docs up
				["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll docs down
				["<C-Space>"] = cmp.mapping.complete(), -- Show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- Close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }), -- Confirm selection
			}),
			-- Sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- LSP completion
				{ name = "luasnip", keyword_length = 2 }, -- Snippets
				{ name = "buffer", keyword_length = 3 }, -- Text within current buffer
				{ name = "path" }, -- File system paths
			}),
			-- Configure lspkind for VS Code-like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})
	end,
}
