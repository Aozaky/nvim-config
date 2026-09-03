return {
	{
		"nvim-mini/mini.nvim",
		event = "VeryLazy",
		version = false,
		config = function()
			require("mini.surround").setup()
			require("mini.move").setup()
			-- require("mini.cursorword").setup()

			require("mini.splitjoin").setup({
				mappings = { toggle = "J" },
			})

			require("mini.basics").setup({
				options = {
					basic = false,
				},
				mappings = {
					basic = true,
					windows = true,
					move_with_alt = true,
				},
				autocommands = {
					basic = true,
				},
			})
		end,
	},
	-- NOTE: mini.ai
	{
		"nvim-mini/mini.ai",
		config = function()
			local spec_treesitter = require("mini.ai").gen_spec.treesitter

			local equal_textobject = function(ai_type, _, opts)
				local regions = {}
				local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
				local n_lines = opts and opts.n_lines or 50
				local from_line = math.max(1, cursor_line - n_lines)
				local to_line = math.min(vim.api.nvim_buf_line_count(0), cursor_line + n_lines)

				local find_equal = function(line)
					local init = 1

					while true do
						local col = line:find("=", init, true)
						if col == nil then
							return nil
						end

						local prev = line:sub(col - 1, col - 1)
						local next = line:sub(col + 1, col + 1)
						if
							prev ~= "="
							and prev ~= "<"
							and prev ~= ">"
							and prev ~= "!"
							and prev ~= "~"
							and next ~= "="
							and next ~= ">"
						then
							return col
						end

						init = col + 1
					end
				end

				for line_num = from_line, to_line do
					local line = vim.fn.getline(line_num)
					local equal_col = find_equal(line)

					if equal_col ~= nil then
						local start_col = line:find("%S") or 1
						local end_col = line:find("%s*$") - 1
						local rhs_col = line:find("%S", equal_col + 1) or (equal_col + 1)
						local to = rhs_col > end_col and nil or { line = line_num, col = end_col }

						table.insert(regions, {
							from = { line = line_num, col = ai_type == "a" and start_col or rhs_col },
							to = ai_type == "a" and { line = line_num, col = end_col } or to,
						})
					end
				end

				return regions
			end

			require("mini.ai").setup({
				mappings = {
					around_next = "",
					inside_next = "",
					around_last = "",
					inside_last = "",
				},
				custom_textobjects = {
					-- function
					f = spec_treesitter({
						a = "@function.outer",
						i = "@function.inner",
					}),

					-- block
					B = spec_treesitter({
						a = "@block.outer",
						i = "@block.inner",
					}),

					-- return
					r = spec_treesitter({
						a = "@return.outer",
						i = "@return.inner",
					}),

					-- class
					C = spec_treesitter({
						a = "@class.outer",
						i = "@class.outer",
					}),

					-- comment
					c = spec_treesitter({
						a = "@comment.outer",
						i = "@comment.inner",
					}),

					-- number
					N = spec_treesitter({
						a = "@number.outer",
						i = "@number.outer",
					}),

					e = equal_textobject,
				},
			})
		end,
	},

	-- NOTE: mini.files
	{
		"nvim-mini/mini.files",
		opts = {},
		keys = { "<leader>ee" },
		config = function()
			local MiniFiles = require("mini.files")

			vim.keymap.set("n", "<leader>ee", function()
				MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
			end, { desc = "Open MiniFiles (current file)" })

			-- function: show_dotfiles
			-- keymap: g.
			local show_dotfiles = true

			local filter_show = function()
				return true
			end

			local filter_hide = function(fs_entry)
				return not vim.startswith(fs_entry.name, ".")
			end

			local toggle_dotfiles = function()
				show_dotfiles = not show_dotfiles
				local new_filter = show_dotfiles and filter_show or filter_hide
				minifiles.refresh({ content = { filter = new_filter } })
			end

			vim.api.nvim_create_autocmd("user", {
				pattern = "minifilesbuffercreate",
				callback = function(args)
					local buf_id = args.data.buf_id
					vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
				end,
			})
		end,
	},
}
