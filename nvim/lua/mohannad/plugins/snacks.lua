return {
	"folke/snacks.nvim",
	opts = {
		input = { enabled = true },
		picker = {
			actions = {
				opencode_send = function(picker)
					local items = vim.tbl_map(function(item)
						return item.file
								and require("opencode").format({
									path = item.file,
									from = item.pos,
									to = item.end_pos,
								})
							or item.text
					end, picker:selected({ fallback = true }))
					require("opencode").prompt(table.concat(items, ", ") .. " ")
				end,
			},
			win = {
				input = {
					keys = {
						["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
					},
				},
			},
		},
		image = {
			doc = {
				inline = false,
				float = false,
			},
			-- Resolve root-relative paths (e.g. /img/foo.png) against the project root.
			-- Falls back to the file's directory for truly relative paths.
			resolve = function(file, src)
				-- Only handle paths starting with "/" (root-relative in web projects)
				if src:sub(1, 1) ~= "/" then
					return nil -- let snacks use its default resolution
				end
				-- Find project root via common markers
				local root = vim.fs.root(
					file,
					{ ".git", "package.json", "Cargo.toml", "go.mod", ".root", "Makefile", "pyproject.toml" }
				)
				if root then
					local resolved = root .. src
					if vim.fn.filereadable(resolved) == 1 then
						return resolved
					end
				end
				return nil
			end,
		},
	},
	keys = {
		{
			"<leader>hi",
			function()
				Snacks.image.hover()
			end,
			desc = "Image Hover",
		},
	},
}
