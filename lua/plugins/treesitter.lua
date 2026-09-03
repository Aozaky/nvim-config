return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter.setup", { clear = true }),
				callback = function(args)
					local language = vim.treesitter.language.get_lang(args.match) or args.match
					-- 跳过不存在的 parser
					if not require("nvim-treesitter.parsers")[language] then
						return
					end
					if not vim.treesitter.language.add(language) then
						-- NOTE: 自动安装
						require("nvim-treesitter").install(language)
						return
					end
					-- NOTE: 语法高亮
					vim.treesitter.start(args.buf, language)
					-- NOTE: 打开缩进
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			vim.g.no_plugin_maps = true
		end,

		config = function()
			require("nvim-treesitter-textobjects").setup({
				move = { set_jumps = true },
			})

			-- KEYMAPS
			local map_move = function(keys, func)
				vim.keymap.set({ "n", "x", "o" }, keys, func)
			end

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
		end,
	},
	{
		-- ghostty 高亮
		"bezhermoso/tree-sitter-ghostty",
		build = "make nvim_install",
	},
}
