return {
	"ThePrimeagen/harpoon",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("harpoon").setup({})
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")
		local keymap = vim.keymap.set

		keymap("n", "<leader>e", function()
			mark.add_file()
		end, { desc = "Harpoon: Add file" })
		keymap("n", "<C-e>", function()
			ui.toggle_quick_menu()
		end, { desc = "Harpoon: Toggle menu" })
	end,
}
