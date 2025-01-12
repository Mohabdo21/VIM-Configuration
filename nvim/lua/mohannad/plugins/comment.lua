return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		-- Import comment plugin safely
		local comment = require("Comment")

		-- Import ts_context_commentstring integration
		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		-- Enable comment
		comment.setup({
			-- Required fields
			padding = true, -- Add a space between the comment symbol and the comment text
			sticky = true, -- Keep the cursor in place when commenting
			ignore = "^#|^//|TODO",
			mappings = { -- Define custom mappings (optional)
				basic = true, -- Enable basic mappings (gcc, gbc, etc.)
				extra = false, -- Disable extra mappings
			},
			toggler = { -- Toggle comments for single and multiple lines
				line = "gcc", -- Toggle single-line comments
				block = "gbc", -- Toggle block comments
			},
			opleader = { -- Operator-pending mappings
				line = "gc", -- Comment/uncomment lines
				block = "gb", -- Comment/uncomment blocks
			},
			extra = { -- Additional mappings (optional)
				above = "gcO", -- Add comment above the current line
				below = "gco", -- Add comment below the current line
				eol = "gcA", -- Add comment at the end of the line
			},
			post_hook = function() end,

			-- For commenting tsx and jsx files
			pre_hook = ts_context_commentstring.create_pre_hook(),
		})
	end,
}
