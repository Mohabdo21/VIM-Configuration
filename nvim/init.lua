-- Configure first with:
-- pyenv install -s 3.12.3
-- pyenv virtualenv 3.12.3 neovim-py
-- pyenv activate neovim-py
-- pip install --upgrade pip
-- pip install --upgrade pynvim
-- python -c "import pynvim, sys; print('pynvim', pynvim.__version__, 'python', sys.executable)"

-- Python provider is configured dynamically in lua/mohannad/lazy.lua

-- Ensure Mason bin is in PATH early so linters/formatters are found
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

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
	},
})
