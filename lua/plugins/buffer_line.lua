return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		vim.opt.termguicolors = true
		require("bufferline").setup({
			options = {
				separator_style = "thin", -- "slant", "thick", "thin", "slope"
				diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		})
	end,
}
