-- 删除全局 LSP 默认键位
vim.keymap.del("n", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grt")
vim.keymap.del("n", "gO")

-- blink.cmp 补全
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- 禁止格式化
local on_attach = function(client)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
end

vim.lsp.config("*", {
	capabilities = capabilities,
	on_attach = on_attach,
})

-- 快捷键
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
		end

		map("<leader>ca", "<Cmd>Lspsaga code_action<CR>")
		map("<leader>rn", vim.lsp.buf.rename)
		map("gd", "<Cmd>Lspsaga goto_definition<CR>")
		map("gkd", "<Cmd>Lspsaga peek_definition<CR>")
	end,
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("bashls")
vim.lsp.enable("vtsls")
vim.lsp.enable("qmlls")
vim.lsp.enable("rust_analyzer")
