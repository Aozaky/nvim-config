return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ [[<C-\><C-\>]], mode = { "n", "t" }, "<cmd>ToggleTerm<cr>" },
		{ [[<C-\>1]], mode = { "n", "t" }, "<cmd>1ToggleTerm<cr>" },
		{ [[<C-\>2]], mode = { "n", "t" }, "<cmd>2ToggleTerm<cr>" },
		{ [[<C-\>3]], mode = { "n", "t" }, "<cmd>3ToggleTerm<cr>" },
	},
	opts = {
		insert_mappings = true,
		terminal_mappings = true,
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*toggleterm#*",
			callback = function()
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { buffer = 0 })
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { buffer = 0 })
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { buffer = 0 })
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { buffer = 0 })
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { buffer = 0 })
			end,
		})
	end,
}
