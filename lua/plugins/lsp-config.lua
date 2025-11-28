return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/lazydev.nvim", opts = {} },
	},
	config = function()
		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- Configure diagnostics display
		vim.diagnostic.config({
			virtual_text = {
				enabled = true,
				source = "always", -- Show source of diagnostic
				prefix = "●", -- Could be using "▎", "▍", etc.
			},
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always",
				prefix = " ",
				scope = "cursor",
				header = "",
				format = function(diagnostic)
					return string.format("%s (%s)", diagnostic.message, diagnostic.source)
				end,
			},
		})

		-- Define diagnostic signs
		local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		-- Get capabilities from nvim-cmp
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Add additional capabilities
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities.textDocument.completion.completionItem.resolveSupport = {
			properties = {
				"documentation",
				"detail",
				"additionalTextEdits",
			},
		}

		-- Common on_attach function for all LSPs
		local on_attach = function(client, bufnr)
			-- Enable completion triggered by <c-x><c-o>
			vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
		end

		-- C/C++
		vim.lsp.config.clangd = {
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
				"--function-arg-placeholders",
				"--fallback-style=llvm",
			},
			init_options = {
				usePlaceholders = true,
			},
		}

		-- Python
		vim.lsp.config.pyright = {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "workspace",
						useLibraryCodeForTypes = true,
						typeCheckingMode = "basic", -- or "strict"
						reportOperatorIssue = "none", -- Disables "Operator not supported" errors
						reportReturnType = "warning", -- Changes return type errors to warnings
						reportOptionalMemberAccess = "warning",
						reportOptionalOperand = "warning",
						reportOptionalSubscript = "warning",
						reportGeneralTypeIssues = "warning",
					},
				},
			},
		}

		-- JavaScript/TypeScript
		vim.lsp.config.ts_ls = {
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				-- Disable formatting in favor of prettier
				client.server_capabilities.documentFormattingProvider = false
				on_attach(client, bufnr)
			end,
			filetypes = {
				"typescript",
				"typescriptreact",
				"javascript",
				"javascriptreact",
			},
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
			},
		}

		-- GraphQL
		vim.lsp.config.graphql = {
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "graphql", "gql", "svelte", "astro", "vue" },
			root_dir = function(fname)
				return vim.fs.find({
					".graphqlrc*",
					".graphql.config.*",
					"graphql.config.*",
					"package.json",
				}, { upward = true, path = fname })[1]
			end,
		}

		-- HTML
		vim.lsp.config.html = {
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html", "templ" },
		}

		-- CSS
		vim.lsp.config.cssls = {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				css = {
					validate = true,
					lint = {
						unknownAtRules = "ignore",
					},
				},
				scss = {
					validate = true,
					lint = {
						unknownAtRules = "ignore",
					},
				},
				less = {
					validate = true,
					lint = {
						unknownAtRules = "ignore",
					},
				},
			},
		}

		-- Tailwind CSS
		vim.lsp.config.tailwindcss = {
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = {
				"html",
				"css",
				"scss",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"svelte",
			},
		}

		-- Emmet
		vim.lsp.config.emmet_ls = {
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = {
				"html",
				"css",
				"scss",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
			},
		}

		-- JSON
		vim.lsp.config.jsonls = {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				json = {
					validate = { enable = true },
					schemas = {
						{
							fileMatch = { "package.json" },
							url = "https://json.schemastore.org/package.json",
						},
						{
							fileMatch = { "tsconfig.json", "tsconfig.*.json" },
							url = "https://json.schemastore.org/tsconfig.json",
						},
					},
				},
			},
		}

		-- Lua
		vim.lsp.config.lua_ls = {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		}

		-- Markdown
		vim.lsp.config.marksman = {
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "markdown", "markdown.mdx" },
		}

		-- Bash
		vim.lsp.config.bashls = {
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "sh", "bash" },
			settings = {
				bashIde = {
					globPattern = "*@(.sh|.inc|.bash|.command)",
				},
			},
		}

		-- CMake
		vim.lsp.config.cmake = {
			capabilities = capabilities,
			on_attach = on_attach,
		}
		vim.lsp.config.tinymist = {
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "typst" },
			settings = {
				formatterMode = "typstyle",
				exportPdf = "never",
				semanticTokens = "disable",
			},
		}
	end,
}
