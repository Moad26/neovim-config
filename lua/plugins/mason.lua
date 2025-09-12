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
				"graphql", -- Add GraphQL LSP separately
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
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				-- Formatters
				"prettier", -- JS/TS/HTML/CSS/JSON/Markdown
				"stylua", -- Lua formatter
				"ruff", -- Python formatter/linter (replaces black, isort, flake8, pylint)
				"clang-format", -- C/C++ formatter

				-- Linters
				"eslint_d", -- Fast ESLint daemon
				"mypy", -- Python type checker
				"cpplint", -- C++ linter (optional)
				"jsonlint", -- JSON linter
				"markdownlint", -- Markdown linter

				-- Bash
				"shfmt", -- Shell formatter
				"shellcheck", -- Shell linter

				-- Additional tools
				"debugpy", -- Python debugger
				"taplo", -- TOML formatter
			},
		})
	end,
}
