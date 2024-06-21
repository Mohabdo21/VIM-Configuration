-- Define the path to the lazy.nvim plugin
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if the lazy.nvim plugin is already installed
if not vim.loop.fs_stat(lazypath) then
	-- If not, clone the plugin from GitHub
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- Use the latest stable release
		lazypath,
	})
end

-- Add the lazy.nvim plugin to the runtime path
vim.opt.rtp:prepend(lazypath)

-- Set the Python 3 host program to Python 3.10
vim.g.python3_host_prog = "python3.10"

-- Set the Ruby host program
vim.g.ruby_host_prog = "/usr/local/bin/neovim-ruby-host"

-- Add the LuaRocks path to the package.cpath
vim.api.nvim_command("lua package.cpath = package.cpath .. ';$HOME/.luarocks/lib/lua/5.1/?.so'")

-- Set up the lazy.nvim plugin
require("lazy").setup({ { import = "mohannad.plugins" }, { import = "mohannad.plugins.lsp" } }, {
	install = {
		-- Use the GitHub theme for the color scheme
		colorscheme = { "projekt0n/github-nvim-theme" },
		-- colorscheme = { "lunacookies/vim-colors-xcode" },
	},
	checker = {
		-- Enable the checker
		enabled = true,
		-- Disable notifications for the checker
		notify = false,
	},
	change_detection = {
		-- Disable notifications for change detection
		notify = false,
	},
})
