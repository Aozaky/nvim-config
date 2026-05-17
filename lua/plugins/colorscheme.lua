local catppuccin = {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			styles = {
				keywords = { "italic" },
				comments = {},
			},
			specs = {
				{
					"akinsho/bufferline.nvim",
					optional = true,
					opts = function(_, opts)
						if (vim.g.colors_name or ""):find("catppuccin") then
							opts.highlights = require("catppuccin.special.bufferline").get_theme()
						end
					end,
				},
			},
		})
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}

local kanagawa = {
	"rebelot/kanagawa.nvim",
	name = "kanagawa",
	config = function()
		require("kanagawa").setup({
			colors = { theme = { all = { ui = { bg_gutter = "none" } } } },

			overrides = function(colors)
				local theme = colors.theme
				local makeDiagnosticColor = function(color)
					local c = require("kanagawa.lib.color")
					return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
				end

				return {
					BlinkCmpMenu = { bg = theme.ui.bg },
					BlinkCmpSource = { bg = theme.ui.bg },
					BlinkCmpMenuBorder = { fg = "", bg = theme.ui.bg },

					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },

					NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

					LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },

					DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
					DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
					DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
					DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
				}
			end,
		})
		vim.cmd.colorscheme("kanagawa")
	end,
}

local rose_pine = {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			dim_inactive_windows = false,
			extend_background_behind_borders = true,

			-- 修改高亮组
			highlight_groups = {
				BlinkCmpDoc = { bg = "base" },
			},

			-- 换色
			before_highlight = function(group, highlight, palette)
				if highlight.bg == palette.surface then
					highlight.bg = palette.base
				end
			end,
		})

		vim.cmd.colorscheme("rose-pine")
	end,
}

return rose_pine
