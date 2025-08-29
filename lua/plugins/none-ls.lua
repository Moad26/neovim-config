return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jay-babu/mason-null-ls.nvim",
		"williamboman/mason.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		require("mason-null-ls").setup({
			ensure_installed = {
				-- Python/Data Science
				"black",
				"ruff",
				"mypy",
				"isort",

				-- C/C++
				"clang-format",

				-- Shell
				"shellcheck",
				"shellharden",
				"beautysh",

				-- CMake
				"cmakelint",
				"cmakelang",

				-- Lua
				"stylua",

				-- Web Dev
				"prettier", -- JS/TS/HTML/CSS/JSON formatter
				"eslint_d", -- JS/TS linting
				"stylelint", -- CSS linting
			},
			automatic_installation = true,
		})

		null_ls.setup({
			sources = {
				-- Python/Data Science
				null_ls.builtins.formatting.black,
				null_ls.builtins.diagnostics.ruff,
				null_ls.builtins.diagnostics.mypy,
				null_ls.builtins.formatting.isort,

				-- C/C++
				null_ls.builtins.formatting.clang_format,

				-- Shell
				null_ls.builtins.diagnostics.shellcheck,
				null_ls.builtins.formatting.shellharden,
				null_ls.builtins.formatting.beautysh,

				-- CMake
				null_ls.builtins.diagnostics.cmakelint,
				null_ls.builtins.formatting.cmakelang,

				-- Lua
				null_ls.builtins.formatting.stylua,

				-- Web Dev
				null_ls.builtins.formatting.prettier,
				require("none-ls.diagnostics.eslint_d"),
				null_ls.builtins.diagnostics.stylelint,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
