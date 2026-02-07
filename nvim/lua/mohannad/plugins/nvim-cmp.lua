return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local cmp = require("cmp")

		-- Kind icons (replaces lspkind.nvim) — using built-in CompletionItemKind symbols
		local kind_icons = {
			Text = "󰉿",
			Method = "󰆧",
			Function = "󰊕",
			Constructor = "",
			Field = "󰜢",
			Variable = "󰀫",
			Class = "󰠱",
			Interface = "",
			Module = "",
			Property = "󰜢",
			Unit = "󰑭",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "",
			Color = "󰏘",
			File = "󰈙",
			Reference = "󰈇",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "󰙅",
			Event = "",
			Operator = "󰆕",
			TypeParameter = "",
		}

		-- Main completion setup
		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noselect",
			},
			snippet = {
				-- Use Neovim 0.10+ native vim.snippet for LSP snippet expansion
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered({
					border = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
				}),
				documentation = cmp.config.window.bordered({
					border = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
					max_width = 80,
					max_height = 20,
				}),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),

				-- Tab: navigate cmp or jump in snippet
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif vim.snippet.active({ direction = 1 }) then
						vim.snippet.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif vim.snippet.active({ direction = -1 }) then
						vim.snippet.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),

				-- Enter to confirm
				["<CR>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.confirm({ select = true })
					else
						fallback()
					end
				end),
			}),

			-- Optimized source priority (no more luasnip source)
			sources = cmp.config.sources({
				{ name = "nvim_lsp", priority = 1000 },
				{ name = "buffer",   priority = 500, keyword_length = 3 },
				{ name = "path",     priority = 250 },
			}),

			-- Formatting with inline kind icons (replaces lspkind.nvim)
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "", vim_item.kind)
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						buffer = "[Buf]",
						path = "[Path]",
					})[entry.source.name]
					return vim_item
				end,
			},

			-- Performance settings
			performance = {
				debounce = 60,
				throttle = 30,
				fetching_timeout = 500,
				confirm_resolve_timeout = 80,
				async_budget = 1,
				max_view_entries = 200,
			},
		})

		-- Command line completion (optimized)
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

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
	end,
}
