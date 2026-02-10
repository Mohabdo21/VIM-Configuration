# Neovim Configuration

Neovim 0.11+ config. Native features first, plugins only when they do something Neovim can't.

## What's Gone

Neovim 11 killed the need for these. They're removed:

- **LuaSnip / friendly-snippets** → native `vim.snippet`
- **nvim-lspconfig** → native `vim.lsp.config()` + `vim.lsp.enable()`
- **comment.nvim** → native commenting (`gc`)
- **dressing.nvim** → noice.nvim + `vim.ui.select`
- **lspkind.nvim** → kind icons defined inline in nvim-cmp
- **none-ls / null-ls** → conform.nvim (formatting) + nvim-lint (linting)

## Structure

```
nvim/
├── init.lua                  Entry point: PATH, core requires, filetype rules
└── lua/mohannad/
    ├── lazy.lua              lazy.nvim bootstrap, Python provider auto-detection
    ├── core/
    │   ├── init.lua          Loads keymaps + options
    │   ├── keymaps.lua       Keybindings (leader = Space)
    │   ├── options.lua       Editor options
    │   └── diagnostics.lua   Diagnostic config (signs, floats, severity)
    └── plugins/
        ├── init.lua          Always loaded: plenary, vim-tmux-navigator, copilot
        ├── lsp/
        │   ├── lspconfig.lua Native LSP (vim.lsp.config/enable) + keymaps
        │   └── mason.lua     Mason: auto-install servers/tools
        └── ...               Everything else
```

## Plugins

### LSP & Completion

LSP is configured natively with `vim.lsp.config()` + `vim.lsp.enable()`. No nvim-lspconfig. Snippets use native `vim.snippet`.

| Plugin                                                          | What it does                                   |
| --------------------------------------------------------------- | ---------------------------------------------- |
| **mason.nvim** + **mason-lspconfig** + **mason-tool-installer** | Auto-installs LSP servers, formatters, linters |
| **nvim-lsp-file-operations**                                    | LSP-aware file rename/move                     |
| **nvim-cmp**                                                    | Completion (LSP, buffer, path, cmdline)        |
| **nvim-autopairs**                                              | Auto-close brackets/quotes                     |
| **lazydev.nvim**                                                | Lua LSP: `vim.*` type hints                    |

**Language servers:** html, cssls, tailwindcss, ts_ls, lua_ls, pyright, bashls, clangd, dockerls, docker_compose_language_service, jsonls, markdown_oxide, puppet, gopls, typos_lsp, ansiblels, tinymist.

### Formatting & Linting

| Plugin           | What it does                                                                                            |
| ---------------- | ------------------------------------------------------------------------------------------------------- |
| **conform.nvim** | Format on save — prettier, eslint_d, stylua, isort, black, clang-format, shfmt, sqlfmt, gofmt, rustfmt  |
| **nvim-lint**    | Async lint — eslint_d, pylint, golangci-lint, puppet-lint, shellcheck, markdownlint, yamllint, sqlfluff |

### Navigation

| Plugin                       | What it does                                           |
| ---------------------------- | ------------------------------------------------------ |
| **telescope.nvim**           | Fuzzy finder: files, grep, buffers, symbols, git, undo |
| **telescope-fzf-native**     | Native FZF sorting                                     |
| **telescope-live-grep-args** | Grep with rg flags                                     |
| **telescope-undo**           | Undo history browser                                   |
| **telescope-ui-select**      | Routes `vim.ui.select` through Telescope               |
| **telescope-smart-goto**     | Smart goto                                             |
| **advanced-git-search**      | Git log/diff search                                    |
| **harpoon**                  | File bookmarks                                         |

### Treesitter

| Plugin                          | What it does                                             |
| ------------------------------- | -------------------------------------------------------- |
| **nvim-treesitter**             | Highlighting + auto-install parsers                      |
| **nvim-treesitter-textobjects** | Select/swap/move by function, class, conditional, loop   |
| **nvim-ts-autotag**             | Auto-close HTML/JSX tags                                 |
| **nvim-various-textobjs**       | 30+ extra text objects (subword, url, indentation, etc.) |

### UI

