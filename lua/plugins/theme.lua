return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},

	{
		"morhetz/gruvbox",
		lazy = true,
	},
	{
		"bluz71/vim-nightfly-guicolors",
		lazy = true,
		config = function()
			vim.g.nightflyItalics = true
			vim.g.nightflyCursorColor = true
			vim.g.nightflyNormalFloat = true
			vim.g.nightflyWinSeparator = 2
		end,
	},
	{
		"sainnhe/everforest",
		lazy = true,
		config = function()
			vim.g.everforest_enable_italic = true
			vim.g.everforest_background = "soft"
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
	},
	{
		"sainnhe/gruvbox-material",
		lazy = true,
		config = function()
			vim.g.gruvbox_material_background = "hard"
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
	},
	{
		"navarasu/onedark.nvim",
		lazy = true,
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = true,
	},
	{
		"Shatur/neovim-ayu",
		lazy = true,
	},
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = true,
	},
	{
		"shaunsingh/nord.nvim",
		lazy = true,
	},
	{
		"Mofiqul/dracula.nvim",
		lazy = true,
	},
	{
		"savq/melange-nvim",
		lazy = true,
	},
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = true,
	},
	{
		"ribru17/bamboo.nvim",
		lazy = true,
		config = function()
			require("bamboo").setup({})
		end,
	},
	{
		"olivercederborg/poimandres.nvim",
		lazy = true,
	},
	{
		"xero/miasma.nvim",
		lazy = true,
	},
	{
		"comfysage/evergarden",
		lazy = true,
		opts = {
			variant = "hard",
			overrides = {},
		},
	},
	{
		"AlexvZyl/nordic.nvim",
		lazy = true,
	},
	{
		"vague2k/vague.nvim",
		lazy = true,
	},
	{
		"zenbones-theme/zenbones.nvim",
		lazy = true,
		dependencies = { "rktjmp/lush.nvim" },
	},
	{
		"thesimonho/kanagawa-paper.nvim",
		lazy = true,
	},
	{
		"webhooked/kanso.nvim",
		lazy = true,
	},
	{
		"zootedb0t/citruszest.nvim",
		lazy = true,
	},
	{
		"datsfilipe/vesper.nvim",
		lazy = true,
	},
	{
		"sontungexpt/witch",
		lazy = true,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = true,
		config = function()
			vim.opt.background = "dark"
		end,
	},
	{
		"kvrohit/rasmus.nvim",
		lazy = true,
	},
	{
		"eldritch-theme/eldritch.nvim",
		lazy = true,
	},
	{
		"sam4llis/nvim-tundra",
		lazy = true,
	},
}
