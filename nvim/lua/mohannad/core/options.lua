local opt = vim.opt

-- Line numbers
opt.number = true

-- Tabs & indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.autoindent = true

-- C files use spaces
vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	callback = function()
		vim.opt_local.expandtab = true
	end,
})

-- Line wrapping
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = false

-- Cursor line
opt.cursorline = false

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Swap
opt.swapfile = false

-- Folding
opt.foldmethod = "syntax"
opt.foldlevel = 0

-- Scrolling
opt.scrolljump = 5
opt.scrolloff = 5

-- Command-line completion
opt.wildmode = "list:longest"

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ on_visual = false })
	end,
})

-- Matching brackets
opt.showmatch = true

-- Virtual block editing
opt.virtualedit = "block"