| Plugin                                | What it does                                  |
| ------------------------------------- | --------------------------------------------- |
| **github-nvim-theme**                 | Colorscheme (`github_dark_default`)           |
| **lualine**                           | Statusline — mode colors, diagnostics, clock  |
| **bufferline**                        | Tab bar with LSP diagnostics                  |
| **alpha-nvim**                        | Dashboard                                     |
| **nvim-tree**                         | File explorer                                 |
| **noice** + **nvim-notify** + **nui** | Modern cmdline, messages, notifications       |
| **which-key**                         | Keybinding popup                              |
| **nvim-highlight-colors**             | Inline color rendering (hex, named, Tailwind) |
| **nvim-colorizer**                    | Color code highlighting                       |
| **mini.nvim**                         | Icons (mocks nvim-web-devicons)               |
| **nvim-web-devicons**                 | Filetype icons                                |
| **render-markdown**                   | Rich markdown rendering                       |

### Git

| Plugin       | What it does                               |
| ------------ | ------------------------------------------ |
| **gitsigns** | Diff signs, hunk stage/reset, inline blame |
| **lazygit**  | Git TUI (`<leader>lg`)                     |

### Editing

| Plugin            | What it does                                         |
| ----------------- | ---------------------------------------------------- |
| **nvim-surround** | Surround pairs                                       |
| **substitute**    | Operator-based substitution                          |
| **neogen**        | Generate doc comments (JSDoc, Google, Doxygen, etc.) |
| **todo-comments** | Highlight/search TODO, FIXME, HACK                   |

### Sessions

| Plugin                     | What it does                                       |
| -------------------------- | -------------------------------------------------- |
| **neovim-session-manager** | Manual session save/load/delete                    |
| **auto-session**           | Auto session save/restore (`<leader>as` to search) |

### Other

| Plugin                 | What it does                          |
| ---------------------- | ------------------------------------- |
| **plenary**            | Lua utility library (dependency)      |
| **vim-tmux-navigator** | Tmux ↔ Neovim split navigation        |
| **copilot.vim**        | GitHub Copilot (`Alt-l` to accept)    |
| **vim-maximizer**      | Maximize/restore split (`<leader>sm`) |
| **undotree**           | Undo tree (`F5`)                      |

## Key Bindings

Leader is **Space**. This is not exhaustive — run `<leader>fk` or `<leader>?` to see everything.

### General

| Key                               | Action                                         |
| --------------------------------- | ---------------------------------------------- |
| `jk`                              | Exit insert mode                               |
| `<leader>nh`                      | Clear search highlights                        |
| `<leader>+` / `-`                 | Increment / decrement number                   |
| `<leader>sv` / `sh` / `se` / `sx` | Split vertical / horizontal / equalize / close |
| `<leader>sm`                      | Maximize/restore split                         |

### Files & Search

| Key                 | Action                                  |
| ------------------- | --------------------------------------- |
| `<leader>ee` / `ef` | Toggle explorer / find file in explorer |
| `<leader>ff`        | Find files                              |
| `<leader>fg`        | Live grep (with args)                   |
| `<leader>fc`        | Grep in cwd                             |
| `<leader>fb`        | Buffers                                 |
| `<leader>fr`        | Recent files                            |
| `<leader>fs`        | Document symbols                        |
| `<leader>fw`        | Grep word under cursor                  |
| `<leader>ft`        | TODOs                                   |
| `<leader>fk`        | Keymaps                                 |
| `<leader>/`         | Fuzzy search in buffer                  |

### LSP

| Key                       | Action                                     |
| ------------------------- | ------------------------------------------ |
| `gd` / `gD`               | Definition / declaration                   |
| `gR` / `gi` / `gt`        | References / implementations / type defs   |
| `<leader>ca`              | Code action                                |
| `<leader>rn`              | Rename                                     |
| `<leader>D` / `<leader>d` | Buffer diagnostics / line diagnostic float |
| `<leader>rs`              | Restart LSP                                |
| `<leader>mp`              | Format file (or visual range)              |
| `<leader>l`               | Lint current file                          |

### Git

