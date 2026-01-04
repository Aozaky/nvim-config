return {
	{
		"nvim-mini/mini.files",
		opts = {},
		keys = { "<leader>ee" },
		config = function()
			-- NOTE: keymaps
			local MiniFiles = require("mini.files")

			-- vim.keymap.set("n", "<leader>ee", function()
			-- 	MiniFiles.open()
			-- end, { desc = "Open MiniFiles" })

			vim.keymap.set("n", "<leader>ee", function()
				MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
			end, { desc = "Open MiniFiles (current file)" })

			-- note: show_dotfiles
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
	{
		"nvim-mini/mini.nvim",
		event = "VeryLazy",
		version = false,
		config = function()
			require("mini.ai").setup()
			require("mini.surround").setup()
			require("mini.move").setup()

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

			require("mini.splitjoin").setup({
				mappings = { toggle = "J" },
			})
		end,
	},
}
