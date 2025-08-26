return {
	"folke/snacks.nvim",
	dependencies = {
		"echasnovski/mini.icons",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	priority = 1000,

	---@type snacks.Config
	opts = {
		animate = { enabled = true }, -- smooth UI animations
		bigfile = { enabled = true }, -- optimize for large files
		dashboard = {
			sections = {
				{
					section = "terminal",
					cmd = "chafa ~/.config/nvim/walls/wall.png --format symbols --symbols vhalf --size 60x17 --stretch; sleep .1",
					height = 17,
					padding = 1,
				},
				{
					pane = 2,
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
				},
			},
		}, -- enhance alpha.nvim or other dashboards
		explorer = { enabled = true }, -- UI for file explorers like neo-tree
		indent = { enabled = true }, -- enhanced indent guides
		input = { enabled = true }, -- prettier command/input UI
		quickfile = { enabled = false }, -- set to true if you use it
		scope = { enabled = false }, -- enable if you want scope highlighting
		statuscolumn = { enabled = true }, -- line number + diagnostics formatting
		words = { enabled = true }, -- highlight repeated words
		util = { enabled = true }, -- utility functions for other snacks modules
	},
}