| Key                        | Action                 |
| -------------------------- | ---------------------- |
| `<leader>lg`               | LazyGit                |
| `<leader>hs` / `hr`        | Stage / reset hunk     |
| `<leader>hS` / `hR`        | Stage / reset buffer   |
| `<leader>hp` / `hb` / `hd` | Preview / blame / diff |
| `]c` / `[c`                | Next / prev hunk       |

### Harpoon

| Key                 | Action             |
| ------------------- | ------------------ |
| `<leader>hm`        | Mark file          |
| `<leader>hn` / `hP` | Next / prev mark   |
| `<leader>he`        | Remove mark        |
| `<leader>hq`        | Marks in Telescope |

### Neogen

| Key                               | Action                                       |
| --------------------------------- | -------------------------------------------- |
| `<leader>nf` / `nc` / `nt` / `nn` | Generate function / class / type / file docs |

## Dependencies

### Required

| What                                  | Why                                        |
| ------------------------------------- | ------------------------------------------ |
| **Neovim 0.11+**                      | Native LSP config, snippets, commenting    |
| **Git 2.19+**                         | Plugins, gitsigns, lazygit                 |
| **Nerd Font**                         | Icons                                      |
| **C compiler** (gcc/clang) + **make** | Treesitter parsers, telescope-fzf-native   |
| **Node.js + npm**                     | LSP servers, prettier, eslint_d            |
| **neovim** npm package                | Node.js provider (`npm install -g neovim`) |
| **Python 3.8+** + **pip**             | Python provider, black, isort, pylint      |
| **pynvim**                            | Python provider (`pip install pynvim`)     |
| **ripgrep**                           | Telescope grep                             |
| **fd**                                | Telescope file finder                      |
| **LazyGit**                           | Git TUI                                    |

### Optional

| What                                        | Why                                                     |
| ------------------------------------------- | ------------------------------------------------------- |
| [**pyenv**](https://github.com/pyenv/pyenv) | Manage the `neovim-py` virtualenv (recommended)         |
| [**nvm**](https://github.com/nvm-sh/nvm)    | Manage Node.js versions (recommended)                   |
| **tmux**                                    | Only matters if you use vim-tmux-navigator              |
| **Go**                                      | gopls, gofmt, golangci-lint                             |
| **Rust** + `rustup component add rustfmt`   | rustfmt                                                 |
| **luarocks**                                | Native Lua C modules (config adds luarocks to cpath)    |
| **puppet-lint** (`gem install`)             | Not managed by Mason                                    |
| **GitHub Copilot** subscription             | copilot.vim is always loaded; `:Copilot auth` to set up |

Mason auto-installs most LSP servers, formatters, and linters. Exceptions: **pynvim** (pip), **puppet-lint** (gem), **gofmt** (ships with Go), **rustfmt** (rustup).

## Installation

```bash
git clone https://github.com/Mohabdo21/VIM-Configuration.git
cd VIM-Configuration
mv ~/.config/nvim ~/.config/nvim.bak
cp -r ./nvim ~/.config/
nvim  # lazy.nvim handles the rest
```

### Python Provider

The config auto-detects a Python with `pynvim`, checking in order:

1. `$VIRTUAL_ENV/bin/python`
2. `<cwd>/.venv/bin/python`
3. `~/.pyenv/versions/neovim-py/bin/python`
4. System `python3`

Re-checks on `DirChanged`, so project venvs work automatically.

One-time setup:

```bash
pyenv install -s 3.12.3
pyenv virtualenv 3.12.3 neovim-py
pyenv activate neovim-py
pip install --upgrade pip pynvim
```

Verify: `python -c "import pynvim; print(pynvim.__version__)"`

### Node.js Provider

```bash
npm install -g neovim
```

With nvm:

```bash
nvm install --lts && nvm use --lts
npm install -g neovim
```

Verify: `:checkhealth provider`

### Updating Neovim (AppImage)

```bash
chmod +x update_nvim.sh && ./update_nvim.sh
```

## Notes

- Mason installs servers/formatters/linters on first launch. Just open Neovim.
- Perl and Ruby providers are explicitly disabled.
- This is a personal config. Fork it, gut it, make it yours.
