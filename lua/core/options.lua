-- 缩进设置
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 0

vim.o.autoread = true
vim.o.mouse = "a"

-- 外观
vim.o.cursorline = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.showmode = false
vim.o.winborder = "rounded"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.scrolloff = 10

-- 分屏
vim.o.splitbelow = true
vim.o.splitright = true

-- 搜索
vim.o.incsearch = true -- 边输入边搜索
vim.o.ignorecase = true
vim.o.smartcase = true

-- 折叠
-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.o.foldlevel = 99
-- vim.o.foldlevelstart = 99
-- vim.o.foldenable = true

-- 诊断配置
vim.schedule(function()
	vim.diagnostic.config({
		virtual_text = {
			spacing = 4,
			prefix = " ■",
		},
		virtual_lines = false,
		signs = true,
		underline = true,
		severity_sort = false,
	})
end)

-- 忽略 .zshrc 文件的语法检查
vim.api.nvim_create_autocmd("FileType", {
	pattern = "zsh",
	callback = function(args)
		if vim.api.nvim_buf_get_name(args.buf):match("%.zshrc$") then
			vim.diagnostic.enable(false, { bufnr = args.buf })
		end
	end,
})

-- 将 .env 文件识别为 dosini 类型
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	pattern = "*.env",
	callback = function()
		vim.bo.filetype = "dosini"
	end,
})
