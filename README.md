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

This Neovim configuration requires several system dependencies to function correctly. Here's a list of the required dependencies:

1. **Neovim**: You should be running Neovim v0.9.0 or later.
2. **Git**: Many Neovim plugins are hosted on GitHub and are installed via Git. Make sure you have Git installed and it's at least version 2.19.0 for partial clones support.
3. **Python**: Some plugins may require Python and associated package manager pip. Also, certain Python packages might be needed depending on the plugins you use. For example, `autopep8`, `black`, and `isort` for Python formatting and linting.
4. **Node.js and npm**: If you're using any plugins that are written in JavaScript or TypeScript, or that provide features like JSON or TypeScript language servers, you'll need Node.js and npm (Node Package Manager).
5. **Rust**: If you're using any plugins that are written in Rust or that provide features like Rust language server, you'll need Rust and its package manager Cargo.
6. **Go**: If you're using any plugins that are written in Go or that provide features like Go language server, you'll need Go.
7. **ShellCheck**: If you're using any plugins for shell script linting, you might need ShellCheck.
8. **CMake and build-essential**: These are required for building some plugins from source.
9. **FUSE libraries**: These are required for some plugins.
10. **A Nerd Font**: Some plugins that add icons to Neovim (like `nvim-web-devicons`) require a Nerd Font to be installed.

## Usage

To use this configuration, clone this repository to your Neovim configuration directory and install the required plugins.

Please note that this configuration is personalized to my own usage. Feel free to modify it to suit your needs.
