return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = { "InsertEnter", "CmdwinEnter" },
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			keymap = {
				preset = "super-tab",
				["<C-h>"] = { "cancel", "fallback" },
				["<C-e>"] = false,
			},
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
			completion = {
				menu = {
					scrollbar = false,
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "kind" },
							{ "source_name" },
						},
					},
				},
				documentation = {
					auto_show = true,
					window = { scrollbar = false },
				},
				list = {
					selection = {
						preselect = function()
							return not require("blink.cmp").snippet_active({ direction = 1 })
						end,
					},
				},
				ghost_text = { enabled = false },
			},
			cmdline = {
				sources = function()
					local cmd_type = vim.fn.getcmdtype()
					if cmd_type == "/" or cmd_type == "?" then
						return { "buffer" }
					end
					if cmd_type == ":" then
						return { "cmdline" }
					end
					return {}
				end,
				keymap = { preset = "super-tab" },
				completion = {
					menu = { auto_show = true },
					ghost_text = { enabled = false },
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
