-- Neovim 0.11+ native LSP configuration.
-- Uses vim.lsp.config() + vim.lsp.enable() exclusively.

return {
	-- Anchor plugin: lazy.nvim needs a plugin name; nvim-lsp-file-operations
	-- is a real dependency, so it doubles as the carrier for our LSP config.
	"antosha417/nvim-lsp-file-operations",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"folke/lazydev.nvim",
		"folke/noice.nvim",
	},
	config = function()
		require("lsp-file-operations").setup()

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		capabilities.workspace = capabilities.workspace or {}
		capabilities.workspace.didChangeWatchedFiles = {
			dynamicRegistration = true,
		}

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

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
				vim.keymap.set("n", "<leader>rs", function()
					local buf = vim.api.nvim_get_current_buf()
					local clients = vim.lsp.get_clients({ bufnr = buf })
					for _, c in ipairs(clients) do
						vim.lsp.stop_client(c.id)
					end
					vim.defer_fn(function()
						vim.cmd("edit")
					end, 500)
				end, opts)

			end,
		})

		require("diagnostics")

		local function setup(server, cfg)
			vim.lsp.config(server, cfg or {})
			vim.lsp.enable(server)
		end

		local web_root = { "package.json", "tsconfig.json", ".git" }
		local git_root = { ".git" }

		setup("html", {
			cmd = { "vscode-html-language-server", "--stdio" },
			filetypes = { "html", "htmldjango" },
			root_markers = web_root,
		})

		setup("cssls", {
			cmd = { "vscode-css-language-server", "--stdio" },
			filetypes = { "css", "scss", "less" },
			root_markers = web_root,
		})

		setup("bashls", {
			cmd = { "bash-language-server", "start" },
			filetypes = { "sh", "bash", "zsh" },
			root_markers = git_root,
		})

		setup("docker_compose_language_service", {
			cmd = { "docker-compose-langserver", "--stdio" },
			filetypes = { "yaml.docker-compose" },
			root_markers = { "docker-compose.yml", "docker-compose.yaml", "compose.yml", "compose.yaml" },
		})

		setup("markdown_oxide", {
			cmd = { "markdown-oxide" },
			filetypes = { "markdown" },
			root_markers = { ".git", ".obsidian" },
		})

		setup("puppet", {
			cmd = { "puppet-languageserver", "--stdio" },
			filetypes = { "puppet" },
			root_markers = { "manifests", ".git" },
		})

		setup("typos_lsp", {
			cmd = { "typos-lsp" },
			-- No filetypes: attaches globally (spell checker)
			root_markers = git_root,
		})

		setup("ansiblels", {
			cmd = { "ansible-language-server", "--stdio" },
			filetypes = { "yaml.ansible" },
			root_markers = { "ansible.cfg", ".ansible-lint", "playbooks", "roles", ".git" },
		})

		setup("tinymist", {
			cmd = { "tinymist" },
			filetypes = { "typst" },
			root_markers = git_root,
		})

		setup("lua_ls", {
			cmd = { "lua-language-server" },
			filetypes = { "lua" },
			root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", "stylua.toml", ".git" },
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
					telemetry = { enable = false },
				},
			},
		})

		setup("pyright", {
			cmd = { "pyright-langserver", "--stdio" },
			filetypes = { "python" },
			root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "pyrightconfig.json", ".git" },
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

		local ts_lang_settings = {
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
		}

		setup("ts_ls", {
			cmd = { "typescript-language-server", "--stdio" },
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
			settings = {
				typescript = ts_lang_settings,
				javascript = ts_lang_settings,
			},
		})

		setup("tailwindcss", {
			cmd = { "tailwindcss-language-server", "--stdio" },
			filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
			root_markers = { "tailwind.config.js", "tailwind.config.cjs", "tailwind.config.mjs", "tailwind.config.ts" },
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
			cmd = { "vscode-json-language-server", "--stdio" },
			filetypes = { "json", "jsonc" },
			root_markers = git_root,
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
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
			root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", ".git" },
		})

		setup("dockerls", {
			cmd = { "docker-langserver", "--stdio" },
			filetypes = { "dockerfile" },
			root_markers = { "Dockerfile", ".git" },
			settings = {
				docker = {
					languageserver = { formatter = { ignoreMultilineInstructions = true } },
				},
			},
		})

		setup("gopls", {
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_markers = { "go.mod", "go.work", ".git" },
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
