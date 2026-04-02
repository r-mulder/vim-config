return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			-- LSP group
			{ "<leader>v",   group = "LSP" },
			{ "<leader>vr",  group = "Refactor" },
			-- Git
			{ "<leader>g",   group = "Git" },
			-- Copilot / Quickfix
			{ "<leader>c",   group = "Copilot/Quickfix" },
			-- Window splits
			{ "<leader>h",   group = "Window" },
			-- Paste / Project
			{ "<leader>p",   group = "Project/Paste" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
