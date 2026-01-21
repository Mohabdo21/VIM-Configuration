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
	-- List of Python interpreters to check (in order of priority)
	local python_interpreters = {
		-- Active virtual environment
		os.getenv("VIRTUAL_ENV") and os.getenv("VIRTUAL_ENV") .. "/bin/python",
		-- Project virtual environment
		vim.fn.getcwd() .. "/.venv/bin/python",
		-- Global virtual environment
		vim.fn.expand("/home/mohannad/.pyenv/versions/neovim-py/bin/python"),
		-- System Python
		"/usr/bin/python3",
	}

	-- Function to check if a Python interpreter is valid and has pynvim installed
	local function is_valid_python(python_path)
		if vim.fn.executable(python_path) == 0 then
			return false
		end

		-- Check if pynvim is installed
		local handle = io.popen(python_path .. " -c 'import pynvim; print(pynvim.__file__)' 2>&1")

		if not handle then
			return false
		end

		local result = handle:read("*a")
		handle:close()

		-- If the command succeeds, pynvim is installed
		return result and not result:match("ModuleNotFoundError")
	end

	-- Iterate through the list of interpreters and return the first valid one
	for _, python_path in ipairs(python_interpreters) do
		if python_path and is_valid_python(python_path) then
			return python_path
		end
	end

	-- If no valid interpreter is found, return nil
	return nil
end

-- Set python3_host_prog initially
local python_path = get_python_venv()
if python_path then
	vim.g.python3_host_prog = python_path
end

-- Automatically update python3_host_prog when changing directories
vim.api.nvim_create_autocmd("DirChanged", {
	pattern = "*",
	callback = function()
		vim.g.python3_host_prog = get_python_venv()
	end,
})

-- Set the Ruby host program
vim.g.ruby_host_prog = "neovim-ruby-host"

-- Set the perl host program
vim.g.perl_host_prog = "neovim-perl-host"

-- Disable Perl remote-plugins
vim.g.loaded_perl_provider = 0

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
