local prettier = { "prettierd", "prettier", stop_after_first = true }

local prettier_fts = {
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"vue",
	"html",
	"css",
	"scss",
	"json",
	"jsonc",
	"yaml",
	"yml",
	"astro",
	"toml",
	"properties",
}

local formatters_by_ft = {
	lua = { "stylua" },
	python = { "isort", "black" },
	bash = { "shfmt" },
}

for _, ft in ipairs(prettier_fts) do
	formatters_by_ft[ft] = prettier
end

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader><leader>f",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format buffer",
		},
	},

	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = formatters_by_ft,
		default_format_opts = { lsp_format = "fallback" },
		format_on_save = { timeout_ms = 500 },
		notify_on_error = true,
		notify_no_formatters = true,
	},

	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
