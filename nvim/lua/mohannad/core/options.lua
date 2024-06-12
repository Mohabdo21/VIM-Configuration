local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 4 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 4 -- 2 spaces for indent width
opt.expandtab = false -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = true -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = false -- highlight the current cursor line
-- vim.cmd([[highlight CursorLine guibg=#1E222A]])

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- enable code folding
opt.foldmethod = "syntax" -- fold based on syntax
opt.foldlevel = 0 -- start with all folds closed

-- Mouse support
opt.mouse = "a" -- Enable mouse support in all modes

-- Scrolling
opt.scrolljump = 5 -- Lines to scroll when the cursor goes off-screen
opt.scrolloff = 5 -- Lines of context around the cursor

-- Status line
opt.laststatus = 2 -- Always show the status line

-- Wild menu (command-line completion)
opt.wildmenu = true -- Enable wild menu
opt.wildmode = "list:longest" -- Command-line completion mode

-- Hidden buffers
opt.hidden = true -- Enable hidden buffers, allows you to switch buffers without saving

-- Highlight on yank
vim.cmd("au TextYankPost * lua vim.highlight.on_yank {on_visual = false}") -- Highlight when yanking

-- Show matching brackets/parentheses
opt.showmatch = true -- Show matching brackets/parentheses

-- Encoding
opt.encoding = "utf-8" -- Set default encoding to UTF-8

-- Filetype plugins and indentation
vim.cmd("filetype plugin indent on") -- Enable filetype plugins and indentation
