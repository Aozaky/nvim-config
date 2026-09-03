return {
	"folke/flash.nvim",
	opts = {
		modes = { char = { enabled = false } },
	},
	keys = {
		{
			"ss",
			function()
				require("flash").jump()
			end,
			mode = { "n", "x", "o" },
			desc = "Flash",
		},
		{
			"st",
			function()
				require("flash").treesitter()
			end,
			mode = { "n", "o" },
			desc = "Flash Treesitter",
		},
	},
}
