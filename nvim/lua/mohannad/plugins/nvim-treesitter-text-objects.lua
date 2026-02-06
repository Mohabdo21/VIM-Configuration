return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	event = "BufReadPre",
	lazy = true,
	config = function()
		local ts_textobjects = require("nvim-treesitter-textobjects")
		local select = require("nvim-treesitter-textobjects.select")
		local swap = require("nvim-treesitter-textobjects.swap")
		local move = require("nvim-treesitter-textobjects.move")

		-- Configuration (behavior only — keymaps are explicit below)
		ts_textobjects.setup({
			select = {
				lookahead = true,
			},
			move = {
				set_jumps = true,
			},
		})

		-- ── Select textobjects ──────────────────────────────────────────

		local select_maps = {
			-- Assignments
			{ "a=", "@assignment.outer",  "Select outer part of an assignment" },
			{ "i=", "@assignment.inner",  "Select inner part of an assignment" },
			{ "l=", "@assignment.lhs",    "Select left hand side of an assignment" },
			{ "r=", "@assignment.rhs",    "Select right hand side of an assignment" },
			-- Properties (custom capture in after/queries/ecma/textobjects.scm)
			{ "a:", "@property.outer",    "Select outer part of an object property" },
			{ "i:", "@property.inner",    "Select inner part of an object property" },
			{ "l:", "@property.lhs",      "Select left part of an object property" },
			{ "r:", "@property.rhs",      "Select right part of an object property" },
			-- Parameters
			{ "aa", "@parameter.outer",   "Select outer part of a parameter/argument" },
			{ "ia", "@parameter.inner",   "Select inner part of a parameter/argument" },
			-- Conditionals
			{ "ai", "@conditional.outer", "Select outer part of a conditional" },
			{ "ii", "@conditional.inner", "Select inner part of a conditional" },
			-- Loops
			{ "al", "@loop.outer",        "Select outer part of a loop" },
			{ "il", "@loop.inner",        "Select inner part of a loop" },
			-- Function calls
			{ "af", "@call.outer",        "Select outer part of a function call" },
			{ "if", "@call.inner",        "Select inner part of a function call" },
			-- Function/method definitions
			{ "am", "@function.outer",    "Select outer part of a method/function definition" },
			{ "im", "@function.inner",    "Select inner part of a method/function definition" },
			-- Classes
			{ "ac", "@class.outer",       "Select outer part of a class" },
			{ "ic", "@class.inner",       "Select inner part of a class" },
		}

		for _, map in ipairs(select_maps) do
			local lhs, query, desc = map[1], map[2], map[3]
			vim.keymap.set({ "x", "o" }, lhs, function()
				select.select_textobject(query, "textobjects")
			end, { desc = desc })
		end

		-- ── Swap textobjects ────────────────────────────────────────────

		-- Swap next
		vim.keymap.set("n", "<leader>na", function()
			swap.swap_next("@parameter.inner")
		end, { desc = "Swap parameter/argument with next" })
		vim.keymap.set("n", "<leader>n:", function()
			swap.swap_next("@property.outer")
		end, { desc = "Swap object property with next" })
		vim.keymap.set("n", "<leader>nm", function()
			swap.swap_next("@function.outer")
		end, { desc = "Swap function with next" })

		-- Swap previous
		vim.keymap.set("n", "<leader>pa", function()
			swap.swap_previous("@parameter.inner")
		end, { desc = "Swap parameter/argument with prev" })
		vim.keymap.set("n", "<leader>p:", function()
			swap.swap_previous("@property.outer")
		end, { desc = "Swap object property with prev" })
		vim.keymap.set("n", "<leader>pm", function()
			swap.swap_previous("@function.outer")
		end, { desc = "Swap function with previous" })

		-- ── Move textobjects ────────────────────────────────────────────

		-- goto_next_start
		vim.keymap.set({ "n", "x", "o" }, "]f", function()
			move.goto_next_start("@call.outer", "textobjects")
		end, { desc = "Next function call start" })
		vim.keymap.set({ "n", "x", "o" }, "]m", function()
			move.goto_next_start("@function.outer", "textobjects")
		end, { desc = "Next method/function def start" })
		vim.keymap.set({ "n", "x", "o" }, "]c", function()
			move.goto_next_start("@class.outer", "textobjects")
		end, { desc = "Next class start" })
		vim.keymap.set({ "n", "x", "o" }, "]i", function()
			move.goto_next_start("@conditional.outer", "textobjects")
		end, { desc = "Next conditional start" })
		vim.keymap.set({ "n", "x", "o" }, "]l", function()
			move.goto_next_start("@loop.outer", "textobjects")
		end, { desc = "Next loop start" })
		vim.keymap.set({ "n", "x", "o" }, "]s", function()
			move.goto_next_start("@local.scope", "locals")
		end, { desc = "Next scope" })
		vim.keymap.set({ "n", "x", "o" }, "]z", function()
			move.goto_next_start("@fold", "folds")
		end, { desc = "Next fold" })

		-- goto_next_end
		vim.keymap.set({ "n", "x", "o" }, "]F", function()
			move.goto_next_end("@call.outer", "textobjects")
		end, { desc = "Next function call end" })
		vim.keymap.set({ "n", "x", "o" }, "]M", function()
			move.goto_next_end("@function.outer", "textobjects")
		end, { desc = "Next method/function def end" })
		vim.keymap.set({ "n", "x", "o" }, "]C", function()
			move.goto_next_end("@class.outer", "textobjects")
		end, { desc = "Next class end" })
		vim.keymap.set({ "n", "x", "o" }, "]I", function()
			move.goto_next_end("@conditional.outer", "textobjects")
		end, { desc = "Next conditional end" })
		vim.keymap.set({ "n", "x", "o" }, "]L", function()
			move.goto_next_end("@loop.outer", "textobjects")
		end, { desc = "Next loop end" })

		-- goto_previous_start
		vim.keymap.set({ "n", "x", "o" }, "[f", function()
			move.goto_previous_start("@call.outer", "textobjects")
		end, { desc = "Prev function call start" })
		vim.keymap.set({ "n", "x", "o" }, "[m", function()
			move.goto_previous_start("@function.outer", "textobjects")
		end, { desc = "Prev method/function def start" })
		vim.keymap.set({ "n", "x", "o" }, "[c", function()
			move.goto_previous_start("@class.outer", "textobjects")
		end, { desc = "Prev class start" })
		vim.keymap.set({ "n", "x", "o" }, "[i", function()
			move.goto_previous_start("@conditional.outer", "textobjects")
		end, { desc = "Prev conditional start" })
		vim.keymap.set({ "n", "x", "o" }, "[l", function()
			move.goto_previous_start("@loop.outer", "textobjects")
		end, { desc = "Prev loop start" })

		-- goto_previous_end
		vim.keymap.set({ "n", "x", "o" }, "[F", function()
			move.goto_previous_end("@call.outer", "textobjects")
		end, { desc = "Prev function call end" })
		vim.keymap.set({ "n", "x", "o" }, "[M", function()
			move.goto_previous_end("@function.outer", "textobjects")
		end, { desc = "Prev method/function def end" })
		vim.keymap.set({ "n", "x", "o" }, "[C", function()
			move.goto_previous_end("@class.outer", "textobjects")
		end, { desc = "Prev class end" })
		vim.keymap.set({ "n", "x", "o" }, "[I", function()
			move.goto_previous_end("@conditional.outer", "textobjects")
		end, { desc = "Prev conditional end" })
		vim.keymap.set({ "n", "x", "o" }, "[L", function()
			move.goto_previous_end("@loop.outer", "textobjects")
		end, { desc = "Prev loop end" })
	end,
}
