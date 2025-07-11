return {
	"zaldih/themery.nvim",
	lazy = false,
	config = function()
		local themes = {
			{ name = "gruvbox", colorscheme = "gruvbox" },
			{ name = "everforest", colorscheme = "everforest" },
			{ name = "tokyonight-night", colorscheme = "tokyonight-night" },
			{ name = "tokyonight-day", colorscheme = "tokyonight-day" },
			{ name = "tokyonight-storm", colorscheme = "tokyonight-storm" },
			{ name = "tokyonight-moon", colorscheme = "tokyonight-moon" },
			{ name = "rose-pine", colorscheme = "rose-pine-main" },
			{ name = "rose-pine-dawn", colorscheme = "rose-pine-dawn" },
			{ name = "rose-pine-moon", colorscheme = "rose-pine-moon" },
			{ name = "gruvbox-material", colorscheme = "gruvbox-material" },
			{ name = "nightfly", colorscheme = "nightfly" },
			{ name = "kanagawa-wave", colorscheme = "kanagawa-wave" },
			{ name = "kanagawa-dragon", colorscheme = "kanagawa-dragon" },
			{ name = "kanagawa-lotus", colorscheme = "kanagawa-lotus" },
			{ name = "kanagawa-paper", colorscheme = "kanagawa-paper" },
			{ name = "catppuccin-latte", colorscheme = "catppuccin-latte" },
			{ name = "catppuccin-frappe", colorscheme = "catppuccin-frappe" },
			{ name = "catppuccin-macchiato", colorscheme = "catppuccin-macchiato" },
			{ name = "catppuccin-mocha", colorscheme = "catppuccin-mocha" },
			{ name = "onedark", colorscheme = "onedark" },
			{ name = "nightfox", colorscheme = "nightfox" },
			{ name = "dayfox", colorscheme = "dayfox" },
			{ name = "dawnfox", colorscheme = "dawnfox" },
			{ name = "duskfox", colorscheme = "duskfox" },
			{ name = "nordfox", colorscheme = "nordfox" },
			{ name = "terafox", colorscheme = "terafox" },
			{ name = "carbonfox", colorscheme = "carbonfox" },
			{ name = "ayu-dark", colorscheme = "ayu-dark" },
			{ name = "ayu-light", colorscheme = "ayu-light" },
			{ name = "ayu-mirage", colorscheme = "ayu-mirage" },
			{ name = "solarized-osaka", colorscheme = "solarized-osaka" },
			{ name = "nord", colorscheme = "nord" },
			{ name = "dracula", colorscheme = "dracula" },
			{ name = "melange", colorscheme = "melange" },
			{ name = "moonfly", colorscheme = "moonfly" },
			{ name = "bamboo", colorscheme = "bamboo" },
			{ name = "poimandres", colorscheme = "poimandres" },
			{ name = "miasma", colorscheme = "miasma" },
			{ name = "evergarden", colorscheme = "evergarden" },
			{ name = "nordic", colorscheme = "nordic" },
			{ name = "vague", colorscheme = "vague" },
			{ name = "zenbones", colorscheme = "zenbones" },
			{ name = "kanso-zen", colorscheme = "kanso-zen" },
			{ name = "kanso-ink", colorscheme = "kanso-ink" },
			{ name = "kanso-mist", colorscheme = "kanso-mist" },
			{ name = "kanso-pearl", colorscheme = "kanso-pearl" },
		}

		table.sort(themes, function(a, b)
			return a.name < b.name
		end)

		require("themery").setup({
			themes = themes,
		})
	end,
}
