return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
  -- stylua: ignore 
	keys = {
		{
		  "<leader>st",
		  function() Snacks.picker("todo_comments", { keywords = { "TODO", "FIX", "FIXME" } }) end,
		  desc = "Todo/Fix/Fixme"
		},
	},
	opts = {},
}
