-- Python provider uses system python with pynvim (see lua/mohannad/lazy.lua)
-- Node provider uses bun-installed neovim package
vim.g.node_host_prog = vim.fn.expand("~/.cache/.bun/bin/neovim-node-host")

-- Ensure Mason bin is in PATH early so linters/formatters are found
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

-- nvim-tree recommends disabling netrw before any plugin setup.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("mohannad.core")
require("mohannad.lazy")

vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")
vim.cmd("highlight NotifyBackground guibg=#000000")

vim.filetype.add({
	filename = {
		["docker-compose.yml"] = "yaml.docker-compose",
		["docker-compose.yaml"] = "yaml.docker-compose",
		["compose.yml"] = "yaml.docker-compose",
		["compose.yaml"] = "yaml.docker-compose",
		["Caddyfile"] = "caddy",
		["go.work"] = "gowork",
	},
	pattern = {
		-- Ansible: playbooks/, roles/, or files near ansible.cfg / .ansible-lint
		[".*/playbooks/.*.ya?ml"] = "yaml.ansible",
		[".*/roles/.*.ya?ml"] = "yaml.ansible",
		[".*/handlers/.*.ya?ml"] = "yaml.ansible",
		[".*/tasks/.*.ya?ml"] = "yaml.ansible",
		-- Go templates
		[".*.go%.tmpl"] = "gotmpl",
		[".*.go%.html"] = "gotmpl",
		[".*.gotmpl"] = "gotmpl",
		-- Puppet manifests
		[".*.pp"] = "puppet",
	},
})
