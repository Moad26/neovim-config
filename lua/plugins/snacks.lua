return {
	"folke/snacks.nvim",
	dependencies = {
		"echasnovski/mini.icons",
	},
	lazy = false,
	priority = 1000,

	---@type snacks.Config
	opts = {
		animate = { enabled = true },

		bigfile = { enabled = true },

		quickfile = { enabled = true },

		dashboard = {
			preset = {
				header = [[
ooooo      ooo oooooo     oooo ooooo ooo        ooooo 
`888b.     `8'  `888.     .8'  `888' `88.       .888' 
 8 `88b.    8    `888.   .8'    888   888b     d'888  
 8   `88b.  8     `888. .8'     888   8 Y88. .P  888  
 8     `88b.8      `888.8'      888   8  `888'   888  
 8       `888       `888'       888   8    Y     888  
o8o        `8        `8'       o888o o8o        o888o 
        ]],
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},

		explorer = { enabled = true },

		indent = { enabled = true },

		input = { enabled = true },

		scope = { enabled = true },

		notifier = {
			enabled = true,
			timeout = 3000,
			width = { min = 40, max = 0.4 },
			height = { min = 1, max = 0.6 },
			margin = { top = 0, right = 1, bottom = 0 },
			padding = true,
			sort = { "level", "added" },
			level = vim.log.levels.INFO,
			icons = {
				error = " ",
				warn = " ",
				info = " ",
				debug = " ",
				trace = "󱦹 ",
			},
			style = "compact",
		},

		statuscolumn = { enabled = true },

		words = { enabled = true },

		util = { enabled = true },

		zen = { enabled = true },

		scroll = { enabled = true },

		terminal = {
			enabled = true,
			win = {
				border = "rounded",
				style = "terminal",
			},
		},

		lazygit = {
			enabled = true,
			win = {
				border = "rounded",
				style = "lazygit",
			},
		},
	},

	keys = {
		{
			"<leader>un",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
		{
			"<leader>ud",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},

		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
		},
		{
			"<leader>Z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Toggle Zoom",
		},

		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
			desc = "LazyGit",
		},
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git Blame Line",
		},
		{
			"<leader>go",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Open in GitHub/GitLab",
		},

		{
			"<leader>tt",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
		},
	},

	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup notification redirect
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd
				vim.notify = Snacks.notifier.notify
			end,
		})
		vim.opt.inccommand = "split"
		vim.opt.pumblend = 10
	end,
}
