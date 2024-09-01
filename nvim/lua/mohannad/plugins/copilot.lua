return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	opts = {
		suggestion = {
			enabled = true,
			auto_trigger = true, -- Automatically trigger suggestions as you type
			keymap = {
				accept = "<Tab>", -- Optional: Set <Tab> to accept suggestion
				next = "<C-n>", -- Optional: Set Ctrl+N to show next suggestion
				prev = "<C-p>", -- Optional: Set Ctrl+P to show previous suggestion
			},
		},
		panel = {
			enabled = false, -- Disable the panel by default (can be enabled as needed)
		},
	},
}
