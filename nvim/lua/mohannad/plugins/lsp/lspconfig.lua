return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"folke/noice.nvim",
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- Shared capabilities
		local capabilities = cmp_nvim_lsp.default_capabilities()
		capabilities.workspace = capabilities.workspace or {}
		capabilities.workspace.didChangeWatchedFiles = {
			dynamicRegistration = true,
		}

		-- Shared on_attach function
		local on_attach = function(client, bufnr)
			local keymap = vim.keymap
			local opts = { buffer = bufnr, silent = true }

			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts)

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
		end

		-- Configure diagnostics
		require("diagnostics")

		-- Configure common LSP servers
		local servers = {
			"html", -- HTML
			"cssls", -- CSS
			"bashls", -- Bash
			"docker_compose_language_service", -- Docker Compose
			"markdown_oxide", -- Markdown
			"puppet", -- Puppet
			"typos_lsp", -- Spell checking
			"csharp_ls", -- C#
		}

		for _, server in ipairs(servers) do
			lspconfig[server].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end

		-- Configure special LSP servers
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
					telemetry = { enable = false },
				},
			},
		})

		lspconfig["pyright"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				python = {
					analysis = {
						diagnosticMode = "openFilesOnly", -- Only analyze open files
						autoSearchPaths = true, -- Automatically add common Python paths
						useLibraryCodeForTypes = true, -- Use library code for type inference
						autoImportCompletions = true, -- Enable auto-import completions
						typeCheckingMode = "basic", -- Set type checking mode to "basic"
						completeFunctionParens = true, -- Complete function parentheses
					},
				},
			},
		})

		lspconfig["ts_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
					suggest = {
						autoImports = true,
						completeFunctionCalls = true,
					},
					updateImportsOnFileMove = {
						enabled = "always",
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
					suggest = {
						autoImports = true,
						completeFunctionCalls = true,
					},
					updateImportsOnFileMove = {
						enabled = "always",
					},
				},
			},
		})

		lspconfig["tailwindcss"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				tailwindCSS = {
					experimental = {
						classRegex = {
							"tw`([^`]*)",
							'tw="([^"]*)',
							'tw={"([^"}]*)',
						},
					},
				},
			},
		})

		lspconfig["jsonls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				json = {
					schemas = {
						{
							fileMatch = { "package.json" },
							url = "https://json.schemastore.org/package.json",
						},
						{
							fileMatch = { "tsconfig.json" },
							url = "https://json.schemastore.org/tsconfig.json",
						},
					},
					validate = { enable = true },
				},
			},
		})

		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=never",
			},
		})

		lspconfig["dockerls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				docker = {
					languageserver = {
						formatter = {
							ignoreMultilineInstructions = true,
						},
					},
				},
			},
		})

		lspconfig["gopls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				gopls = {
					completeFunctionCalls = true, -- Complete function calls
					completeUnimported = true, -- Complete unimported packages
					sortImports = true, -- Sort imports
					directoryFilters = { "-.git", "-node_modules" }, -- Exclude .git and node_modules directories
					memoryMode = "DegradeClosed", -- Use degraded memory mode for closed files
					analyses = {
						unusedparams = true, -- Highlight unused parameters
						unreachable = true, -- Highlight unreachable code
						nilness = true, -- Detect nil pointer dereferences
						unusedwrite = true, -- Highlight unused writes
						unusedvariable = true, -- Highlight unused variables
						shadow = true, -- Highlight shadowed variables
					},
				},
			},
		})
	end,
}
