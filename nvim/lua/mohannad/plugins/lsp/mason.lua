return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"html", -- HTML
				"cssls", -- CSS
				"tailwindcss", -- Tailwind CSS
				"svelte", -- Svelte
				"lua_ls", -- Lua
				"graphql", -- GraphQL
				"emmet_ls", -- Emmet
				"prismals", -- Prisma
				"pyright", -- Python
				"pylsp", -- Python (alternative)
				"bashls", -- Bash
				"clangd", -- C/C++
				"dockerls", -- Dockerfile
				"docker_compose_language_service", -- Docker Compose
				"jsonls", -- JSON
				"markdown_oxide", -- Markdown
				"puppet", -- Puppet
				"hydra_lsp", -- Hydra
				"gopls", -- Go
				"eslint", -- JavaScript/TypeScript Linting
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- Code formatter
				"stylua", -- Lua formatter
				"isort", -- Python formatter
				"black", -- Python formatter
				"pylint", -- Python linter
				"eslint_d", -- JavaScript/TypeScript linter
				"eslint", -- JavaScript/TypeScript linter (alternative)
				"flake8", -- Python linter
				"shfmt", -- Shell formatter
				"clang-format", -- C/C++ formatter
			},
		})
	end,
}
