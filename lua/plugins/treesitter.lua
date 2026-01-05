return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "main",
		lazy = false,
		config = function()
			vim.treesitter.language.register("bash", "zsh")
		end,
	},
	{
		"MeanderingProgrammer/treesitter-modules.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			ignore_install = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			vim.g.no_plugin_maps = true
		end,

		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = { lookahead = true },
				move = { set_jumps = true },
			})

			-- KEYMAPS
			local map_select = function(keys, func)
				vim.keymap.set({ "x", "o" }, keys, func)
			end

			local map_move = function(keys, func)
				vim.keymap.set({ "n", "x", "o" }, keys, func)
			end

			local select = require("nvim-treesitter-textobjects.select").select_textobject
			local goto_next = require("nvim-treesitter-textobjects.move").goto_next_start
			local goto_previous = require("nvim-treesitter-textobjects.move").goto_previous_start
			local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

			-- REPEAT
			map_move(";", ts_repeat_move.repeat_last_move_next)
			map_move(",", ts_repeat_move.repeat_last_move_previous)

			vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

			-- MOVE
			-- function
			map_move("]f", function()
				goto_next("@function.outer", "textobjects")
			end)
			map_move("[f", function()
				goto_previous("@function.outer", "textobjects")
			end)

			-- scope
			map_move("]s", function()
				goto_next("@local.scope", "locals")
			end)
			map_move("[s", function()
				goto_previous("@local.scope", "locals")
			end)

			-- fold
			map_move("]z", function()
				goto_next("@fold", "folds")
			end)
			map_move("[z", function()
				goto_previous("@fold", "folds")
			end)

			-- SELECT
			-- function
			map_select("if", function()
				select("@function.inner", "textobjects")
			end)
			map_select("af", function()
				select("@function.outer", "textobjects")
			end)

			-- return
			map_select("ir", function()
				select("@return.inner", "textobjects")
			end)
			map_select("ar", function()
				select("@return.outer", "textobjects")
			end)

			-- Class
			map_select("iC", function()
				select("@class.outer", "textobjects")
			end)
			map_select("aC", function()
				select("@class.outer", "textobjects")
			end)

			-- arugument
			map_select("ia", function()
				select("@parameter.outer", "textobjects")
			end)
			map_select("aa", function()
				select("@parameter.outer", "textobjects")
			end)

			-- number
			map_select("in", function()
				select("@number.outer", "textobjects")
			end)
			map_select("an", function()
				select("@number.outer", "textobjects")
			end)

			-- conditional
			map_select("ic", function()
				select("@conditional.outer", "textobjects")
			end)
			map_select("ac", function()
				select("@conditional.outer", "textobjects")
			end)

			-- loop
			map_select("il", function()
				select("@loop.outer", "textobjects")
			end)
			map_select("al", function()
				select("@loop.outer", "textobjects")
			end)
		end,
	},
}
