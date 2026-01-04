-- 取消搜索后高亮
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- 跳转到上个buffer
vim.keymap.set("n", "<C-Space><C-Space>", "<C-^>")

-- 行首行末跳转
vim.keymap.set({ "n", "v" }, "H", "^")
vim.keymap.set({ "n", "v" }, "L", "$")

-- 删除全局 LSP 默认键位
vim.keymap.del("n", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grt")
vim.keymap.del("n", "gO")
