return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				-- no separators
				section_separators = "",
				component_separators = "",

				-- dotted
				--section_separators = { left = '•', right = '•' },
				--component_separators = { left = '∙', right = '∙' },
				--
				--slang style
				--section_separators = { left = '', right = '' },
				--component_separators = { left = '', right = '' },
				--
				--arrows
				--section_separators = { left = '', right = '' },
				--component_separators = { left = '', right = '' },
			},
		})
	end,
}
