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
-- vim.g.python3_host_prog = "/usr/bin/python3"

-- Lua function to detect Python virtual environment and set python3_host_prog
local function get_python_venv()
	-- Check if VIRTUAL_ENV is set, indicating an active venv
	local venv_path = os.getenv("VIRTUAL_ENV")
	if venv_path then
		return venv_path .. "/bin/python"
	end

	-- If no VIRTUAL_ENV, check for .venv in the current directory
	local project_venv = vim.fn.getcwd() .. "/.venv/bin/python"
	if vim.fn.filereadable(project_venv) == 1 then
		return project_venv
	end

	-- Default to system Python
	return "/usr/bin/python3"
end

-- Set python3_host_prog initially
vim.g.python3_host_prog = get_python_venv()

-- Automatically update python3_host_prog when changing directories
vim.api.nvim_create_autocmd("DirChanged", {
	pattern = "*",
	callback = function()
		vim.g.python3_host_prog = get_python_venv()
	end,
})

-- Set the Ruby host program
vim.g.ruby_host_prog = "neovim-ruby-host"

-- Add the LuaRocks path to the package.cpath
vim.api.nvim_command("lua package.cpath = package.cpath .. ';$HOME/.luarocks/lib/lua/5.1/?.so'")

-- Set up the lazy.nvim plugin
require("lazy").setup({ { import = "mohannad.plugins" }, { import = "mohannad.plugins.lsp" } }, {
	install = {
		-- Use the GitHub theme for the color scheme
		colorscheme = { "projekt0n/github-nvim-theme" },
		-- colorscheme = { "lunacookies/vim-colors-xcode" },
		-- Kanagwa colorscheme
		-- colorscheme = { "rebelot/kanagawa.nvim" },
		-- colorscheme = { "folke/tokyonight.nvim" },
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
