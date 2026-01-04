return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			automatic_enable = true,
			ensure_installed = { "lua_ls" },
		},
		event = "VeryLazy",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			{ "neovim/nvim-lspconfig", dependencies = { "saghen/blink.cmp" } },
			{ "j-hui/fidget.nvim", event = "LspAttach", opts = {} },
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)
			vim.keymap.set("n", "<leader>cm", "<Cmd>Mason<Cr>", { desc = "Mason" })

			-- 全局 LSP 服务器配置
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end

			vim.lsp.config("*", {
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- 自定义 LSP 服务器配置
			vim.lsp.config.lua_ls = require("config.lsp.lua_ls")
			vim.lsp.config.bashls = require("config.lsp.bashls")
			vim.lsp.config.vtsls = require("config.lsp.vtsls")

			-- 快捷键
			local lsp_keymaps_group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })

			vim.api.nvim_create_autocmd("LspAttach", {
				group = lsp_keymaps_group,
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
					end

					local telescope = require("telescope.builtin")

					map("<leader>ds", telescope.lsp_document_symbols, "[D]ocument [S]ymbols")
					map("<leader>ws", telescope.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

					map("<leader>ca", "<Cmd>Lspsaga code_action<CR>")
					map("<leader>rn", "<Cmd>Lspsaga rename<CR>")
					map("gd", "<Cmd>Lspsaga goto_definition<CR>")
					map("gkd", "<Cmd>Lspsaga peek_definition<CR>")
					map("gr", "<Cmd>Lspsaga finder<CR>")
					map("]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>")
					map("[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>")
				end,
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		opts = {
			lightbulb = { enable = false },
		},
	},
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
