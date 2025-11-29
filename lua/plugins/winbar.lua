return {
	"Bekaboo/dropbar.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	config = function()
		local dropbar_api = require("dropbar.api")

		vim.keymap.set("n", "<leader>db", dropbar_api.pick, { desc = "Pick from dropbar" })
		vim.keymap.set("n", "<leader>do", dropbar_api.goto_context_start, { desc = "Open dropbar menu" })
		vim.keymap.set("n", "<leader>dn", dropbar_api.select_next_context, { desc = "Open dropbar menu" })
	end,
}
