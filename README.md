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

- `alpha-nvim`: A start screen plugin.
- `auto-session`: A session management plugin.
- `bufferline`: A plugin for enhanced buffer line.
- `colorizer`: A plugin for colorizing color codes.
- `colorscheme`: A plugin for managing colorschemes.
- `comment`: A plugin for easy code commenting.
- `dressing`: A plugin for code dressing.
- `formatting`: A plugin for code formatting.
- `gitsigns`: A plugin for showing git diff signs.
- `harpoon`: A plugin for navigation and terminal management.
- `lazygit`: A plugin for using lazygit in Neovim.
- `linting`: A plugin for linting code.
- `lualine`: A plugin for a fancy status line.
- `nvim-autopairs`: A plugin for auto pairing of brackets and quotes.
- `nvim-cmp`: A plugin for autocompletion.
- `nvim-surround`: A plugin for dealing with surroundings in Neovim.
- `nvim-tree`: A plugin for file explorer.
- `nvim-treesitter`: A plugin for incremental parsing.
- `nvim-web-devicons`: A plugin for file type icons.
- `substitute`: A plugin for enhanced substitute command.
- `telescope`: A plugin for fuzzy finding and picking things.
- `todo-comments`: A plugin for TODO comments.
- `vim-maximizer`: A plugin for maximizing and minimizing windows.
- `which-key`: A plugin for keybindings cheatsheet.

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
