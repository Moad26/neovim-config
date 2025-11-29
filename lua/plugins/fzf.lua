return {
	"ibhagwan/fzf-lua",
	dependencies = { "echasnovski/mini.icons" },
	opts = {},
	config = function()
		local fzf = require("fzf-lua")

		-- Register as vim.ui.select provider
		fzf.register_ui_select()

		-- Keymaps
		local keymap = vim.keymap.set

		-- File pickers
		keymap("n", "<C-p>", fzf.files, { desc = "Find Files" })
		keymap("n", "<leader>fg", fzf.live_grep, { desc = "Live Grep" })
		keymap("n", "<leader><leader>", fzf.oldfiles, { desc = "Recent Files" })

		-- LSP pickers
		keymap("n", "<leader>ds", fzf.lsp_document_symbols, { desc = "Document Symbols" })

		-- Additional useful pickers
		keymap("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
		keymap("n", "<leader>fh", fzf.help_tags, { desc = "Help Tags" })
		keymap("n", "<leader>fc", fzf.commands, { desc = "Commands" })
		keymap("n", "<leader>fk", fzf.keymaps, { desc = "Keymaps" })
		keymap("n", "<leader>fw", fzf.grep_cword, { desc = "Word Under Cursor" })
		keymap("n", "<leader>fr", fzf.resume, { desc = "Resume Last Picker" })

		-- Git pickers
		keymap("n", "<leader>gs", fzf.git_status, { desc = "Git Status" })
		keymap("n", "<leader>gc", fzf.git_commits, { desc = "Git Commits" })
		keymap("n", "<leader>gb", fzf.git_branches, { desc = "Git Branches" })
		keymap("n", "<leader>tc", fzf.colorschemes, { desc = "Switch Colorscheme" })
	end,
}
