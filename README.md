# Neovim Configuration

This repository contains my personal Neovim configuration. It's set up to provide a richly featured, visually pleasing, and efficient text editing environment.

## Structure

The configuration is organized as follows:

- `init.lua`: This is the main configuration file that sources all other configuration files.
- `lazy-lock.json`: This file contains settings for the lazy-lock plugin.
- `lua/mohannad`: This directory contains all the Lua configuration files.
  - `core`: This directory contains core configuration files such as keymaps and options.
  - `lazy.lua`: This file contains configuration for lazy loading of plugins.
  - `plugins`: This directory contains configuration files for each individual plugin.

## Plugins

The configuration uses a variety of plugins to enhance Neovim's functionality. Here are some of the key plugins:

- `alpha-nvim.lua`: Alpha Nvim is a start screen plugin for Neovim.
- `auto-session.lua`: Auto Session is a plugin that allows you to save and load your Neovim sessions automatically.
- `bufferline.lua`: Bufferline is a plugin that provides a tab-like interface for managing buffers.
- `coc.lua`: Conquer of Completion (CoC) is a powerful autocompletion plugin with language server protocol support.
- `colorizer.lua`: Colorizer is a plugin that colorizes color codes in your code.
- `colorscheme.lua`: This file is used to configure the colorscheme of your Neovim.
- `comment.lua`: This plugin provides functionalities to comment and uncomment lines of code.
- `dressing.lua`: Dressing is a plugin that helps to manage and navigate between different windows in Neovim.
- `formatting.lua`: This plugin provides code formatting capabilities.
- `friendly-snippets.lua`: Friendly Snippets is a plugin that provides a collection of snippets for various programming languages.
- `gitsigns.lua`: GitSigns is a plugin that shows git diff markers in the sign column and stages changes via the buffer.
- `harpoon.lua`: Harpoon is a plugin that provides mark and navigation functionalities.
- `lazygit.lua`: LazyGit is a simple terminal UI for git commands.
- `linting.lua`: This plugin provides linting capabilities in Neovim.
- `lsp`: This directory contains configurations for the Language Server Protocol (LSP), which provides features like autocompletion, go to definition, and hover documentation.
- `lua-snip.lua`: Lua Snip is a fast snippet engine for Neovim.
- `lualine.lua`: Lualine is a lightweight and configurable status line plugin for Neovim.
- `neogen.lua`: Neogen is a plugin that helps you generate JSDoc comments.
- `nvim-autopairs.lua`: Nvim Autopairs is a plugin that automatically pairs brackets, quotes, etc.
- `nvim-cmp.lua`: Nvim Cmp is an autocompletion plugin for Neovim.
- `nvim-surround.lua`: Nvim Surround is a plugin that provides functionalities to deal with pairs of "surroundings".
- `nvim-tree.lua`: Nvim Tree is a file explorer tree for Neovim.
- `nvim-treesitter-text-objects.lua`: This plugin provides text objects based on the Treesitter AST.
- `nvim-treesitter.lua`: Nvim Treesitter is a plugin that provides syntax highlighting and other features based on the Treesitter parsing library.
- `nvim-web-devicons.lua`: Nvim Web Devicons is a plugin that provides icons for file types.
- `substitute.lua`: This plugin provides functionalities to substitute text.
- `telescope.lua`: Telescope is a highly extendable fuzzy finder over lists.
- `todo-comments.lua`: Todo Comments is a plugin that provides functionalities to manage TODO comments.
- `vim-maximizer.lua`: Vim Maximizer is a plugin that maximizes and minimizes windows in Vim.
- `which-key.lua`: Which Key is a plugin that displays available keybindings in popup menu.

## LSP

The configuration also includes setup for various Language Server Protocols (LSPs) to provide features like autocompletion, formatting, and linting for various programming languages.

## System Dependencies

This Neovim configuration requires several system dependencies to function correctly. Below is a comprehensive list of the required dependencies, categorized by their usage:

### General Requirements

1. **Neovim**: You should be running Neovim v0.9.0 or later.
2. **Git**: Many Neovim plugins are hosted on GitHub and are installed via Git. Ensure you have Git installed, preferably version 2.19.0 or later for partial clone support.
3. **Python**: Some plugins may require Python and the associated package manager pip. You may also need certain Python packages like `autopep8`, `black`, and `isort` for Python formatting and linting.
4. **Node.js and npm**: Required for plugins written in JavaScript or TypeScript, or for those providing language servers for JavaScript or TypeScript.
5. **Rust**: Required for plugins written in Rust or providing Rust language server support. Ensure you have Rust and its package manager Cargo installed.
6. **Go**: Required for plugins written in Go or providing Go language server support. Ensure you have Go installed.
7. **ShellCheck**: Required for shell script linting.
8. **CMake and build-essential**: Required for building some plugins from source.
9. **FUSE libraries**: Required for certain plugins.
10. **A Nerd Font**: Required for plugins that add icons to Neovim, such as `nvim-web-devicons`.

### Plugin-Specific Dependencies

1. **Alpha Nvim (`alpha-nvim.lua`)**: No additional dependencies.
2. **Auto Session (`auto-session.lua`)**: No additional dependencies.
3. **Bufferline (`bufferline.lua`)**: No additional dependencies.
4. **CoC (`coc.lua`)**:
   - **Node.js**: `npm install -g neovim`
   - Install language servers and extensions via `:CocInstall`.
