return {
	"folke/snacks.nvim",
	dependencies = {
		"echasnovski/mini.icons",
	},
	lazy = false,
	priority = 1000,

	---@type snacks.Config
	opts = {
		-- Smooth UI animations
		animate = { enabled = true },

		-- Optimize for large files
		bigfile = { enabled = true },

		-- Dashboard configuration
		dashboard = {
			preset = {
				header = [[
                                                              
    _/      _/     _/      _/       _/_/_/       _/      _/   
   _/_/    _/     _/      _/         _/         _/_/  _/_/    
  _/  _/  _/     _/      _/         _/         _/  _/  _/     
 _/    _/_/       _/  _/           _/         _/      _/      
_/      _/         _/           _/_/_/       _/      _/       
                                                              
                                                              
        ]],
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},

		-- UI for file explorers
		explorer = { enabled = true },

		-- Enhanced indent guides
		indent = { enabled = true },

		-- Prettier command/input UI (replaces noice input)
		input = { enabled = true },

		-- Notification system (replaces nvim-notify + noice notify)
		notifier = {
			enabled = true,
			timeout = 3000, -- default timeout in ms
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
			style = "compact", -- "compact" or "fancy" or "minimal"
		},

		-- Quick file opening
		quickfile = { enabled = false },

		-- Scope highlighting
		scope = { enabled = false },

		-- Line number + diagnostics formatting (replaces noice statuscolumn)
		statuscolumn = { enabled = true },

		-- Highlight repeated words
		words = { enabled = true },

		-- Utility functions
		util = { enabled = true },

		-- Command palette and search UI (replaces noice command_palette and bottom_search)
		zen = { enabled = false }, -- optional: zen mode

		-- Scroll improvements (replaces noice smooth scrolling)
		scroll = { enabled = true },

		-- Terminal integration
		terminal = {
			enabled = true,
			win = {
				border = "rounded",
				style = "terminal",
			},
		},

		--Lazygit implementation
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
		-- Terminal
		{
			"<leader>tt",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
		},
		-- Lazygit commands
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
			desc = "LazyGit (Root Dir)",
		},
		-- Dismiss all notifications
		{
			"<leader>ud",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
	},

	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup notification redirect
				-- This makes vim.notify use Snacks notifier
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd

				-- Redirect vim.notify to Snacks
				vim.notify = Snacks.notifier.notify
			end,
		})
		vim.opt.inccommand = "split" -- Show preview of substitutions in split

		-- Better wildmenu (command completion)
		vim.opt.pumblend = 10
	end,
}
