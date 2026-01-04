return {
	"folke/flash.nvim",
	opts = {
		modes = {
			char = { enabled = false },
		},
	},
	event = "VeryLazy",
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
		{
			"r",
			function()
				require("flash").remote()
			end,
			mode = "o",
			desc = "Remote Flash",
		},
		{
			"R",
			function()
				require("flash").treesitter_search()
			end,
			mode = { "o", "x" },
			desc = "Treesitter Search",
		},
		{
			"<C-s>",
			function()
				require("flash").toggle()
			end,
			mode = { "c" },
			desc = "Toggle Flash Search",
		},
	},
}
