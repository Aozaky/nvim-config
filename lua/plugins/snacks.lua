return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,

		---@type snacks.Config
		opts = {
			dashboard = {},
			bigfile = {},
			explorer = {},
			indent = {},
			notifier = {},
			picker = {
				sources = { explorer = { follow_file = true } },
				ui_select = true,
				layout = {
					layout = {
						backdrop = false,
						width = 0.8,
						min_width = 60,
					},
				},
				win = {
					input = {
						keys = { ["<Esc>"] = { "close", mode = { "n", "i" } } },
					},
				},
			},
		},

    -- stylua: ignore
		keys = {
      -- explorer
			{ "<leader>ef", function() Snacks.explorer.open() end },

      -- Search
			{ "<leader>sf", function() Snacks.picker.files() end, desc = "[S]earch [F]iles" },
      { "<leader>sb", function() Snacks.picker.buffers() end, desc = "[S]earch [B]uffers" },
      { "<leader>sr", function() Snacks.picker.recent() end, desc = "[S]earch [R]ecent Files" },
			{ "<leader>sg", function() Snacks.picker.grep() end, desc = "[S]earch by [G]rep" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
			{ "<leader>sh", function() Snacks.picker.help() end, desc = "[S]earch [H]elp" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sn", function() Snacks.picker.notifications() end, desc = "Notification History" },

      { "<leader>ds", function() Snacks.picker.lsp_symbols() end, desc ="[D]ocument [S]ymbols" },
      { "<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end, desc ="[W]orkspace [S]ymbols" },

      -- Git
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "GitStatus" },

      -- LSP
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      {
        "<leader>sc",
        function()
          Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "查找配置文件",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.lines({
            layout = { preset = "select", layout = { height = 0.5 } },
          })
        end,
        desc = "在当前缓冲区查找",
      },
		},
	},
}
