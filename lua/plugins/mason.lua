return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				-- Web development
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"emmet_ls",
				"jsonls",
				-- Python
				"pyright",
				-- C/C++
				"clangd",
				-- Lua (for Neovim config)
				"lua_ls",
				-- Markdown
				"marksman",
				-- Shell scripting
				"bashls",
				-- Build systems
				"cmake",
				-- GraphQL (if you use it)
				"graphql",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				-- Formatters
				"prettier", -- JS/TS/HTML/CSS/JSON/Markdown
				"stylua", -- Lua formatter
				"black", -- Python formatter
				"isort", -- Python import sorter
				"clang-format", -- C/C++ formatter

				-- Linters
				"eslint_d", -- Fast ESLint daemon
				"pylint", -- Python linter
				"flake8", -- Alternative Python linter
				"mypy", -- Python type checker
				"cpplint", -- C++ linter (optional)
				--"bash", -- Bash linter
				"markdownlint", -- Markdown

				-- Additional tools
				"debugpy", -- Python debugger
			},
		})
	end,
}
