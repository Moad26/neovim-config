return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters.cpplint.args = {
			"--filter=-legal/copyright",
			"--linelength=120", -- Optional: adjust line length if needed
		}

		lint.linters_by_ft = {
			-- Python - Using Ruff as the primary linter
			python = {
				"ruff",
				-- Optionally keep mypy for type checking if you want static type analysis
				-- "mypy"
			},

			-- JavaScript/TypeScript
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },

			-- C/C++ (optional, clangd provides most diagnostics)
			c = { "cpplint" },
			cpp = { "cpplint" },

			-- JSON
			json = { "jsonlint" },

			-- Bash
			bash = { "shellcheck" },
			sh = { "shellcheck" },

			-- Markdown
			markdown = { "markdownlint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		local function file_in_cwd(file_name)
			return vim.fs.find(file_name, {
				upward = true,
				stop = vim.loop.cwd():match("(.+)/"),
				path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
				type = "file",
			})[1]
		end

		local function remove_linter(linters, linter_name)
			for k, v in pairs(linters) do
				if v == linter_name then
					linters[k] = nil
					break
				end
			end
		end

		local function linter_in_linters(linters, linter_name)
			for _, v in ipairs(linters) do
				if v == linter_name then
					return true
				end
			end
			return false
		end

		local function remove_linter_if_missing_config_file(linters, linter_name, config_file_names)
			if linter_in_linters(linters, linter_name) then
				local found = false
				for _, config_file in ipairs(config_file_names) do
					if file_in_cwd(config_file) then
						found = true
						break
					end
				end
				if not found then
					remove_linter(linters, linter_name)
				end
			end
		end

		local function try_linting()
			local linters = lint.linters_by_ft[vim.bo.filetype]
			--[[			if linters then
				-- Make a copy to avoid modifying the original table
				linters = vim.deepcopy(linters)

				-- Remove ESLint if no config file is found
				remove_linter_if_missing_config_file(linters, "eslint_d", {
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.json",
					"eslint.config.js",
					"eslint.config.mjs",
					".eslintrc.yaml",
					".eslintrc.yml",
				})

				-- Remove mypy if no config file is found (optional, mypy can work without config)
				-- remove_linter_if_missing_config_file(linters, "mypy", { "mypy.ini", ".mypy.ini", "pyproject.toml", "setup.cfg" })
				
				-- Remove ruff if no config file is found (optional, ruff works well with defaults)
				-- remove_linter_if_missing_config_file(linters, "ruff", { "ruff.toml", "pyproject.toml", ".ruff.toml" })
			end
]]

			lint.try_lint(linters)
		end

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				try_linting()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			try_linting()
		end, { desc = "Trigger linting for current file" })
	end,
}
