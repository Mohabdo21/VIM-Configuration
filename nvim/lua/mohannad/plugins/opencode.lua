return {
	"nickjvandyke/opencode.nvim",
	version = "*", -- Latest stable release
	config = function()
		---@type opencode.Opts
		vim.g.opencode_opts = {
			ask = {
				snacks = {
					icon = "󰚩 ",
					win = {
						title_pos = "left",
						relative = "cursor",
						row = -3,
						col = 0,
						border = "rounded",
					},
				},
			},
			select = {
				prompts = {
					refactor = "Refactor @this for better maintainability",
					types = "Add TypeScript types for @this",
					doc = "Document @this with comments",
					convert = "Convert @this to use a different approach or library",
				},
			},
			server = {
				start = function()
					require("snacks.terminal").open("opencode --port", {
						win = { position = "right", enter = false },
					})
				end,
			},
		}

		vim.o.autoread = true -- Required for `vim.g.opencode_opts.events.reload`

		-- Show/hide the terminal on <C-.>
		vim.keymap.set({ "n", "t" }, "<C-.>", function()
			require("snacks.terminal").toggle("opencode --port", {
				win = { position = "right", enter = false },
			})
		end, { desc = "Toggle OpenCode" })

		-- Recommended/example keymaps
		vim.keymap.set({ "n", "x" }, "<leader>oa", function()
			require("opencode").ask("@this: ")
		end, { desc = "Ask OpenCode" })
		vim.keymap.set({ "n", "x" }, "<leader>os", function()
			require("opencode").select()
		end, { desc = "Select OpenCode" })

		vim.keymap.set({ "n", "x" }, "go", function()
			return require("opencode").operator("@this ")
		end, { desc = "Append range to OpenCode", expr = true })
		vim.keymap.set("n", "goo", function()
			return require("opencode").operator("@this ") .. "_"
		end, { desc = "Append line to OpenCode", expr = true })

		vim.keymap.set("n", "<S-C-u>", function()
			require("opencode").command("session.half.page.up")
		end, { desc = "Scroll OpenCode up" })
		vim.keymap.set("n", "<S-C-d>", function()
			require("opencode").command("session.half.page.down")
		end, { desc = "Scroll OpenCode down" })
	end,
}
