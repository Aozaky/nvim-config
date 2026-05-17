-- 取消搜索后高亮
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- 跳转到上个buffer
vim.keymap.set("n", "<C-Space><C-Space>", "<C-^>")

-- 行首行末跳转
vim.keymap.set({ "n", "v", "o" }, "H", "^")
vim.keymap.set({ "n", "v", "o" }, "L", "$")

-- 重启后保持会话
vim.keymap.set("n", "<leader>R", function()
	local session = vim.fn.stdpath("state") .. "/restart-session.vim"
	vim.cmd("mksession! " .. vim.fn.fnameescape(session))
	vim.cmd.restart("source " .. vim.fn.fnameescape(session))
end, { desc = "Restart Neovim and restore session" })
