return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		branch = "master",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		lazy = false,
		opts = {
			ignore_install = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
			auto_install = true,
			indent = {
				enable = true,
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						-- Function
						["if"] = "@function.inner",
						["af"] = "@function.outer",

						-- Return
						["ir"] = "@return.inner",
						["ar"] = "@return.outer",

						-- Class
						["iC"] = "@class.inner",
						["aC"] = "@class.outer",

						-- Parameter/Argument
						["ia"] = "@parameter.inner",
						["aa"] = "@parameter.outer",

						-- Number
						["in"] = "@number.inner",
						["an"] = "@number.outer",

						-- Conditional
						["ic"] = "@conditional.inner",
						["ac"] = "@conditional.outer",

						-- Loop
						["il"] = "@loop.inner",
						["al"] = "@loop.outer",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]s"] = { query = "@local.scope", query_group = "locals" },
						["]z"] = { query = "@fold", query_group = "folds" },
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[s"] = { query = "@local.scope", query_group = "locals" },
						["[z"] = { query = "@fold", query_group = "folds" },
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
			vim.treesitter.language.register("bash", "zsh")

			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

			vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
		end,
	},
}
