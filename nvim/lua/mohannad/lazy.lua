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

local function get_python_venv()
	-- List of Python interpreters to check (in order of priority)
	local python_interpreters = {
		-- Active virtual environment
		os.getenv("VIRTUAL_ENV") and os.getenv("VIRTUAL_ENV") .. "/bin/python",
		-- Project virtual environment
		vim.fn.getcwd() .. "/.venv/bin/python",
		-- Global virtual environment
		vim.fn.expand("~/.pyenv/versions/neovim-py/bin/python"),
		-- System Python (found via PATH)
		vim.fn.exepath("python3") ~= "" and vim.fn.exepath("python3") or nil,
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

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

local lua_ver = _VERSION:match("%d+%.%d+")
package.cpath = package.cpath .. ";" .. os.getenv("HOME") .. "/.luarocks/lib/lua/" .. lua_ver .. "/?.so"

-- Set up the lazy.nvim plugin
require("lazy").setup({ { import = "mohannad.plugins" }, { import = "mohannad.plugins.lsp" } }, {
	install = {
		colorscheme = { "projekt0n/github-nvim-theme" },
	},
	checker = { enabled = true, notify = false },
	change_detection = { notify = false },
})
