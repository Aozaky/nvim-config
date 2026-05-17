return {
	-- NOTE: mason
	{
		"mason-org/mason.nvim",
		lazy = false,
		keys = { { "<leader>cm", "<Cmd>Mason<Cr>", desc = "Mason" } },
		opts = { ui = { backdrop = 100, height = 0.8 } },
	},

	-- NOTE: fidget
	{ "j-hui/fidget.nvim", event = "LspAttach", opts = {} },

	-- NOTE: lspsaga
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		opts = {
			lightbulb = { enable = false },
		},
	},

	-- NOTE: lazydev
	{
		"folke/lazydev.nvim",
		ft = "lua",
		event = "LspAttach",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "LazyVim", words = { "LazyVim" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
			},
		},
	},
}
