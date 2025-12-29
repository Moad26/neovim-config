return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		local has_icon, mini_icons = pcall(require, "mini.icons")
		local static = {}
		local function setup_lualine()
			local function get_hl_color(group, attr)
				local color = vim.fn.synIDattr(vim.fn.hlID(group), attr)
				return color ~= "" and color or nil
			end

			local colors = {
				fg = get_hl_color("Normal", "fg") or "#bbc2cf",
				bg = get_hl_color("Normal", "bg") or "#202328",
				error = get_hl_color("DiagnosticError", "fg") or "#ec5f67",
				warn = get_hl_color("DiagnosticWarn", "fg") or "#ECBE7B",
				info = get_hl_color("DiagnosticInfo", "fg") or "#008080",
				hint = get_hl_color("DiagnosticHint", "fg") or "#98be65",
				added = get_hl_color("DiffAdd", "fg") or "#98be65",
				changed = get_hl_color("DiffChange", "fg") or "#FF8800",
				removed = get_hl_color("DiffDelete", "fg") or "#ec5f67",
				red = get_hl_color("Error", "fg") or "#ec5f67",
				green = get_hl_color("String", "fg") or "#98be65",
				blue = get_hl_color("Function", "fg") or "#51afef",
				violet = get_hl_color("Statement", "fg") or "#a9a1e1",
				magenta = get_hl_color("Keyword", "fg") or "#c678dd",
				cyan = get_hl_color("Type", "fg") or "#008080",
				yellow = get_hl_color("Number", "fg") or "#ECBE7B",
				orange = get_hl_color("Special", "fg") or "#FF8800",
			}

			-- Mode colors mapping
			local mode_colors = {
				n = colors.red,
				no = colors.red,
				cv = colors.red,
				ce = colors.red,
				["!"] = colors.red,
				t = colors.red,
				i = colors.green,
				v = colors.blue,
				[""] = colors.blue,
				V = colors.blue,
				c = colors.cyan,
				s = colors.orange,
				S = colors.orange,
				[""] = colors.orange,
				ic = colors.yellow,
				R = colors.violet,
				Rv = colors.violet,
				r = colors.cyan,
				rm = colors.cyan,
				["r?"] = colors.cyan,
			}

			local icons = {
				mode = "",
				git_branch = "",
				error = " ",
				warn = " ",
				info = " ",
				hint = " ",
				added = " ",
				modified = " ",
				modified_simple = "~ ",
				removed = " ",
				lock = "",
				modified_marker = "●",
			}
			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}
			local get_ftype_icon = function()
				if not has_icon then
					return ""
				end -- Safety check
				local file_name = vim.api.nvim_buf_get_name(0)
				local icon, hl, _ = mini_icons.get("file", file_name)
				local color = vim.fn.synIDattr(vim.fn.hlID(hl), "fg")
				static.ftype_icon = icon
				static.ftype_icon_color = color
				return static.ftype_icon and static.ftype_icon .. " "
			end
			-- Config
			local config = {
				options = {
					component_separators = "",
					section_separators = "",
					position = "top",
					theme = {
						normal = { c = { fg = colors.fg, bg = colors.bg } },
						inactive = { c = { fg = colors.fg, bg = colors.bg } },
					},
				},
				tabline = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
			}
			local function ins_left(component)
				table.insert(config.sections.lualine_c, component)
			end
			local function ins_right(component)
				table.insert(config.sections.lualine_x, component)
			end
			--[[ ins_left({
				function()
					return "|"
				end,
				color = { fg = colors.blue },
				padding = { left = 0, right = 1 },
			}) ]]

			ins_left({
				function()
					return icons.mode
				end,
				color = function()
					return { fg = mode_colors[vim.fn.mode()] }
				end,
				padding = { left = 1, right = 1 },
			})

			ins_left({
				function()
					if has_icon then
						return get_ftype_icon()
					end
				end,
				cond = conditions.buffer_not_empty,
				color = function()
					return { fg = static.ftype_icon_color }
				end,
				padding = { left = 1, right = 0 },
			})

			ins_left({
				"filename",
				cond = conditions.buffer_not_empty,
				color = { fg = colors.magenta, gui = "bold" },
				symbols = {
					modified = icons.modified_marker,
					readonly = icons.lock,
					unnamed = "[No Name]",
					newfile = "[New]",
				},
				padding = { left = 0, right = 0 },
			})

			ins_left({
				"location",
				color = { fg = colors.fg },
			})

			ins_left({
				"progress",
				color = { fg = colors.fg },
			})
			-- Diagnostics part
			ins_left({
				"diagnostics",
				sources = { "nvim_lsp", "nvim_diagnostic" },
				symbols = {
					error = icons.error,
					warn = icons.warn,
					info = icons.info,
					hint = icons.hint,
				},
				diagnostics_color = {
					error = { fg = colors.error },
					warn = { fg = colors.warn },
					info = { fg = colors.info },
					hint = { fg = colors.hint },
				},
			})

			-- Center divider
			ins_left({
				function()
					return "%="
				end,
			})

			ins_left({
				-- Lsp server name .
				function()
					local msg = "No Active Lsp"
					local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
					local clients = vim.lsp.get_clients()
					if next(clients) == nil then
						return msg
					end
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							return client.name
						end
					end
					return msg
				end,
				icon = " LSP:",
				color = { fg = colors.fg, gui = "bold" },
			})
			-- Right side
			ins_right({
				"diff",
				cond = conditions.check_git_workspace,
				symbols = {
					added = icons.added,
					modified = icons.modified,
					removed = icons.removed,
				},
				diff_color = {
					added = { fg = colors.added },
					modified = { fg = colors.changed },
					removed = { fg = colors.removed },
				},
			})

			ins_right({
				"branch",
				icon = icons.git_branch,
				color = { fg = colors.violet, gui = "bold" },
			})

			--[[ ins_right({
				function()
					return "|"
				end,
				color = { fg = colors.blue },
				padding = { left = 1 },
			}) ]]
			require("lualine").setup(config)
		end
		setup_lualine()
		-- Auto-reload lualine when colorscheme changes
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				-- Small delay to ensure colorscheme is fully loaded
				vim.defer_fn(function()
					setup_lualine()
				end, 100)
			end,
		})
	end,
}

--[[ return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				icons_enabled = true,
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
} ]]
