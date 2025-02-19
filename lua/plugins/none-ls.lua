return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {

				null_ls.builtins.formatting.shellharden,
				null_ls.builtins.formatting.stylua,
				--for c and cpp
        null_ls.builtins.formatting.clang_format,
				null_ls.builtins.diagnostics.cpplint,
        --for python
				null_ls.builtins.diagnostics.ruff,
				null_ls.builtins.diagnostics.mypy,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.black,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
