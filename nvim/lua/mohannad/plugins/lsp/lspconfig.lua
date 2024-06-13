return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	version = "*",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"folke/noice.nvim",
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Ensure workspace is initialized
		capabilities.workspace = capabilities.workspace or {}
		capabilities.workspace.didChangeWatchedFiles = {
			dynamicRegistration = true,
		}

		-- Configure diagnostics
		vim.diagnostic.config({
			virtual_text = false,
			signs = {
				active = {
					{ name = "DiagnosticSignError", text = " " },
					{ name = "DiagnosticSignWarn", text = " " },
					{ name = "DiagnosticSignHint", text = "󰠠 " },
					{ name = "DiagnosticSignInfo", text = " " },
				},
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		-- Define diagnostic signs
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
					handlers = {
						["workspace/diagnostic/refresh"] = function(err, result, ctx, config)
							-- Log the refresh request
							vim.lsp.log.info("workspace/diagnostic/refresh request received")
							-- Trigger a diagnostic refresh
							vim.lsp.diagnostic.on_publish_diagnostics(
								nil,
								result,
								{ method = ctx.method, client_id = ctx.client_id, bufnr = ctx.bufnr, config = config }
							)
						end,
					},
				})
			end,
			["svelte"] = function()
				-- configure svelte server
				lspconfig["svelte"].setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.js", "*.ts" },
							callback = function(ctx)
								-- Here use ctx.match instead of ctx.file
								client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
							end,
						})
					end,
				})
			end,
			["graphql"] = function()
				-- configure graphql language server
				lspconfig["graphql"].setup({
					capabilities = capabilities,
					filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
				})
			end,
			["emmet_ls"] = function()
				-- configure emmet language server
				lspconfig["emmet_ls"].setup({
					capabilities = capabilities,
					filetypes = {
						"html",
						"typescriptreact",
						"javascriptreact",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
					},
				})
			end,
			["pyright"] = function()
				-- configure Python server
				lspconfig["pyright"].setup({
					capabilities = capabilities,
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "workspace", -- Analyze all files in the workspace
								autoImportCompletions = true,
							},
						},
					},
					on_attach = function(client, bufnr)
						-- Custom on_attach function to set up additional keymaps or commands if needed
					end,
				})
			end,
			["tsserver"] = function()
				-- configure TypeScript server
				lspconfig["tsserver"].setup({
					capabilities = capabilities,
				})
			end,
			["bashls"] = function()
				-- configure Bash server
				lspconfig["bashls"].setup({
					capabilities = capabilities,
				})
			end,
			["ast_grep"] = function()
				lspconfig["ast_grep"].setup({
					capabilities = capabilities,
				})
			end,
			["autotools_ls"] = function()
				lspconfig["autotools_ls"].setup({
					capabilities = capabilities,
				})
			end,
			["clangd"] = function()
				lspconfig["clangd"].setup({
					capabilities = capabilities,
				})
			end,
			["cssls"] = function()
				lspconfig["cssls"].setup({
					capabilities = capabilities,
				})
			end,
			["docker_compose_language_service"] = function()
				lspconfig["docker_compose_language_service"].setup({
					capabilities = capabilities,
				})
			end,
			["dockerls"] = function()
				lspconfig["dockerls"].setup({
					capabilities = capabilities,
				})
			end,
			["eslint"] = function()
				lspconfig["eslint"].setup({
					capabilities = capabilities,
				})
			end,
			["html"] = function()
				lspconfig["html"].setup({
					capabilities = capabilities,
				})
			end,
			["hydra_lsp"] = function()
				lspconfig["hydra_lsp"].setup({
					capabilities = capabilities,
				})
			end,
			["jsonls"] = function()
				lspconfig["jsonls"].setup({
					capabilities = capabilities,
				})
			end,
			["markdown_oxide"] = function()
				lspconfig["markdown_oxide"].setup({
					capabilities = capabilities,
				})
			end,
			["prismals"] = function()
				lspconfig["prismals"].setup({
					capabilities = capabilities,
				})
			end,
			["puppet"] = function()
				lspconfig["puppet"].setup({
					capabilities = capabilities,
				})
			end,
			["quick_lint_js"] = function()
				lspconfig["quick_lint_js"].setup({
					capabilities = capabilities,
				})
			end,
			["tailwindcss"] = function()
				lspconfig["tailwindcss"].setup({
					capabilities = capabilities,
				})
			end,
			["sql-language-server"] = function()
				lspconfig["sqlls"].setup({
					capabilities = capabilities,
				})
			end,
			["typos_lsp"] = function()
				lspconfig["typos_lsp"].setup({
					capabilities = capabilities,
				})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
		})
	end,
}
