return {
	"rachartier/tiny-code-action.nvim",
	dependencies = {
		"ibhagwan/fzf-lua",
		{
			"folke/snacks.nvim",
			opts = {
				terminal = {},
			},
		},
	},
	event = "LspAttach",
	opts = {},
}
