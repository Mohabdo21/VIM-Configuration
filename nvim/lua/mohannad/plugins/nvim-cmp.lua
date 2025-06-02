return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind.nvim",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
			config = function()
				local luasnip = require("luasnip")

				-- Performance-optimized LuaSnip configuration
				luasnip.config.set_config({
					history = true,
					updateevents = "TextChanged,TextChangedI",
					enable_autosnippets = false, -- Disable if you don't use auto-snippets
					cut_selection_keys = "<Tab>",
					delete_check_events = "TextChanged", -- Better performance
				})

				-- Efficient snippet loading strategy
				local function load_snippets_for_filetype(filetype)
					-- Only load vscode snippets (most common and fastest)
					require("luasnip.loaders.from_vscode").lazy_load({
						include = { filetype },
					})

					-- Optionally load custom snippets if they exist
					local custom_snippet_path = vim.fn.stdpath("config") .. "/snippets/" .. filetype .. ".json"
					if vim.fn.filereadable(custom_snippet_path) == 1 then
						require("luasnip.loaders.from_vscode").lazy_load({
							paths = { vim.fn.stdpath("config") .. "/snippets/" },
						})
					end
				end

				-- Load snippets only when needed for specific filetypes
				local loaded_filetypes = {}
				vim.api.nvim_create_autocmd("FileType", {
					callback = function(event)
						local filetype = event.match
						if not loaded_filetypes[filetype] then
							load_snippets_for_filetype(filetype)
							loaded_filetypes[filetype] = true
						end
					end,
				})

				-- Load common snippets immediately (only for current buffer)
				local current_ft = vim.bo.filetype
				if current_ft and current_ft ~= "" then
					load_snippets_for_filetype(current_ft)
					loaded_filetypes[current_ft] = true
				end

				-- Extend filetypes with doc snippets (only if needed)
				local doc_filetypes = {
					"typescript",
					"javascript",
					"lua",
					"python",
					"rust",
					"cs",
					"java",
					"c",
					"go",
					"html",
					"cpp",
					"php",
					"kotlin",
					"ruby",
					"sh",
					"sql",
				}

				for _, ft in ipairs(doc_filetypes) do
					luasnip.filetype_extend(ft, { ft .. "doc" })
				end
			end,
		},
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- Enhanced key mappings with better LuaSnip integration
		local function has_words_before()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		-- Main completion setup
		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noselect",
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered({
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
				}),
				documentation = cmp.config.window.bordered({
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
				}),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),

				-- Enhanced Tab behavior for snippets
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expandable() then
						luasnip.expand()
					elseif luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					elseif has_words_before() then
						cmp.complete()
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

				-- Enhanced Enter behavior
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
			}),

			-- Optimized source priority
			sources = cmp.config.sources({
				{ name = "nvim_lsp", priority = 1000 },
				{ name = "luasnip", priority = 750 },
				{ name = "buffer", priority = 500, keyword_length = 3 },
				{ name = "path", priority = 250 },
			}),

			-- Enhanced formatting
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "...",
					show_labelDetails = true,
					before = function(entry, vim_item)
						-- Add source name to menu
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							luasnip = "[Snip]",
							buffer = "[Buf]",
							path = "[Path]",
						})[entry.source.name]
						return vim_item
					end,
				}),
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
