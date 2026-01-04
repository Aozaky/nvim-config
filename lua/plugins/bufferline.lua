return {
	"akinsho/bufferline.nvim",
  event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		options = {
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,
		},
	},
	keys = {
		{ "<C-[>", "<Cmd>BufferLineCyclePrev<CR>", silent = true },
		{ "<C-]>", "<Cmd>BufferLineCycleNext<CR>", silent = true },
		{ "<leader>bd", "<Cmd>bdelete<CR>", silent = true },
		{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", silent = true },
		{ "<leader>bp", "<Cmd>BufferLinePick<CR>", silent = true },
	},
}
