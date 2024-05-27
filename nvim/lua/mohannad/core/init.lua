vim.cmd("set noexpandtab") -- Use tabs, not spaces
vim.cmd("set tabstop=4") -- A tab is equal to 4 spaces
vim.cmd("set softtabstop=4") -- Use 4 spaces when <Tab> or <BS> is pressed
vim.cmd("set shiftwidth=4") -- Use 4 spaces when auto-indenting

vim.cmd([[
  autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
]])

require("mohannad.core.keymaps")
require("mohannad.core.options")
