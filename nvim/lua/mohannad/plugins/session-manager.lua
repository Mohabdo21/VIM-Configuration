return {
	"Shatur/neovim-session-manager",
	config = function()
		require("session_manager").setup({
			autoload_mode = require("session_manager.config").AutoloadMode.Disabled, -- Disable auto-load
		})

		-- Keybindings for session management
		vim.keymap.set("n", "<leader>ls", function()
			require("session_manager").load_session()
		end, { noremap = true, desc = "Load Session" })

		vim.keymap.set("n", "<leader>sn", function()
			require("session_manager").save_current_session()
		end, { noremap = true, desc = "Save Session" })
	end,
}
