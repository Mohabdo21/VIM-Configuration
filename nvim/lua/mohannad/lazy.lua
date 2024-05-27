local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.python3_host_prog = "python3.10"
vim.api.nvim_command("lua package.cpath = package.cpath .. ';$HOME/.luarocks/lib/lua/5.1/?.so'")
require("lazy").setup({ { import = "mohannad.plugins" }, { import = "mohannad.plugins.lsp" } }, {
	install = {
		colorscheme = { "projekt0n/github-nvim-theme" },
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