5. **Colorizer (`colorizer.lua`)**: No additional dependencies.
6. **Colorscheme (`colorscheme.lua`)**: Specific colorschemes may require their own installation.
7. **Comment (`comment.lua`)**: No additional dependencies.
8. **Dressing (`dressing.lua`)**: No additional dependencies.
9. **Formatting (`formatting.lua`)**:
   - **Python**: `pip install black autopep8 isort`
   - **Node.js**: `npm install -g prettier eslint`
   - **Rust**: `cargo install rustfmt`
   - **Go**: `go get -u golang.org/x/tools/cmd/goimports`
10. **Friendly Snippets (`friendly-snippets.lua`)**: No additional dependencies.
11. **GitSigns (`gitsigns.lua`)**:
    - **Git**: Ensure Git is installed.
12. **Harpoon (`harpoon.lua`)**: No additional dependencies.
13. **LazyGit (`lazygit.lua`)**:
    - **LazyGit**: `brew install lazygit` (macOS) or follow installation instructions for other OS.
14. **Linting (`linting.lua`)**:
    - **Python**: `pip install pylint`
    - **Node.js**: `npm install -g eslint`
15. **LSP (`lsp`)**:
    - **Language Servers**: Install language servers using `:LspInstall` or manually.
    - **Python**: `pip install pylsp`
    - **Node.js**: `npm install -g typescript typescript-language-server`
    - **Rust**: `rustup component add rls rust-analysis rust-src`
    - **Go**: `go get -u golang.org/x/tools/gopls`
16. **LuaSnip (`lua-snip.lua`)**: No additional dependencies.
17. **Lualine (`lualine.lua`)**: No additional dependencies.
18. **Neogen (`neogen.lua`)**: No additional dependencies.
19. **Nvim Autopairs (`nvim-autopairs.lua`)**: No additional dependencies.
20. **Nvim Cmp (`nvim-cmp.lua`)**: No additional dependencies.
21. **Nvim Surround (`nvim-surround.lua`)**: No additional dependencies.
22. **Nvim Tree (`nvim-tree.lua`)**:
    - **Nerd Font**: Install a Nerd Font for file icons.
23. **Nvim Treesitter (`nvim-treesitter.lua`, `nvim-treesitter-text-objects.lua`)**:
    - **C Compiler**: Ensure you have a C compiler installed (e.g., `gcc` or `clang`).
24. **Nvim Web Devicons (`nvim-web-devicons.lua`)**:
    - **Nerd Font**: Install a Nerd Font for file icons.
25. **Substitute (`substitute.lua`)**: No additional dependencies.
26. **Telescope (`telescope.lua`)**:
    - **Ripgrep**: `brew install ripgrep` (macOS) or follow installation instructions for other OS.
    - **fd**: `brew install fd` (macOS) or follow installation instructions for other OS.
27. **Todo Comments (`todo-comments.lua`)**: No additional dependencies.
28. **Vim Maximizer (`vim-maximizer.lua`)**: No additional dependencies.
29. **Which Key (`which-key.lua`)**: No additional dependencies.

## Installation

### On Ubuntu

1. **Install Neovim**

   ```bash
   sudo apt update
   sudo apt install neovim
   ```
   If you faced any issues refer to official nvim [repo](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-download)

2. **Install Git**

   ```bash
   sudo apt install git
   ```

3. **Install Python and pip**

   ```bash
   sudo apt install python3 python3-pip
   ```

4. **Install Node.js and npm**

   ```bash
   sudo apt install nodejs npm
   ```

5. **Install Rust**

   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

6. **Install Go**

   ```bash
   sudo apt install golang
   ```

7. **Install ShellCheck**

   ```bash
   sudo apt install shellcheck
   ```

8. **Install CMake and build-essential**

   ```bash
   sudo apt install cmake build-essential
   ```

9. **Install FUSE libraries**

   ```bash
   sudo apt install fuse
   ```

10. **Install a Nerd Font**

    Download and install a Nerd Font from [Nerd Fonts GitHub](https://github.com/ryanoasis/nerd-fonts/releases).

### On macOS

1. **Install Neovim**

   ```bash
   brew install neovim
   ```
   If you faced any issues refer to official nvim [repo](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-download)

2. **Install Git**

   ```bash
   brew install git
   ```

3. **Install Python and pip**

   ```bash
   brew install python
   ```

4. **Install Node.js and npm**

   ```bash
   brew install node
   ```

5. **Install Rust**

   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

6. **Install Go**

   ```bash
   brew install go
   ```

7. **Install ShellCheck**

   ```bash
   brew install shellcheck
   ```

8. **Install CMake and build-essential**

   ```bash
   brew install cmake
   ```

9. **Install a Nerd Font**

   Download and install a Nerd Font from [Nerd Fonts GitHub](https://github.com/ryanoasis/nerd-fonts/releases).

## Usage

1. **Clone the Repository**

   ```bash
   git clone https://github.com/Mohabdo21/VIM-Configuration.git
   cd VIM-Configuration
   ```

2. **Backup Your Current Neovim Configuration**

   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

3. **Copy the New Configuration**

   ```bash
   cp -r ./nvim ~/.config/
   ```

4. **Run Neovim**

   ```bash
   nvim
   ```

### Notes

- Ensure you follow the official installation instructions for dependencies based on your operating system.
- The listed dependencies are comprehensive but may require adjustments based on specific plugins or updates to the configuration.

This configuration is personalized to my own usage. Feel free to modify it to suit your needs.
