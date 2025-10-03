-- Configure first with:
-- pyenv install -s 3.12.3
-- pyenv virtualenv 3.12.3 neovim-py
-- pyenv activate neovim-py
-- pip install --upgrade pip
-- pip install --upgrade pynvim
-- python -c "import pynvim, sys; print('pynvim', pynvim.__version__, 'python', sys.executable)"

-- Pin Neovim Python provider to dedicated pyenv virtualenv
vim.g.python3_host_prog = "/home/mohannad/.pyenv/versions/neovim-py/bin/python"

require("mohannad.core")
require("mohannad.lazy")

vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")
vim.cmd("highlight NotifyBackground guibg=#000000")
