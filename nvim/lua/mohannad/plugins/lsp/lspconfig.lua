return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"folke/lazydev.nvim",
		"folke/noice.nvim",
	},
	config = function()
		-- Neovim 0.11+ LSP configuration using native vim.lsp.config + vim.lsp.enable API.
		-- See :help lsp-config

		-- Shared capabilities for all servers via the '*' wildcard config.
		-- This is merged into every server automatically (see :help lsp-config-merge).
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		capabilities.workspace = capabilities.workspace or {}
		capabilities.workspace.didChangeWatchedFiles = {
			dynamicRegistration = true,
		}

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- Buffer-local keymaps via LspAttach autocmd (replaces the old on_attach pattern).
		-- Neovim 0.11+ provides built-in defaults for:
		--   K (hover), [d / ]d (diagnostics), grr (references), gra (code action),
		--   grn (rename), gri (implementation), grt (type def), gO (document symbols),
		--   Ctrl-S in insert mode (signature help).
		-- We only define keymaps that enhance or override the defaults (e.g. Telescope pickers).
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspKeymaps", {}),
			callback = function(args)
				local opts = { buffer = args.buf, silent = true }

				opts.desc = "Show LSP references (Telescope)"
				vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions (Telescope)"
				vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations (Telescope)"
				vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions (Telescope)"
				vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics (Telescope)"
				vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>rs", "<cmd>lsp restart<CR>", opts)
			end,
		})

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
			"ansiblels", -- Ansible
			"tinymist", -- Typst
		}

		-- Helper: define server-specific config + enable.
		-- Shared capabilities are inherited from the '*' config automatically.
		local function setup(server, cfg)
			vim.lsp.config(server, cfg or {})
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
