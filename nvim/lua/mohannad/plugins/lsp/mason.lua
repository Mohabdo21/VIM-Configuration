return {
	"williamboman/mason.nvim",
	lazy = false,
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
			PATH = "skip",
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local servers = vim.list.unique({
			"html", -- HTML
			"cssls", -- CSS
			"tailwindcss", -- Tailwind CSS
			"lua_ls", -- Lua
			"pyright", -- Python
			"bashls", -- Bash
			"clangd", -- C/C++
			"dockerls", -- Dockerfile
			"docker_compose_language_service", -- Docker Compose
			"jsonls", -- JSON
			"markdown_oxide", -- Markdown
			"puppet", -- Puppet
			"gopls", -- Go
			"rust_analyzer", -- Rust
			"ts_ls", -- TypeScript
			"typos_lsp", -- Typo checking
			"ansiblels", -- Ansible
			"tinymist", -- Typst
		})

		mason_lspconfig.setup({
			ensure_installed = servers,
			automatic_enable = false,
		})

		local tools = vim.list.unique({
			"prettier", -- Code formatter
			"stylua", -- Lua formatter
			"isort", -- Python formatter
			"black", -- Python formatter
			"pylint", -- Python linter
			"eslint_d", -- JavaScript/TypeScript linter
			"oxlint", -- JavaScript/TypeScript linter
			"shfmt", -- Shell formatter
			"clang-format", -- C/C++ formatter
			"shellcheck", -- Shell linter
			"markdownlint", -- Markdown linter
			"yamllint", -- YAML linter
			"golangci-lint", -- Go linter
			"sqlfluff", -- SQL linter
			"sqlfmt", -- SQL formatter
		})

		mason_tool_installer.setup({
			ensure_installed = tools,
		})
	end,
}
