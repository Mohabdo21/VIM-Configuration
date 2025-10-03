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
		-- Neovim 0.11+ only configuration: use core vim.lsp.config interface directly.
		-- We intentionally drop backward compatibility with the deprecated
		-- require('lspconfig')[server].setup() framework.
		-- See :help lspconfig-nvim-0.11
		pcall(require, "lspconfig.configs") -- ensure configs are discoverable

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
			"ansiblels", -- Ansible
		}

		-- Helper for new API: define + enable a server
		local function setup(server, cfg)
			vim.lsp.config(
				server,
				vim.tbl_deep_extend("force", {
					capabilities = capabilities,
					on_attach = on_attach,
				}, cfg or {})
			)
			vim.lsp.enable(server)
		end

		-- Basic servers with no extra settings
		for _, server in ipairs(servers) do
			setup(server, {})
		end

		-- Special / custom servers with extra settings
		setup("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
					telemetry = { enable = false },
				},
			},
		})

		setup("pyright", {
			settings = {
				python = {
					analysis = {
						diagnosticMode = "openFilesOnly",
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						autoImportCompletions = true,
						typeCheckingMode = "basic",
						completeFunctionParens = true,
					},
				},
			},
		})

		setup("ts_ls", {
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
					suggest = { autoImports = true, completeFunctionCalls = true },
					updateImportsOnFileMove = { enabled = "always" },
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
					suggest = { autoImports = true, completeFunctionCalls = true },
					updateImportsOnFileMove = { enabled = "always" },
				},
			},
		})

		setup("tailwindcss", {
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

		setup("jsonls", {
			settings = {
				json = {
					schemas = {
						{ fileMatch = { "package.json" }, url = "https://json.schemastore.org/package.json" },
						{ fileMatch = { "tsconfig.json" }, url = "https://json.schemastore.org/tsconfig.json" },
					},
					validate = { enable = true },
				},
			},
		})

		setup("clangd", {
			cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
		})

		setup("dockerls", {
			settings = {
				docker = {
					languageserver = { formatter = { ignoreMultilineInstructions = true } },
				},
			},
		})

		setup("gopls", {
			settings = {
				gopls = {
					completeFunctionCalls = true,
					completeUnimported = true,
					sortImports = true,
					directoryFilters = { "-.git", "-node_modules" },
					memoryMode = "DegradeClosed",
					analyses = {
						unusedparams = true,
						unreachable = true,
						nilness = true,
						unusedwrite = true,
						unusedvariable = true,
						shadow = true,
					},
				},
			},
		})
	end,
}
