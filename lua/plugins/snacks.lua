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
		},
		keys = {
			{
				"<leader>ef",
				function()
					Snacks.explorer.open()
				end,
			},
		},
	},
}
