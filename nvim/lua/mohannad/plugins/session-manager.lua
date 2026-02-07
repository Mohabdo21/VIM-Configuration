return {
	"Shatur/neovim-session-manager",
	dependencies = { "nvim-lua/plenary.nvim" }, -- Ensure dependency is loaded
	config = function()
		local Path = require("plenary.path")
		local config = require("session_manager.config")
		local session_manager = require("session_manager")

		session_manager.setup({
			sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"), -- Default session storage location
			autoload_mode = config.AutoloadMode.Disabled, -- Fully manual session management
			autosave_last_session = false, -- Disable autosaving on exit/switch
			autosave_ignore_not_normal = true, -- Ignore if no writable buffers are open
			autosave_ignore_filetypes = { "gitcommit", "gitrebase" }, -- Ignore Git buffers
			autosave_ignore_buftypes = { "nofile", "terminal", "quickfix" }, -- Ignore special buffers
			autosave_only_in_session = true, -- Only autosave if a session is already active
			load_include_current = false, -- Hide currently active session in selection
		})

		-- Command to restore session for current directory
		vim.api.nvim_create_user_command("SessionRestoreCurrent", function()
			require("session_manager").load_current_dir_session()
		end, {})

		-- Keybindings for manual session management
		vim.keymap.set("n", "<leader>ls", function()
			session_manager.load_session(false)
		end, { noremap = true, desc = "Load Session" })

		vim.keymap.set("n", "<leader>sn", function()
			session_manager.save_current_session()
		end, { noremap = true, desc = "Save Session" })

		vim.keymap.set("n", "<leader>ds", function()
			session_manager.delete_session()
		end, { noremap = true, desc = "Delete Session" })

		vim.keymap.set("n", "<leader>cs", function()
			session_manager.delete_current_dir_session()
		end, { noremap = true, desc = "Delete Current Dir Session" })

		-- Open file tree after session load (optional)
		vim.api.nvim_create_autocmd("User", {
			pattern = "SessionLoadPost",
			callback = function()
				if package.loaded["nvim-tree.api"] then
					require("nvim-tree.api").tree.open()
				end
			end,
		})
	end,
}
