return {
	{
		"morhetz/gruvbox",
	},
	{
		"bluz71/vim-nightfly-guicolors",
		config = function()
			vim.g.nightflyItalics = true
			vim.g.nightflyCursorColor = true
			vim.g.nightflyNormalFloat = true
			vim.g.nightflyWinSeparator = 2
		end,
	},
	{
		"folke/tokyonight.nvim",
	},
	{
		"sainnhe/everforest",
		config = function()
			vim.g.everforest_enable_italic = true
			vim.g.everforest_background = "soft"
		end,
	},
	{
		"catppuccin/nvim",
	},
	{
		"rebelot/kanagawa.nvim",
	},
	{
		"sainnhe/gruvbox-material",
		config = function()
			vim.g.gruvbox_material_background = "hard" -- Change to "soft" or "medium" if needed
		end,
	},
	{
		"rose-pine/neovim",
	},
	{
		"navarasu/onedark.nvim",
	},
	{
		"EdenEast/nightfox.nvim",
	},
	{
		"Shatur/neovim-ayu",
	},
	{
		"craftzdog/solarized-osaka.nvim",
	},
	{
		"shaunsingh/nord.nvim",
	},
	{
		"Mofiqul/dracula.nvim",
	},
	{
		"savq/melange-nvim",
	},
	{ "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false },
	{
		"ribru17/bamboo.nvim",
	},
	{
		"olivercederborg/poimandres.nvim",
	},
	{
		"xero/miasma.nvim",
	},
	{
		"comfysage/evergarden",
		opts = {
			variant = "hard", -- 'hard'|'medium'|'soft'
			overrides = {}, -- add custom overrides
		},
	},
	{
		"AlexvZyl/nordic.nvim",
	},
	{
		"vague2k/vague.nvim",
	},
	{
		"zenbones-theme/zenbones.nvim",
		dependencies = { "rktjmp/lush.nvim" },
	},
	{
		"thesimonho/kanagawa-paper.nvim",
	},
	{
		"webhooked/kanso.nvim",
	},
}
