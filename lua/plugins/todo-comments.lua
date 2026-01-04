return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	keys = {
		{ "<leader>st", "<Cmd>TodoTelescope keywords=TODO,FIX<Cr>", desc = "[S]earch [T]odo" },
	},
	opts = {
		merge_keywords = false,
		keywords = {
			FIX = {
				icon = " ",
				color = "error",
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
			},
			TODO = { icon = " ", color = "info" },
			HACK = { icon = " ", color = "warning" },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
		},
		highlight = {
			pattern = [[.*<(KEYWORDS)\s*]],
		},
		search = {
			pattern = [[\b(KEYWORDS)\s*]],
		},
	},
}
