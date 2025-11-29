return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/lazydev.nvim", opts = {} },
	},
	config = function()
		local keymap = vim.keymap
		local fzf = require("fzf-lua")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", fzf.lsp_references, opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", fzf.lsp_definitions, opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", fzf.lsp_implementations, opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", fzf.lsp_typedefs, opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", fzf.diagnostics_document, opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		-- Configure diagnostics display
		vim.diagnostic.config({
			virtual_text = {
				enabled = true,
				source = "always",
				prefix = "●",
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
		local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local on_attach = function(client, bufnr)
			vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
		end

		-- Configure all LSP servers
		-- C/C++
		vim.lsp.config.clangd = {
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=bundled",
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
						typeCheckingMode = "basic",
						reportOperatorIssue = "none",
						reportReturnType = "warning",
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
		}

		-- Bash
		vim.lsp.config.bashls = {
			capabilities = capabilities,
			on_attach = on_attach,
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

		-- Typst
		vim.lsp.config.tinymist = {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				formatterMode = "typstyle",
				exportPdf = "never",
				semanticTokens = "disable",
			},
		}

		vim.lsp.enable({
			"clangd",
			"pyright",
			"ts_ls",
			"graphql",
			"html",
			"cssls",
			"tailwindcss",
			"emmet_ls",
			"jsonls",
			"lua_ls",
			"marksman",
			"bashls",
			"cmake",
			"tinymist",
		})
	end,
}
